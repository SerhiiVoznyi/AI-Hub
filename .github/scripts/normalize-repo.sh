#!/usr/bin/env bash
# Normalise a GitHub repository URL or owner/name to owner/name.
# Usage: normalize-repo.sh <url-or-owner-name>
# Prints owner/name to stdout.
set -euo pipefail

raw="${1:-}"
if [[ -z "${raw}" ]]; then
  echo "::error::repository is required" >&2
  exit 1
fi

# Strip whitespace
raw="$(echo "${raw}" | tr -d '[:space:]')"

# https://github.com/owner/name(.git)? or git@github.com:owner/name.git
if [[ "${raw}" =~ ^https://github\.com/([^/]+)/([^/]+)(\.git)?/?$ ]]; then
  owner="${BASH_REMATCH[1]}"
  name="${BASH_REMATCH[2]}"
  name="${name%.git}"
  echo "${owner}/${name}"
  exit 0
fi

if [[ "${raw}" =~ ^git@github\.com:([^/]+)/([^/]+)(\.git)?$ ]]; then
  owner="${BASH_REMATCH[1]}"
  name="${BASH_REMATCH[2]}"
  name="${name%.git}"
  echo "${owner}/${name}"
  exit 0
fi

if [[ "${raw}" =~ ^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$ ]]; then
  echo "${raw}"
  exit 0
fi

echo "::error::Unsupported repository value: ${raw}" >&2
exit 1
