Set wshShell = WScript.CreateObject("WScript.Shell")

' Give yourself 5 seconds to switch to the correct window
WScript.Sleep 15000 

Do
    ' Sends the F15 key
    wshShell.SendKeys "{F15}"
    
    ' Wait 20000 milliseconds (20 seconds)
    WScript.Sleep 20000
Loop