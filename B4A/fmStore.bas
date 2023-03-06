B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.2
@EndOfDesignText@
'Class fridge mate storage (fridge, basement)
Sub Class_Globals
	Private ID As Int
	Private Name As String
	Private Location() As fmLocation
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	ID = 0
	Name = "NEW"
End Sub

'Local item data reader
Public Sub ReadFromSave (strSaveName As String)
	
End Sub

'Local item data writer
Public Sub WriteToSave (strSaveName As String)
	
End Sub
