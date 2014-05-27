UtilityTextReplacement()
{
	global
	
	; if windowtitle contains Amdocs.
	IfInString, CurrentWinTitle, Amdocs
	{
		Logger("UtilityTextReplacement", 3)
		
		FocusedHWND := ""
		Changed := 0

		GuiThreadInfoSize = 48
		VarSetCapacity(GuiThreadInfo, GuiThreadInfoSize)
		NumPut(GuiThreadInfoSize, GuiThreadInfo, 0)
		if not DllCall("GetGUIThreadInfo", uint, 0, str, GuiThreadInfo)
		{
			return
		}
		
		FocusedHWND := NumGet(GuiThreadInfo, 12)  ; Retrieve the hwndFocus field from the struct.
		
		Logger("FocusedHWND = " FocusedHWND, 3)
			
			if FocusedHWND != 0
			{
				ControlGetText, controlText, , ahk_id %FocusedHWND%
				
				Loop, parse, controlText, `<`>
				{
					clarifyVariableIndex := clarifyVariableName.indexOf(A_LoopField)
					
					if (clarifyVariableIndex > 0)
					{	
						;output := % clarifyVariable[ clarifyVariableIndex ] ;%
						
						
						
						output := % output . " " . clarifyVariable[ clarifyVariableIndex ] ;%
						changed := 1
						Logger("-----TextReplacement Succeeded" clarifyVariable[ clarifyVariableIndex ], 3)
					}
					else
					{
						output = %output%%A_LoopField%
						Logger("-----TextReplacement Failed" clarifyVariable[ clarifyVariableIndex ] " - " A_LoopField, 3)
					}
				}
				if (changed = 1)
					ControlSetText, , %output%, ahk_id %FocusedHWND%
				output := ""
				changed := 0
			}
			return
		}
	return
}
