#Include, %A_ScriptDir%\Ini4Ahkl.ahk

ini			:= Object()
File1		:= A_ScriptDir . "\IniFile.ini"
File2		:= A_ScriptDir . "\IniFile2.ini"

;Load the ini file
If ! ini := ini(File1)
   MsgBox, Error loading ini file!
   
;~ MsgBox, % ini["File"].MaxIndex()

;Parse the ini content of specified sections
;~ ini.Parse("File,Section")

;~ For Section in ini
;~ {
;~    For Index,KeyVal in ini[Section]
;~       MsgBox, % "[" Section "]`nIndex: " Index "`nKey: " KeyVal["Key"] "`nValue: "  KeyVal["Value"]
;~ }

;Save ini
;~ ini_Save(ini, File2)

;Section exists
;~ MsgBox, % "Section exists 'File' ? " ini.SectionExists("File")

;~ ;Move section
;~ ini.MoveSection("File", "Edition")
;~ ini.Parse()

;~ ;Swap sections
;~ ini.SwapSections("Edition", "File")
;~ ini.Parse()

;Move a key
;~ ini.MoveKey("File", "Edition", "1_Open")
;~ ini.Parse()

;~ ;Rename a key
;~ ini.RenameKey("File", "2_New", "1_NewKeyname")
;~ ini.Parse()

;Verify if a section has a key
;~ MsgBox, % "'Edition' has key ? " ini.HasKey("Edition")      ;<== 1
;~ MsgBox, % "'Edition' has key ? " ini.HasKey("Edition", 2)   ;<== 1
;~ MsgBox, % "'Edition' has key ? " ini.HasKey("Edition", 3)   ;<== 0

;~ ;Get list of sections
;~ MsgBox, % "Sections list:`n" ini.GetListOf("Sections")
;~ MsgBox, % "Keys list from 'File':`n" ini.GetListOf("Keys", "File", "`n")