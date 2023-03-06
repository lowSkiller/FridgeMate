B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.2
@EndOfDesignText@
'Class: NestedMap
'Author: mindful
'Source: https://www.b4x.com/android/forum/threads/class-nestedmap-a-map-in-a-map-with-n-levels.76163/#post-483359
Sub Class_Globals
	Private mm As Map 'Maps
	Private nm As Map 'Nodes
End Sub

'Initializes the NestedMap
Public Sub Initialize()
	mm.Initialize
	nm.Initialize
End Sub

'Puts a key value pair to the map, overwriting the previous item with the same key (if such exists).
'Returns the previous item with this key or null if there was no such item.
Public Sub Put(Key As Object, Value As Object) As Object
	Return mm.Put(Key, Value )
End Sub

'Adds a node to the map and returns that node.
Public Sub PutNode(NodeKey As Object, OverwriteIfExists As Boolean) As NestedMap
	If OverwriteIfExists = False And nm.ContainsKey(NodeKey) Then
		Return nm.Get(NodeKey)
	End If
	Dim nn As NestedMap
	nn.Initialize()
	nm.Put(NodeKey, nn)
	Return nn
End Sub

'Adds a map containing key value pairs to the NestedMap.
'Note: It will overwrite all key value paris with the ones in the provided map.
Public Sub PutKeyValueMap(KeyValueMap As Map)
	mm = KeyValueMap
End Sub

'Checks if the NestedMap contains the given key.
Public Sub ContainsKey(Key As Object) As Boolean
	Return mm.ContainsKey(Key)
End Sub

'Checks if the NestedMap contains the given node key.
Public Sub ContainsNode(NodeKey As Object) As Boolean
	Return nm.ContainsKey(NodeKey)
End Sub

'Gets the value object that has been assigned to the provided key.
'When Get is Node, return as map. Only works on 1st level Node, hihgher levels need GetNode.
'Edited: MHummel
Public Sub Get(Key As Object) As Object
'Get also on secondlevel means unique naming!
	If mm.ContainsKey(Key) Then	
		Return mm.Get(Key)
	'First level Node Map Return
	Else
		Dim nn As NestedMap
		nn.Initialize
		nn = nm.Get(Key)	'Get 
		Return nn.mm
	End If
End Sub

'Gets the value object that has been assigned to the provided key. If no such key exists the default value is returned.
Public Sub GetDefault(Key As Object, Default As Object) As Object
	Return mm.GetDefault(Key, Default)
End Sub

Public Sub GetKeyValueMap() As Map
	Return mm
End Sub

'Gets the node object(NestedMap) that has been assigned to the provided node key.
Public Sub GetNode(NodeKey As Object) As NestedMap
	Return nm.Get(NodeKey)
End Sub

'Removes the key value pair from the NestedMap that is identified by the provided key.
Public Sub Remove(Key As Object)
	mm.Remove(Key)
End Sub

'Removes the node object from the NestedMap that is identified by the provided node key.
Public Sub RemoveNode(NodeKey As Object)
	nm.Remove(NodeKey)
End Sub

'Removes all the NestedMap key value pairs.
Public Sub Clear()
	mm.Clear
End Sub

'Removes all the NestedMap nodes.
Public Sub ClearNodes()
	nm.Clear
End Sub

'Returns the count of the key value pairs.
Public Sub getSize As Int
	Return mm.Size
End Sub

'Returns the count of the nodes.
Public Sub getNodesSize As Int
	Return nm.Size
End Sub

'Returns a list of keys from the key value pairs.
Public Sub getKeys() As List
	Return mm.Keys
End Sub

'Returns a list of values from the key value pairs.
Public Sub getValues() As List
	Return mm.Values
End Sub

'Returns a list of node keys.
Public Sub getNodes() As List
	Return nm.Keys
End Sub
