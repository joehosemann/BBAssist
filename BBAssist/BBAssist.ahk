/*
 * Author           : Joseph Hosemann	(JosephHo)
 * Script Name      : BBAssist
 * Script Version   : 0.1.0a
 *
 * Creation Date    : November, 15, 2010 
 * Modification Date: January 13, 2010
 *
 
 BBNC Product SKUS
 
 BBNC
 BBNC-CF
 BBNCOCC
 IBBNCSTNDSUB
 EEOLA
 BBNCCustom 
 
 */
 
;+--> ; ---------[Directives]---------

#NoEnv
#SingleInstance Force

;+------> [Library]
#Include lib\Array.ahk
#Include lib\xpath.ahk
;#Include lib\Ini4Ahkl_v5.ahk

;+------> [Modules]
;#Include modules\Utilities.ahk
;#Include modules\Logger.ahk
#Include modules\Clarity.ahk
;#Include modules\Snagit.ahk

SendMode Input
SetWorkingDir %A_ScriptDir%

DetectHiddenText Off

;-

;+--> ; ---------[Basic Info]---------

s_name := "BBAssist"    
s_version := "0.1.0a"            
s_author := "Joseph Hosemann (JosephHo)"               
s_email := "joseph.hosemann@blackbaud.com"    
;-

;+--> ; ---------[Import Options]--------
IniRead, Analyst, options.ini, General, Analyst
IniRead, Department, options.ini, General, Department
IniRead, Verbose, options.ini, General, Verbose

;+------> [Clarify]
;IniRead, TextReplacement, options.ini, Clarify, TextReplacement

;-

;+--> ; ---------[General Variables]---------

LongDelay=1000
NormalDelay=500
ShortDelay=200
TinyDelay=50
;-

ClaritySetup()

return

DetectWindowChange()
{
global

return
}




~LButton::
{

	;if (TextReplacement = 1)
	; UtilityTextReplacement()
	WinGetActiveTitle, CurrentWinTitle
		PreviousWinTitle := CurrentWinTitle
	WinGetActiveTitle, CurrentWinTitle
	
	if PreviousWinTitle != CurrentWinTitle
	{
		ClarityCatchWindow()
	}
	return

}









;~Home::
;{
;	if Verbose > 1
;		DevLog()
;	return
;}


;End::
;{
;	ExitApp
;}
