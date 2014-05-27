/*
 * Author           : Joseph Hosemann	(JosephHo)
 * Script Name      : BBAssist
 * Script Version   : 0.0.9a
 * Homepage         : http://www.autohotkey.com/forum/topic61379.html#376087
 *
 * Creation Date    : November, 15, 2010 
 * Modification Date: November 27, 2010
 *
 */
 
;+--> ; ---------[Directives]---------

#NoEnv
#SingleInstance Force
#Include lib\Array.ahk
#Include modules\Clarify.ahk
#Include modules\Utilities.ahk

SendMode Input
SetWorkingDir %A_ScriptDir%

DetectHiddenText Off
;-

;+--> ; ---------[Basic Info]---------

s_name      := "BBAssist"     ; Script Name
s_version   := "0.0.9a"                ; Script Version
s_author    := "Joseph Hosemann (JosephHo)"                ; Script Author
s_email     := "joseph.hosemann@blackbaud.com"     ; Author's contact email
;-

;+--> ; ---------[Import Options]--------
IniRead, Analyst, options.ini, General, Analyst
IniRead, Department, options.ini, General, Department
;-

;+--> ; ---------[General Variables]---------

LongDelay=1000
NormalDelay=500
ShortDelay=200
TinyDelay=50

Debug=1

;-

if Debug=1
	Gosub, DevLog

return

DevLog:
{
	Gui, Add, Edit, x196 y177 w0 h-10 , Edit
Gui, Add, Edit, x6 y7 w460 h250 , 
; Generated using SmartGUI Creator 4.0
Gui, Show, x272 y250 h267 w475, New GUI Window
Return

GuiClose:
ExitApp
}

~LButton::
{
	DevLog := "test"
	UtilityTextReplacement()
	WinGetActiveTitle, CurrentWinTitle
	WindowType := SetWindowType()

	Gosub, WindowSelector
	return

}

~Home::
{
	WinGetActiveTitle, CurrentWinTitle
	WindowType := SetWindowType()

	Gosub, WindowSelector
	return
}


End::
{
	ExitApp
}
