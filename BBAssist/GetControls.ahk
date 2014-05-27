#NoEnv
SendMode Input 
SetWorkingDir %A_ScriptDir% 
#SingleInstance
DetectHiddenText On

i=0

GetControls:
{
;IfWinActive, Amdocs
{
WinGetActiveTitle, CurrentWinTitle
StatusBarGetText, statusbartext, 2, %CurrentWinTitle%
StringRight, CaseId, statusbartext, 8
WinGet, WinGetResults, ControlListHwnd, %CurrentWinTitle%
i++
Name=%CaseId%-%i%.txt

Loop, parse, WinGetResults, `n, `r
{
ControlGetText, test, , ahk_id %A_LoopField%
; 2 - 0x170938 -  Case 10316185
FileAppend, %A_Index% - %A_LoopField% - %test%`r`n, %Name%




}
}
}




return



Home::
{
Gosub, GetControls
}
return

End::
{
ExitApp
}