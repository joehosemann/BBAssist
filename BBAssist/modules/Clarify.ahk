ClarifySetup()
{
global

BackupPath := "res\bbassist.bak"
CachePath := "res\bbassist.cache"
clarifyVariableName := Array() ; Variable Name Store
;clarifyVariable := Array() ; Control Text
;hwndVariable := Array() ; Control HWND Values

clarifyVariableName[1] := "Base_Product"
clarifyVariableName[2] := "Base_CaseTitle"
clarifyVariableName[3] := "Base_SiteID"
clarifyVariableName[4] := "Base_SiteName"
clarifyVariableName[5] := "Base_ContactFullName"
clarifyVariableName[6] := "Base_ContactFirstName"
clarifyVariableName[7] := "Base_ContactLastName"
clarifyVariableName[8] := "Base_ContactPhone"
clarifyVariableName[9] := "Base_ContactEmail"
clarifyVariableName[10] := "Base_ContactState"
clarifyVariableName[11] := "Base_Department"
clarifyVariableName[12] := "Base_CaseNotes"
clarifyVariableName[13] := "Phone_TimeBegin"
clarifyVariableName[14] := "Phone_TimeEnd"
clarifyVariableName[15] := "Phone_InternalNotes"
clarifyVariableName[16] := "Phone_ExternalNotes"
clarifyVariableName[17] := "Phone_CaseStatus"
clarifyVariableName[18] := "Phone_DoneButton"
clarifyVariableName[19] := "Phone_InternalNotes"
clarifyVariableName[20] := "Phone_ActionType"
clarifyVariableName[21] := "Research_Date"
clarifyVariableName[22] := "Research_TimeBegin"
clarifyVariableName[23] := "Research_InternalNotes"
clarifyVariableName[24] := "Research_ExternalNotes"
clarifyVariableName[25] := "Research_TimeEnd"
clarifyVariableName[26] := "Research_CaseStatus"
clarifyVariableName[27] := "Research_DoneButton"
clarifyVariableName[28] := "Notes_InternalNotes"
clarifyVariableName[29] := "Notes_ExternalNotes"
clarifyVariableName[30] := "Notes_CaseStatus"
clarifyVariableName[31] := "Notes_DoneButton"
clarifyVariableName[32] := "Email_CCList"
clarifyVariableName[33] := "Email_Message"
clarifyVariableName[34] := "Email_SendButton"
clarifyVariableName[35] := "Email_CaseId"
clarifyVariableName[36] := "Email_ClientFullName"

FileDelete, %CachePath%

return
}

ClarifySetCaseId()
{
	global

	Logger("ClarifySetCaseId",3)
	StatusBarGetText, statusbartext, 2, %CurrentWinTitle%
	StringRight, CaseId, statusbartext, 8
	
	return
}

FileDateDifference(Param1)
{
global

	Logger("FileDateDifference",3)

	FileGetTime, BackupTimestamp, %Param1%, C ; Retrieves the creation time.	
	return, % A_Now - BackupTimestamp ;%	
}

ClarifyResetVolatileVariables()
{
	global
	Logger("ClarifyResetVolatileVariables",3)

	StatusBarGetText, statusbartext, 2, %CurrentWinTitle%
	StringRight, tempCaseId, statusbartext, 8
	
	if tempCaseId != %CaseId%
	{
		Logger("--------------Reset CaseId - " tempCaseId " - " CaseId,3)
		
		ClarifySetCaseId()
		clarifyVariable := Array() ; Control Text
		hwndVariable := Array() ; Control HWND Values
	}
	else
		if (Verbose > 3)
		Logger("--------------Failed to Reset CaseId - " tempCaseId " - " CaseId,3)	

	
	if FileExist(CachePath)
	{
		IniRead, tempSiteID, %CachePath%, %CaseId%, SiteID
		
		if (tempSiteID := "ERROR")
		{
			ClarifySetControls()
		}
		else
		{
			ClarifyCacheImporter()
		}
	}
	else
	{
		ClarifySetControls()
	}
	
	
	return
}

ClarifyGetTextByHWND(CtrlName, HWND)
{
	global
	
	Logger(CtrlName, 3)
	Index := ""
	Index := clarifyVariableName.indexOf(CtrlName)
	ControlGetText, temp, , % "ahk_id" . HWND ;%
	clarifyVariable[Index] := temp
	ini[CaseId][ControlName] := temp ; get key from section 
	;IniWrite, %temp%, %BackupPath%, %CaseId%, %CtrlName%

	if (CtrlName = "Base_ContactFullName")
	{
		StringSplit, textvalue, temp, %A_Space%
		clarifyVariable[6] := textvalue1
		clarifyVariable[7] := textvalue2
	}
	
	temp := ""
	Index := ""
	return
}

ClarifyCacheImporter()
{
global

	Logger("ClarifyCacheImporter",3)

	Loop, % clarifyVariableName.len() ;%
	{		
		text := % clarifyVariableName[ A_Index ] ;%
		
		IniRead, hwnd, %CachePath%, %CaseId%, %text%
		Sleep, %TinyDelay%
			
		ClarifyGetTextByHWND(clarifyVariable[ A_Index ], %hwnd%)
		
		text := ""
		hwnd := ""
	}	
	return
}

; Output: WindowType (OldCase, NewCase, Research, Phone, Email, Notes, Other)
SetWindowType()
{
global
	
	Logger("SetWindowType",3)

	WinGetActiveTitle, CurrentWinTitle

	controlIndex := Array()

	IfInString, CurrentWinTitle, Amdocs
	{
		IfInString, CurrentWinTitle, Untitled
		{
			WindowType := "NewCase"
			; Note: Change control vars upon detection of window change.
						
			controlIndex[59] := "Base_Product"			; Product
			controlIndex[24] := "Base_CaseTitle"			; CaseTitle
			controlIndex[15] := "Base_SiteID"				; SiteID
			controlIndex[16] := "Base_SiteName"			; SiteName
			controlIndex[0] := ""					; ContactFullName
			controlIndex[18] := "Base_ContactFirstName"	; ContactFirstName
			controlIndex[19] := "Base_ContactLastName"	; ContactLastName
			controlIndex[21] := "Base_ContactPhone"		; ContactPhone
			controlIndex[80] := "Base_ContactEmail"		; ContactEmail
			controlIndex[58] := "Base_ContactState"		; ContactState
			controlIndex[0] := ""					; Department
			controlIndex[0] := ""					; CaseNotes
			
		}
		else IfInString, CurrentWinTitle, Phone
		{
			WindowType = Phone
			
			controlIndex[26] := "Phone_TimeBegin"
			controlIndex[28] := "Phone_TimeEnd"
			controlIndex[30] := "Phone_InternalNotes"
			controlIndex[31] := "Phone_ExternalNotes"
			controlIndex[36] := "Phone_CaseStatus"
			controlIndex[40] := "Phone_DoneButton"
			controlIndex[46] := "Phone_InternalNotes"
			controlIndex[54] := "Phone_ActionType"
		}
		else IfInString, CurrentWinTitle, Research
		{
			WindowType = Research
			
			controlIndex[14] := "Research_Date" ;???
			controlIndex[18] := "Research_TimeBegin"
			controlIndex[19] := "Research_InternalNotes"
			controlIndex[20] := "Research_ExternalNotes"
			controlIndex[22] := "Research_TimeEnd" ;???
			controlIndex[24] := "Research_CaseStatus"
			controlIndex[27] := "Research_DoneButton"
		}
		else IfInString, CurrentWinTitle, Notes
		{
			WindowType = Notes
			
			controlIndex[17] := "Notes_InternalNotes"
			controlIndex[19] := "Notes_ExternalNotes"
			controlIndex[23] := "Notes_CaseStatus"
			controlIndex[26] := "Notes_DoneButton"
		}
		else IfInString, CurrentWinTitle, Email
		{
			WindowType = Email
			
			controlIndex[26] := "Email_CCList"
			controlIndex[27] := "Email_Message"
			controlIndex[37] := "Email_SendButton"
			controlIndex[43] := "Email_CaseId"
			controlIndex[44] := "Email_ClientFullName"
		}
		else IfInString, CurrentWinTitle, Case
		{
			WindowType = OldCase
			
			controlIndex[0] :=	""					; Product
			controlIndex[17] := "Base_CaseTitle"		; CaseTitle
			controlIndex[55] := "Base_SiteID"			; SiteID
			controlIndex[56] := "Base_SiteName"			; SiteName
			controlIndex[58] := "Base_ContactFullName"	; ContactFullName
			controlIndex[0] := ""					; ContactFirstName
			controlIndex[0] := ""					; ContactLastName
			controlIndex[60] := "Base_ContactPhone"		; ContactPhone
			controlIndex[75] := "Base_ContactEmail"		; ContactEmail
			controlIndex[62] := "Base_ContactState"		; ContactState
			controlIndex[32] := "Base_Department"		; Department
			controlIndex[37] := "Base_CaseNotes"		; CaseNotes

		}
	}
	else IfInString, CurrentWinTitle, (Firefox OR Chrome OR Internet Explorer)
	{
		WindowType = Browser
	}
	else
	{
		WindowType = Other
	}
	return WindowType
}

; Gets hwnd from window control list
ClarifySetControls()
{
global

	Logger("ClarifySetControls",3)
	
	; Get a list of all controls in the window.
	WinGet, tempvalue, ControlListHwnd, %CurrentWinTitle%
	; Get list of top 80 controls in window.
	Loop, parse, tempvalue, `n, `r
	{
		if % controlIndex[ A_Index ] != "" ;%
		{
			ClarifyHWNDHandler(controlIndex[ A_Index ], A_LoopField)
		}
		if %A_Index% > 80
			break
	}   
	
	tempvalue := ""

	return
}

; Crappy hack until I can figure out better solution.
ClarifyHWNDHandler(HWNDName,HWNDValue) 
{
	global
	
	Logger("ClarifyHWNDHandler" HWNDName HWNDValue,3)
	
	ClarifyGetTextByHWND(HWNDName, HWNDValue)
	
	IniWrite, %HWNDValue%, %CachePath%, %CaseId%, %HWNDName%
	
	return
}

; Copies Product name to Case Title
; Activates the List By Site button.
ClarifyNewCaseEntry()
{
global


	Logger("ClarifyNewCaseEntry",3)
	if Product !=
	{
		if CaseTitle =
		{
			CaseTitle = %Product%:
			ControlSetText, %hwndCaseTitle%, %CaseTitle%, %CurrentWinTitle%
			Sleep, %ShortDelay%
		   
			ControlClick, Case, %CurrentWinTitle%
			ControlGetFocus, tempvalue, %CurrentWinTitle%
			Control, ChooseString, %Department%, %tempvalue%, %CurrentWinTitle%
			Sleep, %ShortDelay%
		   
			; Click the List by Site button.
			ControlClick, Previous Cases, %CurrentWinTitle%
			Sleep, %NormalDelay%
			ControlClick, List by Site, %CurrentWinTitle%
		}
	}
	return
}

WindowSelector()
{
global

	Logger("WindowSelector",3)

	if CurrentWinTitle contains Amdocs
	{
	
	
		if (FileDateDifference(BackupPath) > 1000000) ; 1000000 = 1 day
			FileDelete, %BackupPath%

		PreviousWindowType := WindowType
			
		If (WindowType = "NewCase")
		{
			ClarifySetControls()
			ClarifyNewCaseEntry()
		}
		Else If (WindowType = "OldCase")
		{	
			
			ClarifyResetVolatileVariables()
		}
		Else If (WindowType = "Phone")
		{
			ClarifyResetVolatileVariables()
		}
		Else If (WindowType = "Research")
		{
			ClarifyResetVolatileVariables()
		}
		Else If (WindowType = "Notes")
		{
			ClarifyResetVolatileVariables()
		}
		Else If (WindowType = "Email")
		{
			ClarifyResetVolatileVariables()
		}
		Else If (WindowType = "Browser")
		{
			ClarifyResetVolatileVariables()
		}
		Else If (WindowType = "Other")
		{		
			ClarifyResetVolatileVariables()
		}
	}
return
}