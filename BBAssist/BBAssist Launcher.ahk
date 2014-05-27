#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Process, close, BBAssist.exe

IniRead, srcPath, options.ini, Launcher, SourcePath

FileGetVersion, srcVersion, %srcPath%\BBAssist.exe
FileGetVersion, localVersion, %A_ScriptDir%\BBAssist.exe

if srcVersion != %localVersion%
{
	FileCopy, %srcPath%\BBAssist.exe, %A_ScriptDir%, 1
	
}

FileCreateDir, res

Run BBAssist.exe