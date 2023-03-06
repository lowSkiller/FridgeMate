B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.2
@EndOfDesignText@
'Class fridge mate setup, configuration
'#############################################################
'KVS sett.dat:
'VSC - Last viewed storage ID
'VCL - Last viewed location ID
'VCI - Last viewed item ID
'SavefmObjec - Name of KVS of fridge mate data (xxx.dat files)
'#############################################################
'KVS xxx.dat:  - Database of fm Objects.
'	ToDo

Sub Class_Globals
	Private xui As XUI
	Private SaveNamefmStorage As String
	Public ViewCurrentStorage As Int
	Public ViewCurrentLocation As Int
	Public ViewCurrentItem As Int
	Private KVSMap As Map
	Private KVSData As KeyValueStore
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	KVSData.Initialize (xui.DefaultFolder,"sett.dat")
	KVSMap.Initialize
	KVSMap.Put("SavefmObject", 0)
	KVSMap.Put("VCS", 0)
	KVSMap.Put("VCL", 0)
	KVSMap.Put("VCI", 0)	
End Sub

'Local setup data reader
Public Sub ReadFromSave
	KVSMap = KVSData.Get("Setup")
	ViewCurrentStorage = KVSMap.Get("VCS")
	ViewCurrentLocation = KVSMap.Get("VCL")
	ViewCurrentItem = KVSMap.Get("VCI")
	SaveNamefmStorage = KVSMap.Get("SavefmObject")
End Sub

'Local setup data writer
Public Sub WriteToSave
	KVSMap.Put("VCS", ViewCurrentStorage)
	KVSMap.Put("VCL", ViewCurrentLocation)
	KVSMap.Put("VCI", ViewCurrentItem)
	KVSMap.Put("SavefmObject", SaveNamefmStorage) 'KVS Storage fmObject
	KVSData.Put("Setup", KVSMap)
End Sub
