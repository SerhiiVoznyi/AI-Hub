Set wshShell = WScript.CreateObject("WScript.Shell")
startTime = Now

MsgBox "Keep-alive started at: " & FormatDateTime(startTime, vbGeneralDate) & vbCrLf & _
    "It will run until manually stopped.", _
    vbInformation, "Keep Alive"

' Give yourself 15 seconds to switch to the correct window
WScript.Sleep 15000

Do
    ' Sends the F15 key
    wshShell.SendKeys "{F15}"
    
    ' Wait 20000 milliseconds (20 seconds)
    WScript.Sleep 20000
Loop