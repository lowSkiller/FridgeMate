﻿B4A=true
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
Public Sub CreatePicture (bmpImage As B4XBitmap, bmpWidth As Int, bmpHeight As Int) As B4XView
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0dip,0dip,0dip, bmpWidth, PageContent.sv.Height*GetDeviceLayoutValues.Scale)
	p.LoadLayout("CVSingleImage")
	p.Enabled = False
	p.Tag = ""
	
	'Log($"${strImage}"$)
	ImageView1.Bitmap = bmpImage
	ImageView1.Height = bmpHeight 'bmpImage.Height*p.Width/bmpImage.Width
	ImageView1.Width = bmpWidth
	Return p
End Sub

'Generate views and return list of views
Public Sub CreatePictureSet (strPictureSetName As String, clvCustomView As CustomListView) As List
	Dim listCPS As List 'Creatable pictures from set
	Dim mapB4XImages As List 'of B4XViews only
	
	listCPS.Initialize
	'Search for lictures in files
	For Each strFileName As Object In File.ListFiles(File.DirAssets)
		Dim text As String = strFileName
		'Log($"${strFileName}"$)
		'Search only for .png


		If text.SubString2(text.Length-4,text.Length).CompareTo(".png") = 0 Then
		 'Search name
			If text.SubString2(0,text.Length-5).CompareTo(strPictureSetName) = 0 Then
				'Log($"$     take it"$)
				listCPS.Add(text.SubString2(0,text.Length-4))
			End If
		End If
	Next
	'Create views from generated List
	mapB4XImages.Initialize
	'Map pictures.from List
	Dim iSumWidth As Int = 0
	Dim iMaxHeight As Int = 0
	For i=0 To listCPS.Size-1
		mapB4XImages.Add(xui.LoadBitmap(File.DirAssets, listCPS.Get(i) & ".png"))
		iSumWidth = iSumWidth + mapB4XImages.Get(i).As(B4XBitmap).Width
	Next
	
	Dim dWidthFactor As Double = 0.0
	Dim dHeightFactor As Double = 0.0
	dWidthFactor = (PageContent.sv.Width/iSumWidth).As(Double)
	dHeightFactor = (PageContent.sv.Height/iMaxHeight).As(Double)
	
	For Each bmp As B4XBitmap In mapB4XImages
	 'ToDo: CreatePicture verwenden, übergabe von höhe und breite umsetzen.
		clvCustomView.Add(CreatePicture(bmp, _
										bmp.Width*PageContent.sv.Width/iSumWidth, _
										bmp.Height*PageContent.sv.Width/iSumWidth), _
										"FridgePic" & i)
	Next
	Return listCPS
End Sub
