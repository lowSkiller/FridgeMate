B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.2
@EndOfDesignText@
'Class fridge mate location, place in storage
Sub Class_Globals
	Public ID As Int
	Public Name As String
	Public Item() As fmItem
	Public SupLocation As Int 'Unique description at Storage
	Public Location As Int 'Unique ID
	Public LocationDesc As String 'Unique descriptor at Location
	Private Temperature As Int 'Temperature in Celcius at Location
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	ID = 0
	Name = "NEW"
	SupLocation = 0
	Location = 0
	Temperature = 20 'Celcius
End Sub

Public Sub TempSetCelcius (t As Int)
	If t<(-273.15) Then
		Temperature=273.15
	Else
		Temperature=t
	End If
End Sub

Public Sub TempSetFahrenheit (t As Int)
	If t<(-459.67) Then
		Temperature = -459.67
	Else
		Temperature  =(t-32)/1.8	
	End If
End Sub

Public Sub TempGetCelcius (t As Int)
	Temperature=t
End Sub

Public Sub TempGetFahrenheit (t As Int)
	Temperature=t*1.8 + 32
End Sub
