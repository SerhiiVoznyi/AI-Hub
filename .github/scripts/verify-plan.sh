#!/usr/bin/env bash
# Verify the planning agent left exactly one added/untracked file at PLAN_PATH
# with required frontmatter and section headings.
# Usage: verify-plan.sh <plan-path>
set -euo pipefail

PLAN_PATH="${1:-}"
if [[ -z "${PLAN_PATH}" ]]; then
  echo "::error::plan path is required"
  exit 1
fi

if [[ ! -f "${PLAN_PATH}" ]]; then
  echo "::error::Expected plan file missing: ${PLAN_PATH}"
  exit 1
fi

mapfile -t status_lines < <(git status --porcelain)
if [[ "${#status_lines[@]}" -eq 0 ]]; then
  echo "::error::Working tree clean; agent did not create ${PLAN_PATH}"
  exit 1
fi

other=()
plan_seen=0
for line in "${status_lines[@]}"; do
  path="${line:3}"
  if [[ "${path}" == *" -> "* ]]; then
    path="${path##* -> }"
  fi
  if [[ "${path}" == "${PLAN_PATH}" ]]; then
    plan_seen=1
  else
    other+=("${line}")
  fi
done

if [[ "${#other[@]}" -gt 0 ]]; then
  echo "::error::Unexpected working tree changes (only ${PLAN_PATH} is allowed):"
  printf '%s\n' "${other[@]}"
  exit 1
fi

if [[ "${plan_seen}" -ne 1 ]]; then
  echo "::error::Plan path ${PLAN_PATH} is not present in git status"
  git status --porcelain
  exit 1
fi

if ! awk '
  BEGIN { in_fm=0; found=0 }
  /^---[[:space:]]*$/ {
    if (in_fm==0) { in_fm=1; next }
    else { found=1; exit }
  }
  END { exit found ? 0 : 1 }
' "${PLAN_PATH}"; then
  echo "::error::Plan file is missing YAML frontmatter delimited by ---"
  exit 1
fi

fm="$(awk 'BEGIN{n=0} /^---[[:space:]]*$/{n++; next} n==1{print} n==2{exit}' "${PLAN_PATH}")"

required_keys=(jira_key jira_url repository branch base_commit generated_at status supersedes blocking_questions confidence)
for key in "${required_keys[@]}"; do
  if ! echo "${fm}" | grep -Eq "^${key}:"; then
    echo "::error::Frontmatter missing required key: ${key}"
    exit 1
  fi
done

required_sections=(
  "Summary"
  "Acceptance criteria"
  "Assumptions and blocking questions"
  "Current-state analysis"
  "Proposed approach"
  "Ordered task list"
  "Contract / data / migration changes"
  "Test plan"
  "Non-functional considerations"
  "Rollout and feature flags"
  "Risks and blast radius"
  "Out of scope"
  "Effort estimate"
)

body="$(awk 'BEGIN{n=0} /^---[[:space:]]*$/{n++; next} n>=2{print}' "${PLAN_PATH}")"
for section in "${required_sections[@]}"; do
  if ! echo "${body}" | grep -Eqi "^#+[[:space:]]*${section}[[:space:]]*$"; then
    echo "::error::Missing required section heading: ${section}"
    exit 1
  fi
done

echo "Verified plan artifact at ${PLAN_PATH}"
