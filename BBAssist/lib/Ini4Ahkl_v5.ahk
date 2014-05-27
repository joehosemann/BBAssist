ini(IniFile=""){
	Static base := ini_Base("Load Save"
	. " SectionExists GetSectionsList MoveSection SwapSections"
	. " GetKeysList RenameKey MoveKey"
	. " Parse GetListOf HasKey GetKeysWhereValue", "ini_")
	ini := Object("base", base)
	If (IniFile="" || !ini.Load(IniFile))
		Return ini
}

ini_Base(list, prefix){
	base := Object()
	Loop Parse, list, %A_Space%
		base[A_LoopField] := prefix . A_LoopField
	Return base
}

ini_Load(ini, IniFile){
	If (!IsObject(ini) || !FileExist(IniFile))
		Return, 1
	Loop, Read, %IniFile%
	{
		If !A_LoopReadLine
			Continue
		RegExMatch(A_LoopReadLine, "i)\[(.+?)\]|(.+?)=(.*)", m)
		Section := (m1 ? Trim(m1) : Section), Key := Trim(m2), Value := Trim(m3)
		If (Section<>last_Section)
			i := 0
		If (Section && Key)
			ini[Section, i] := Object("Key", Key, "Value", Value)
		last_Section := Section
		i += 1
	}
}

ini_Save(ini, IniFile){
	If (!IsObject(ini) || !IniFile)
		Return, 1
	For Section in ini {
		FileContent	.=	(FileContent ? "`n`n" : "") "[" Section "]"
		For Index,KeyVal in ini[Section]
		{
			TABs	:= "`t`t`t "
			Loop, % StrLen(KeyVal["Key"])//8
				StringReplace, TABs , TABs, %A_Tab%
			FileContent .= "`n" KeyVal["Key"] TABs "= " KeyVal["Value"]
		}
	}
	FileDelete, %IniFile%
	FileAppend, %FileContent%, %IniFile%
}

; ################################
; ##### SECTIONS		  ########
; ################################
ini_SectionExists(ini, Section){
	If !IsObject(ini)
		Return, 0
	Return !!ini[Section]._NewEnum().Next()
}

ini_Parse(ini, SectionsList=""){
	If !IsObject(ini)
		Return, 1
	For Section in ini
	{
		If SectionsList {
			SectionsList := RegExReplace(SectionsList, ",,", ",")
			If Section not in %SectionsList%
				Continue
		}
		If !ini.SectionExists(Section)
			Continue
		For Index,KeyVal in ini[Section]
			MsgBox, % "[" Section "]`nIndex:`t" Index "`nKey:`t'" KeyVal["Key"] "'`nValue:`t'"  KeyVal["Value"] "'"
	}
}

ini_MoveSection(ini, FromSection, ToSection, Copy=0){
	If !ini.SectionExists(FromSection)
		Return, 1
	i := ini[ToSection].MaxIndex()
	For Index,KeyVal in ini[FromSection]
	{
		i += 1
		ini[ToSection, i, "Key"]	:= KeyVal["Key"]
		ini[ToSection, i, "Value"]	:= KeyVal["Value"]
	}
	If !Copy
		ini._Remove(FromSection)
	Return, 0
}

ini_SwapSections(ini, FromSection, ToSection){
	If (!ini.SectionExists(FromSection) || !ini.SectionExists(ToSection))
		Return, 1
	From := ini[FromSection],  To := ini[ToSection]
	ini[FromSection] := To,  ini[ToSection] := From
	Return, 0
}

; ################################
; ##### KEYS			  ########
; ################################
ini_MoveKey(ini, FromSection, ToSection, Key, Copy=0){
	If !ini.SectionExists(FromSection)
		Return, 1
	For i in ini[FromSection]
	{
		If (ini[FromSection, A_Index, "Key"]=Key){
			Index := i
			Break
		}
	}
	If !Index
		Return, 1
	Key		:= ini[FromSection, Index, "Key"]
	Value	:= ini[FromSection, Index, "Value"]
	If !Copy
		ini[FromSection].Remove(Index)
	ini[ToSection, ini[ToSection].MaxIndex()+1] := Object("Key", Key, "Value", Value)
	Return, 0
}

ini_RenameKey(ini, Section, FromKey, ToKey){
	If !ini.SectionExists(Section)
		Return, 1
	For i in ini[Section]
	{
		If (ini[Section, A_Index, "Key"]=FromKey){
			Index := i
			Break
		}
	}
	ini[Section, Index, "Key"] := ToKey
	Return, 0
}

ini_HasKey(ini, Section, Index=""){
	If !ini.SectionExists(Section)
		Return, 0
	If Index
		Return, !!IsObject(ini[Section, Index])
	Else{
		For i in ini[Section]
		{
			If i
				Return, !!i
		}
	}
	Return, 0
}

; ################################
; ##### GETLISTOF		  ########
; ################################
ini_GetListOf(ini, Type="Sections", SectionsList="", Separator=","){
	If !IsObject(ini)
		Return
	If Type not in Sections,Keys
		Return
	If (Type="Sections")
		Return, ini.GetSectionsList(Separator)
	Else If (Type="Keys")
		Return, ini.GetKeysList(SectionsList, Separator)
}

ini_GetSectionsList(ini, Separator=","){
	For Section in ini
		SectionsList .= (SectionsList ? Separator : "") Section
	Return, SectionsList
}

ini_GetKeysList(ini, SectionsList="", Separator=","){
	For Section in ini
	{
		If SectionsList {
			SectionsList := RegExReplace(SectionsList, ",,", ",")
			If Section not in %SectionsList%
				Continue
		}
		For Index,KeyVal in ini[Section]
			KeysList .= (KeysList ? Separator : "") KeyVal["Key"]
	}
	Sort, KeysList, D%Separator% U
	Return, KeysList
}

; ################################
; ##### GETKEYSWHEREVALUE ########
; ################################
ini_GetKeysWhereValue(ini, Pref, Value, SectionsList="", ValueAsCSV=0){
	array := ini()
	For Section in ini {
		If SectionsList {
			SectionsList := RegExReplace(SectionsList, ",,", ",")
			If Section not in %SectionsList%
				Continue
		}
		For Index,KeyVal in ini[Section] {
			Total := Cpt := 0
			If !ValueAsCSV
				Cpt := Compare(Pref, KeyVal["Value"], Value)
			Else
				Loop, Parse, KeyVal["Value"], CSV
					Total += 1 , Cpt += Compare(Pref, A_LoopField, Value)
			PositivePrefs := "contains,="
			If Pref in %PositivePrefs%
				If Cpt
					array[Section, KeyVal["Key"]] := KeyVal["Value"]
			Else If ((!ValueAsCSV && Cpt) || (ValueAsCSV && Cpt=Total))
				array[Section, KeyVal["Key"]] := KeyVal["Value"]
		}
	}
	Return, array
}

Compare(Pref, var1, var2){
	If (Pref="="){
		If (var1=var2)
			Return, 1
	}Else If (Pref="<>"){
		If (var1<>var2)
			Return, 1
	}Else If (Pref="not contains"){
		If var1 not contains %var2%
			Return, 1
	}Else If InStr(var1, var2)
		Return, 1
	Return, 0
}