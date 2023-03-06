B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.2
@EndOfDesignText@
'Class fridge mate item
Sub Class_Globals
	Private Id As Int
	Private ScanCode As String
	Private Name As String
	Private Info As String
	Private Category As String
	Private Cooling As Int
	Private Location As String
	Private Picture As Int
	Private Amount As Int
	Private Unit As Int
	Private LifeDates As Map
	Private ItemLayout As List
	Private Save As Boolean
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	'Must be update when data structure changes, must contain all Variables according to CLV Layouts
	'ItemLayouts.Initialize2 (Array As String ("Id","ScanCode","Name","Info","Category","Cooling","Location","Picture","Amount","LifeDates"))
	ItemLayout.Initialize2 (Array As String ("Id","Name","Info","Category","Cooling","Location","Picture","Amount","LifeDates","Save"))
	Id = 0
	ScanCode = "0000000"
	Name = "NEW"
	Info = "NEW"
	Category = ""
	Cooling = 0
	Location = "1234"
	Picture = 0
	Amount = 0
	Unit = 3
	LifeDates.Initialize
	LifeDates.Put("EOL",DateTime.Date(DateTime.Now + 10000))
	LifeDates.Put("BOL",DateTime.Date(DateTime.Now))
	Save = False
End Sub

Public Sub GetItems () As List
	Return ItemLayout
End Sub

Public Sub GetValues () As NestedMap
	Dim l As NestedMap
	l.Initialize
	l.PutNode(ItemLayout.Get(0), False).Put("Id", Id)
	l.PutNode(ItemLayout.Get(0), False).Put("ScanCode", ScanCode)
	l.Put(ItemLayout.Get(1), Name)
	l.Put(ItemLayout.Get(2), Info)
	l.Put(ItemLayout.Get(3), Category)
	l.Put(ItemLayout.Get(4), Cooling)
	l.Put(ItemLayout.Get(5), Location)
	l.Put(ItemLayout.Get(6), Picture)
	l.PutNode(ItemLayout.Get(7), False).Put("Amount", Amount)
	l.PutNode(ItemLayout.Get(7), False).Put("Unit", Unit)
	l.PutNode(ItemLayout.Get(8), False).Put("EOL",LifeDates.Get("EOL"))
	l.PutNode(ItemLayout.Get(8), False).Put("BOL",LifeDates.Get("BOL"))
	l.Put(ItemLayout.Get(9), Save)
	Return l
End Sub

Public Sub GetLayouts () As Map
	Dim l As Map
	l.Initialize
	l.Put(ItemLayout.Get(0), "CVInputBarcode")
	l.Put(ItemLayout.Get(1), "CVInputInfo")
	l.Put(ItemLayout.Get(2), "CVInputTextWithSearch")
	l.Put(ItemLayout.Get(3), "CVInputTextWithSearch")
	l.Put(ItemLayout.Get(4), "CVInputCooling")
	l.Put(ItemLayout.Get(5), "CVInputLocation")
	l.Put(ItemLayout.Get(6), "CVInputImage")
	l.Put(ItemLayout.Get(7), "CVInputAmount")
	l.Put(ItemLayout.Get(8), "CVInputDates")
	l.Put(ItemLayout.Get(9), "CVInputSaveAbort")
	Return l
End Sub

Public Sub GetLayoutHeigts () As Map
	Dim l As Map
	l.Initialize
	l.Put(ItemLayout.Get(0), 90)
	l.Put(ItemLayout.Get(1), 130)
	l.Put(ItemLayout.Get(2), 110)
	l.Put(ItemLayout.Get(3), 110)
	l.Put(ItemLayout.Get(4), 130)
	l.Put(ItemLayout.Get(5), 140)
	l.Put(ItemLayout.Get(6), 240)
	l.Put(ItemLayout.Get(7), 90)
	l.Put(ItemLayout.Get(8), 100)
	l.Put(ItemLayout.Get(9), 100)
	Return l
End Sub
