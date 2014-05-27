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
#Include modules\Utilities.ahk
#Include modules\Logger.ahk
#Include modules\Clarify.ahk

SendMode Input
SetWorkingDir %A_ScriptDir%

DetectHiddenText Off
;-

;+--> ; ---------[Basic Info]---------

s_name := "BBAssist"    
s_version := "0.0.9a"            
s_author := "Joseph Hosemann (JosephHo)"               
s_email := "joseph.hosemann@blackbaud.com"    
;-

;+--> ; ---------[Import Options]--------
IniRead, Analyst, options.ini, General, Analyst
IniRead, Department, options.ini, General, Department
IniRead, Verbose, options.ini, General, Verbose
;-

;+--> ; ---------[General Variables]---------
Verbose=4
LongDelay=1000
NormalDelay=500
ShortDelay=200
TinyDelay=50
;-

ClarifySetup()

return

~LButton::
{
	Logger("LButton",5)

	UtilityTextReplacement()
	WinGetActiveTitle, CurrentWinTitle
	WindowType := SetWindowType()

	WindowSelector()
	return

}

~Home::
{
	DevLog()
	return
}


End::
{
	ExitApp
}
