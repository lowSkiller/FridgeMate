B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private MainPage As B4XView
	Private NewItemPage As B4XNewItemPage
	
	Private xui As XUI
	Private PageContent As CustomListView
	Private fmBmp As List
	Private ImageView1 As ImageView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Log("Start Page Create")
	MainPage = Root1
	MainPage.LoadLayout("MainPage")
	
	fmBmp.Initialize
	Log($"#####First outside"$)
	fmBmp.AddAll(CreatePictureSet("outside",PageContent))
	Log($"#####second inside"$)
	fmBmp.AddAll(CreatePictureSet("inside",PageContent))
	'Log($"${fmBmp.Size}"$)
End Sub
'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub btnHamburger_Click
	If NewItemPage.IsInitialized <> True Then 
		NewItemPage.Initialize
		B4XPages.AddPage("NewItemPage", NewItemPage)
	End If
	B4XPages.ShowPage("NewItemPage")
	
End Sub

'Create the View
Public Sub CreatePicture (bmpImage As B4XBitmap, bmpWidth As Int, bmpHeight As Int, strTag As String) As B4XView
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0,0dip,0dip, bmpWidth, bmpHeight) 'PageContent.sv.Height*GetDeviceLayoutValues.Scale)
	p.LoadLayout("CVSingleImage")
	p.Enabled = False
	p.Tag = strTag
		
	ImageView1.Bitmap = bmpImage
	ImageView1.Height = bmpHeight
	ImageView1.Width = bmpWidth
	Return p
End Sub

'Generate views and return list of views
Public Sub CreatePictureSet (strPictureSetName As String, clvCustomView As CustomListView) As List
	Dim listCPS As List 'Creatable pictures from strPictureSetName
	Dim mapB4XImages As Map 'of B4XViews only
	
	'Search for lictures in files
	listCPS.Initialize
	mapB4XImages.Initialize
	Dim iListNo As Int = 0
	Dim iSumWidth As Int = 0
	Dim iMaxHeight As Int = 0
	For Each strFileName As Object In File.ListFiles(File.DirAssets)
		Dim text As String = strFileName
		'Log($"${strFileName}"$)
		'Search only for .png
		If text.SubString2(text.Length-4,text.Length).CompareTo(".png") = 0 Then
		 'Search name
			If text.SubString2(0,text.Length-5).CompareTo(strPictureSetName) = 0 Then
				'Log($"$     take it"$)
				listCPS.Add(text.SubString2(0,text.Length-4))
				iListNo = listCPS.Size-1
				mapB4XImages.Put(iListNo,xui.LoadBitmap(File.DirAssets, listCPS.Get(iListNo) & ".png"))
				iSumWidth = iSumWidth + mapB4XImages.Get(iListNo).As(B4XBitmap).Width
				iMaxHeight = Max(mapB4XImages.Get(iListNo).As(B4XBitmap).Height, iMaxHeight)
			End If
		End If
	Next
	
	'Calculate resize on height
	Dim dWidthFactor As Double = 0.0
	Dim dHeightBmp As Double = 0.0
	Dim dHeightFactor As Double = 0.0
	Dim dWidthBmp As Double = 0.0
	dWidthFactor = PageContent.sv.Width.As(Double) / iSumWidth.As(Double)
	dHeightFactor = PageContent.sv.Height.As(Double) / iMaxHeight.As(Double)
	
	'Scan pics and build view
	Dim strLabel As String
	For i=0 To listCPS.Size-1
		strLabel = "fPic" & strPictureSetName.ToUpperCase.CharAt(1)& strPictureSetName.Substring(2) & i
		dWidthBmp = mapB4XImages.Get(i).As(B4XBitmap).Width * dWidthFactor
		dHeightBmp = mapB4XImages.Get(i).As(B4XBitmap).Height * dWidthFactor
		If dHeightBmp > PageContent.sv.Height Then
			dHeightBmp = PageContent.sv.Height
			dWidthBmp = mapB4XImages.Get(i).As(B4XBitmap).Width * dHeightFactor
		End If
		clvCustomView.Add(CreatePicture(mapB4XImages.Get(i).As(B4XBitmap), _
										dWidthBmp.As(Int), _
										dHeightBmp.As(Int), _
										strLabel), _
										strLabel)
	Next
	Return listCPS
End Sub
