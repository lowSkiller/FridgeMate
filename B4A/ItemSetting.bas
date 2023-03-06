B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=12.2
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'CLV configuration data
	Public Itemlist As List
	
	Public LayoutName As Map

	Public LayoutHeight As Map

	Public ItemStatus As List 'For later change text and else editing posibilites
	'CLV item data
	Public Values As NestedMap

	'Item oject
	Public Item As fmItem
End Sub

Public Sub SetupConfigList ()	
	Item.Initialize
	Itemlist.Initialize
	Itemlist = Item.GetItems
	ItemStatus.Initialize 'For later
	LayoutName.Initialize
	LayoutName = Item.GetLayouts
	LayoutHeight.Initialize
	LayoutHeight = Item.GetLayoutHeigts
	Values.Initialize
	Values = Item.GetValues
End Sub
