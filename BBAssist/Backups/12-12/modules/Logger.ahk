Logger(x,y) ; message, verbose level
{
	global
	if (Verbose >= y)
	{
		MyLog := x . "`r`n" . MyLog
		GuiControl,, DevLogger, %MyLog%
	}
	return
}

DevLog()
{
	global
	Gui, Add, Edit, vDevLogger x2 y20 w470 h350 ReadOnly
	; Generated using SmartGUI Creator 4.0
	Gui, Show, x127 y87 h379 w479, BBAssist Logger
	Return
}