Gui, Add, Tab, x6 y7 w470 h370 , General|Clarify|Other
Gui, Add, Text, x16 y37 w60 h20 , First Name:
Gui, Add, Text, x16 y57 w60 h20 , Last Name:
Gui, Add, Text, x16 y77 w60 h20 , Department:
Gui, Add, Edit, x86 y37 w150 h20 , ; First Name
Gui, Add, Edit, x86 y57 w150 h20 , ; Last Name
Gui, Add, Edit, x86 y77 w150 h20 , ; Department
Gui, Add, GroupBox, x336 y37 w130 h70 , Features:
Gui, Add, CheckBox, x346 y57 w110 h20 , Clarify
Gui, Add, CheckBox, x346 y77 w110 h20 , Other ; Needs different name...
Gui, Tab, Clarify
Gui, Add, GroupBox, x336 y37 w130 h90 , Features:
Gui, Add, CheckBox, x346 y57 w110 h20 , Text Replacement
Gui, Add, CheckBox, x346 y77 w110 h20 , Link Grabbing
Gui, Add, CheckBox, x346 y97 w110 h20 , Automation
Gui, Tab, Clarify
Gui, Add, ListBox, x16 y37 w130 h340 , Product|Case Title|Site ID|Site Name|Contact Full Name|Contact First Name|Contact Last Name|Contact Phone|Contact Email|Contact State|Department|Case Notes|Time Begin|Time End|Internal Notes|External Notes|Case Status|Done Button|Internal Notes|Action Type|Date|Time Begin|Internal Notes|External Notes|Time End|Case Status|Done Button|Internal Notes|External Notes|Case Status|Done Button|CC List|Message|Send Button|Case Id|Client Full Name
; Generated using SmartGUI Creator 4.0
Gui, Show, x696 y306 h390 w490, New GUI Window
Return

GuiClose:
ExitApp