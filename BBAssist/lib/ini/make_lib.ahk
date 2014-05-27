; 20100926, Public Domain

; user settings
deleteFileTypes := "*~,bak"
path_mdoc := "C:\Program Files\NaturalDocs\mkDoc"
path_7zip := "C:\Program Files\7-Zip"

#NoEnv
#NoTrayIcon
SendMode Input
SetWorkingDir %A_ScriptDir%
project := RegExReplace(A_ScriptDir, "^.*\\")

script_type := RegExReplace(A_ScriptName, "i)make_(.*?)?\..*?$", "$1") ; App, Lib	

; create html
EnvGet, PATH, PATH
EnvSet, PATH, %path_mdoc%;%PATH%
RunWait, %comspec% /c mkdoc s
FileCopy, %project%.html, .., 1

; create exe
If (script_type = "app")
{
	IfExist, media\%project%.ico
	{
		icon = /icon "media\%project%.ico"
	}
	Else IfExist, %project%.ico
	{
		icon = /icon "%project%.ico"
	}
	ahk2exe := RegExReplace(A_AhkPath, "(.*)\\.*?$", "$1") . "\Compiler\Ahk2exe.exe"
	RunWait, "%ahk2exe%" /in "%project%.ahk" /out "../%project%.exe" %icon%
}

; clean files
Loop, Parse, deleteFileTypes, `,
{
	Loop, *.%A_LoopField%, 0, 1
	{
		FileDelete, %A_LoopFileFullPath%
	}
}

; create zip
If (script_type = "app")
{
	src := "_src"
}
FileDelete, ..\%project%%src%.zip
RunWait, "%path_7zip%\7z.exe" a "..\%project%%src%.zip" *.* -r