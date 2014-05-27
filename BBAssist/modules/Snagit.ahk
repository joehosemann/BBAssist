PrintScreen::
{
	WinWaitActive, Save As,, 5
	if ErrorLevel
	{
	}
	else
	{	
		IfWinExist, Amdocs
		{
			ControlSetText, Edit1, \\chsclySQL\attachments\%A_YYYY%CS\%CaseId%, Save As	
		}
		
		
		
	}
	return
}