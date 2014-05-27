xml := xpath_load("res\clarity.xml") ; Load XML
cIndex := Array()
CurrentCase := Array()


; Setup
ClaritySetup()
{
	global
	
		
	cIndex[17] := "CaseTitle"		
	cIndex[55] := "SiteID"			
	cIndex[56] := "SiteName"
	cIndex[58] := "ContactFullName"
	cIndex[60] := "ContactPhone"
	cIndex[75] := "ContactEmail"
	cIndex[62] := "ContactState"
	cIndex[32] := "Department"
	cIndex[37] := "CaseNotes"

	return
}

; LoadByCaseId
ClaritySetCurrentCase(thisCaseId)
{
	global
	
	CaseId =: thisCaseId
	CaseTitle =: xpath(xml, "/cases/case[id=" . thisCaseId . "]/casetitle/text()")
	SiteId =: xpath(xml, "/cases/case[id=" . thisCaseId . "]/siteid/text()")
	SiteName =: xpath(xml, "/cases/case[id=" . thisCaseId . "]/sitename/text()")
	Department =: xpath(xml, "/cases/case[id=" . thisCaseId . "]/department/text()")
	ContactFirstName =: xpath(xml, "/cases/case[id=" . thisCaseId . "]/firstname/text()")
	ContactLastName =: xpath(xml, "/cases/case[id=" . thisCaseId . "]/lastname/text()")
	ContactPhoneNumber =: xpath(xml, "/cases/case[id=" . thisCaseId . "]/contactphone/text()")
	ContactEmailAddress =: xpath(xml, "/cases/case[id=" . thisCaseId . "]/contactemail/text()")
	ContactState =: xpath(xml, "/cases/case[id=" . thisCaseId . "]/contactstate/text()")
	
	xpath_save("res\clarity.xml")
	
	return
}

; SaveCase
ClaritySaveCurrentCase(caseTitle, siteId, siteName, department, firstName, lastName, phone, email, state)
{
	global
	
	CaseTitle =: xpath(xml, "/cases/case[id=" . newCaseId . "]/casetitle/text()", %caseTitle%)
	SiteId =: xpath(xml, "/cases/case[id=" . newCaseId . "]/siteid/text()", %siteId%)
	SiteId =: xpath(xml, "/cases/case[id=" . newCaseId . "]/sitename/text()", %siteName%)
	Department =: xpath(xml, "/cases/case[id=" . newCaseId . "]/department/text()", %department%)
	ContactFirstName =: xpath(xml, "/cases/case[id=" . newCaseId . "]/firstname/text()", %firstName%)
	ContactLastName =: xpath(xml, "/cases/case[id=" . newCaseId . "]/lastname/text()", %lastName%)
	ContactPhoneNumber =: xpath(xml, "/cases/case[id=" . newCaseId . "]/contactphone/text()", %phone%)
	ContactEmailAddress =: xpath(xml, "/cases/case[id=" . newCaseId . "]/contactemail/text()", %email%)
	ContactState =: xpath(xml, "/cases/case[id=" . newCaseId . "]/contactstate/text()", %state%)
	
	return
}

; SetVariables
ClarityCatchWindow()
{
global 
	WinGetActiveTitle, CurrentWinTitle
	
	IfInString, CurrentWinTitle, Amdocs
	{
		StatusBarGetText, statusbartext, 2, Amdocs
		StringRight, newCaseId, statusbartext, 8
		
		if newCaseId != CaseId
		{
			CaseId := newCaseId
			
			cases := xpath(xml, "/cases/cases[@id]/text()")
			if cases contains %newCaseId%
			{
				ClaritySetCurrentCase(%newCaseId%)			
			}
			else
			{					
				WinGet, WinGetResults, ControlListHwnd, %CurrentWinTitle%
				Loop, parse, WinGetResults, `n, `r
				{
					if A_Index in 17,32,55,58,60,62,75
					{
						ControlGetText, temp, , % "ahk_id" . A_LoopField ;%
						CurrentCase[A_Index] := temp
						
						if A_Index = 58
						{
							StringSplit, textvalue, temp, %A_Space%
							firstName := textvalue1
							lastName := textvalue2
						}
						msgbox, %temp% - %A_LoopField%						
					}
				}				
				ClaritySaveCurrentCase(CurrentCase[17], CurrentCase[55], CurrentCase[56], CurrentCase[32], firstName, lastName, CurrentCase[60], CurrentCase[75], CurrentCase[62])				
			}
		}	
	}
	return
}
