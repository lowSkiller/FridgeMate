B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=12.2
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'Items Data, compare with database configuration
	Type ItemValues (Id As Int, Code As String, _
					 Name As Int, Info As Int, _
					 Category As Int, Cooling As Int, _
					 Location As String, Picture As Int, _
					 Amount As Int, Unit As Int, _
					 LifeDates As Map)
	
	'Custom view input layout names
	Public ItemValuesInit As ItemValues		
	ItemValuesInit.Id = 0
	ItemValuesInit.Code = "0000000"
	ItemValuesInit.Name = "NEW"
	ItemValuesInit.Info = "NEW"
	ItemValuesInit.Category = ""
	ItemValuesInit.Cooling = 0
	ItemValuesInit.Location = "1234"
	ItemValuesInit.Picture = 0
	ItemValuesInit.Amount = 0
	ItemValuesInit.Unit = 3
	ItemValuesInit.LifeDates.Initialize
	ItemValuesInit.LifeDates.Put("EOL",DateTime.Date(DateTime.Now + 10000))
	ItemValuesInit.LifeDates.Put("BOL",DateTime.Date(DateTime.Now))
	
	Public ItemLayout As Map

	Public ItemLayoutHeight As Map

	Public ItemLayoutValues As List

	Public ItemLayoutIndex As Map
	
	'Custom view input layout datasets, according to names List
	'Type CVInputBarcodeValues (TitleScan As Label, BtnScanNew As Button, TitleNewCode As Label, ValueNewCode As Label)
	'Type CVInputCoolingValues (TitleCooling As Label, TitleCool As Label, TitleIce As Label, TitleExtra As Label, _
	'								IconCool As Label, IconIce As Label, IconExtra As Label)
	'Type CVInputTextWithSearchValues (TitleTextSearch As Label, TextFieldSearch As B4XFloatTextField, ListViewSearch As CustomListView)
	'Type CVInputInfoValues (TitleInfo As Label,TextFieldInfo As B4XFloatTextField)
	'Type CVInputLocationValues (CLVLocation1 As CustomListView, CLVLocation2 As CustomListView, CLVLocation3 As CustomListView, CLVLocation4 As CustomListView)
	'Type CVInputImageValues (TitleItemImage As Label, ImageItemImage As B4XImageView)
	'Type CVInputAmountValues (TitleAmount As Label, TitleUnit As Label, TextFieldAmount As B4XFloatTextField, ComboBoxUnit As B4XComboBox)
	'Type CVInputDatesValues (TitleEOLDate As Label, TitleStorageDate As Label, BtnEOLDate As Button, BtnStorageDate As Button)

End Sub

Public Sub SetupConfigList ()
	ItemLayout.Initialize
	ItemLayout.Put("ID","CVInputBarcode")
	ItemLayout.Put("ScanCode","CVInputInfo")
	ItemLayout.Put("CommentID", "CVInputTextWithSearch")
	ItemLayout.Put("Name", "CVInputTextWithSearch")
	ItemLayout.Put("Cooling", "CVInputCooling")
	ItemLayout.Put("LocationTag", "CVInputLocation")
	ItemLayout.Put("Image", "CVInputImage")
	ItemLayout.Put("Amount,Unit", "CVInputAmount")
	ItemLayout.Put("EOL,BOL","CVInputDates")
	
	ItemLayoutHeight.Initialize
	ItemLayoutHeight.Put("ID",90)
	ItemLayoutHeight.Put("ScanCode",130)
	ItemLayoutHeight.Put("CommentID",110)
	ItemLayoutHeight.Put("Name",110)
	ItemLayoutHeight.Put("Cooling",130)
	ItemLayoutHeight.Put("LocationTag",140)
	ItemLayoutHeight.Put("Image",240)
	ItemLayoutHeight.Put("Amount,Unit",90)
	ItemLayoutHeight.Put("EOL,BOL",100)
	
	ItemLayoutValues.Initialize
	ItemLayoutValues.Add(ItemValuesInit.Id)
	ItemLayoutValues.Add(ItemValuesInit.Code)
	ItemLayoutValues.Add(ItemValuesInit.Name)
	ItemLayoutValues.Add(ItemValuesInit.Info)
	ItemLayoutValues.Add(ItemValuesInit.Category)
	ItemLayoutValues.Add(ItemValuesInit.Cooling)
	ItemLayoutValues.Add(ItemValuesInit.Location)
	ItemLayoutValues.Add(ItemValuesInit.Picture)
	ItemLayoutValues.Add(ItemValuesInit.Amount)
	ItemLayoutValues.Add(ItemValuesInit.Unit)
	ItemLayoutValues.Add(ItemValuesInit.LifeDates)
	
End Sub
