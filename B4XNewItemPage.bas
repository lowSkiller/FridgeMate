B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11
@EndOfDesignText@
Sub Class_Globals
	Private NewItemPage As B4XView 'ignore
	Private xui As XUI 'ignore
	Private xDialog As B4XDialog
	Private PageContent As CustomListView
	
	'Custom view input layout view elements
	Private BtnEOLDate As Button
	Private BtnBOLDate As Button
	Private DateTemplate As B4XDateTemplate
	Private BtnScanCode As Button
	Private BtnAbortData As Button
	Private BtnSaveData As Button
	Private ComboBoxUnit As B4XComboBox
	Private TextFieldAmount As B4XFloatTextField
	Private TextFieldInfo As B4XFloatTextField
	Private TextFieldSearch As B4XFloatTextField
	Private ValueScanCode As Label
 	Private Title1 As Label
 	Private Title2 As Label
 	Private Title3 As Label
 	Private Title4 As Label
	Private IconCool As Label
	Private IconIce As Label
	Private IconExtra As Label
	Private ImageItemImage As B4XImageView
	Private CLVLocation1 As CustomListView
	Private CLVLocation2 As CustomListView
	Private CLVLocation3 As CustomListView
	Private CLVLocation4 As CustomListView
	Private ListViewSearch As CustomListView
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	NewItemPage = Root1
	'load the layout to Root
	NewItemPage.LoadLayout("NewItemPage")
	
	ItemSetting.SetupConfigList
	For Each i As String In ItemSetting.Itemlist
		PageContent.Add( CreateOptListItem( i, _
										  ItemSetting.LayoutName.Get(i), _
										  ItemSetting.LayoutHeight.Get(i) _
										  ) _
						,ItemSetting.Values.Get(i))
	Next
	xDialog.Initialize (NewItemPage)
	InputCLVItemsInit
End Sub

#Region item list creation
Public Sub CreateOptListItem (ItemTag As String, LayoutName As String, Height As Int) As B4XView
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0dip,0dip,0dip, 100%x, Height*GetDeviceLayoutValues.Scale)
	p.LoadLayout(LayoutName)
	p.Enabled = False
	p.Tag = ItemTag
	Return p
End Sub

Private Sub InputCLVItemsInit ()
	'CVInputBarcode
	PageContent.GetPanel(0).GetView(0).Text = "Barcode Scan"
	'BtnScanNew.Text = "0xF030"
	'TitleNewCode.Text = "Code"
	ValueScanCode.Text = ""
	'CVInputInfo
	PageContent.GetPanel(1).GetView(0).Text = "Beschreibung"
	TextFieldInfo.Text = "Info Text"
	'CVInputTextWithSearch Name
	PageContent.GetPanel(2).GetView(0).Text = "Bezeichnung"
	TextFieldSearch.Text = ""
	'CVInputTextWithSearch Category
	PageContent.GetPanel(3).GetView(0).Text = "Kategorie"
	TextFieldSearch.Text = ""
	'CVInputCooling
	PageContent.GetPanel(4).GetView(0).Text = "Kühlschrank Zone"
	PageContent.GetPanel(4).GetView(1).Text = "Kühl"
	PageContent.GetPanel(4).GetView(2).Text = "Frost"
	PageContent.GetPanel(4).GetView(3).Text = "andere"
	'IconCool.Text = ""
	'IconIce.Text = ""
	'IconExtra.Text = ""
	'CVInputLocation
	CLVLocation1.AddTextItem ("No config", "")
	CLVLocation2.AddTextItem ("No config", "")
	CLVLocation3.AddTextItem ("No config", "")
	CLVLocation4.AddTextItem ("No config", "")
	'CVInputImage
	PageContent.GetPanel(6).GetView(0).Text = "No image"
	ImageItemImage.Tag = "Not implemented"
	ListViewSearch.AddTextItem ("Not yet implemented", "")
	'CVInputAmount
	PageContent.GetPanel(7).GetView(0).Text = "Menge"
	TextFieldAmount.Text = ""
	PageContent.GetPanel(7).GetView(1).Text = "Einheit"
	ComboBoxUnit.SetItems (Array ("stck.", "g", "kg", "ml", "l"))
	'CVInputDates
	PageContent.GetPanel(8).GetView(0).Text = "MHD"
	PageContent.GetPanel(8).GetView(1).Text = "Eingelagert"
	DateTemplate.Initialize
	DateTemplate.MinYear = DateTime.GetYear(DateTime.Now)
	DateTemplate.MaxYear = DateTime.GetYear(DateTime.Now) + 10
	PageContent.GetPanel(8).GetView(3).Text = DateTime.Date(DateTime.Now)
	'CVInputSaveAbort
	PageContent.GetPanel(9).GetView(0).Text = "Einräumen"
	PageContent.GetPanel(9).GetView(1).Text = "Abbruch"
End Sub
#End Region item list creation

Private Sub IconCool_Click
	If 1 = ItemSetting.Values.Get("Cooling") Then
		IconCoolClear 
		Return
	End If
	IconCool.TextColor = 0xFF003FFF
	IconIce.TextColor = 0xFF000000
	IconExtra.TextColor = 0xFF000000
	ItemSetting.Values.Put("Cooling", 1)
End Sub

Private Sub IconIce_Click
	If 2 = ItemSetting.Values.Get("Cooling") Then
		IconCoolClear
		Return
	End If
	IconIce.TextColor = 0xFF003FFF
	IconCool.TextColor = 0xFF000000
	IconExtra.TextColor = 0xFF000000
	ItemSetting.Values.Put("Cooling", 2)
End Sub

Private Sub IconExtra_Click
	If 3 = ItemSetting.Values.Get("Cooling") Then
		IconCoolClear
		Return
	End If
	IconExtra.TextColor = 0xFF003FFF
	IconIce.TextColor = 0xFF000000
	IconCool.TextColor = 0xFF000000
	ItemSetting.Values.Put("Cooling", 3)
End Sub

Private Sub IconCoolClear ()
	IconCool.TextColor = 0xFFC0C0C0
	IconIce.TextColor = 0xFFC0C0C0
	IconExtra.TextColor = 0xFFC0C0C0
	ItemSetting.Values.Put("Cooling", 0)
End Sub

'Private Sub PageContent_ItemClick (Index As Int, Value As Object)
'	Log($"
'	GetType ${GetType(ItemSetting.Values.Get(PageContent.GetPanel(Index).Tag))}
'	ItemValue ${ItemSetting.Values.Get(PageContent.GetPanel(Index).Tag)}
'	CVLIndex ByEvenParameter: ${Index}
'	Identifier: ${PageContent.GetPanel(Index).Tag}
'	"$)
'	'CVLIndex ByEvent: ${PageContent.GetItemFromView(Sender)} -> Sender=Parent?
'End Sub

Private Sub btnHamburger_Click
	B4XPages.ShowPage("MainPage")
End Sub

Private Sub BtnScanCode_Click
	'xDialog.PutAtTop = True 'put the dialog at the top of the screen
	xDialog.Title = "Barcodescanner"
	xDialog.Show("Foto!", "Close", "", "")
	'GetValues
End Sub

'Get Date for EOL
Private Sub BtnEOLDate_Click
	'only CANCEL needed
	xDialog.Title = "MHD - Mindesthaltbarkeits-Datum"
	GetDateDialog(BtnEOLDate)
End Sub

'Get Date for BOL
Private Sub BtnBOLDate_Click
	xDialog.Title = "Jetzt - Einlagerungs-Datum"
	GetDateDialog(BtnBOLDate)
End Sub

'SaveData to DB
Private Sub BtnSaveData_Click
	
End Sub

'Abort Input
Private Sub BtnAbortData_Click
	
End Sub

'Get date via dialog
Public Sub GetDateDialog (DateBtn As Button)
	Wait For (xDialog.ShowTemplate(DateTemplate, "", "", "CANCEL")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		DateBtn.Text = DateTime.Date(DateTemplate.Date)
	End If
End Sub

'Get Map from Item
Private Sub GetValues ()
	ItemSetting.Values.Put("ScanCode",PageContent.GetValue(0))
	ItemSetting.Values.Put("Name",PageContent.GetValue(1))
	ItemSetting.Values.Put("Info",PageContent.GetValue(2))
	ItemSetting.Values.Put("Categroy",PageContent.GetValue(3))
	ItemSetting.Values.Put("Cooling",PageContent.GetValue(4))
	ItemSetting.Values.Put("LocationTag",PageContent.GetValue(5))
	ItemSetting.Values.Put("Image",PageContent.GetValue(6))
	ItemSetting.Values.Put("Amount, Unit",PageContent.GetValue(7))
	ItemSetting.Values.Put("EOL,BOL",PageContent.GetValue(8))
	ItemSetting.Values.Put("Save",PageContent.GetValue(9))
End Sub
