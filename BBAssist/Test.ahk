;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         A.N.Other <myemail@nowhere.com>
;
; Script Function:
;	Template script (you can customize this template by editing "ShellNew\Template.ahk" in your Windows folder)
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.Gui, Add, Edit, x2 y20 w470 h350 , Edit
DetectHiddenText, On
; Generated using SmartGUI Creator 4.0

PreviousWindowTitle := ""
CurrentWindowTitle := ""


return


DetectWindowChange()
{
global

		ControlGet, List, List, , SysTreeView322, Amdocs
		;ControlGetText, List, SysTreeView322, Amdocs
		Msgbox, %List%
		Loop, Parse, List, `n  ; Rows are delimited by linefeeds (`n).
		{
			RowNumber := A_Index
			Loop, Parse, A_LoopField, %A_Tab%  ; Fields (columns) in each row are delimited by tabs (A_Tab).
				MsgBox Row #%RowNumber% Col #%A_Index% is %A_LoopField%.
		}
		
	
	
return
}

~Home::
{
	DetectWindowChange()
	return
}

End::
{
	ExitApp
}
