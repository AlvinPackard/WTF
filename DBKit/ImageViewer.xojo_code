#tag Class
Protected Class ImageViewer
Inherits DesktopImageViewer
Implements  DBKit.Control
	#tag CompatibilityFlags = (TargetDesktop and (Target32Bit or Target64Bit))
	#tag Event
		Sub DropObject(obj As DragItem, action As DragItem.Types)
		  Var p As Picture
		  If Obj.PictureAvailable Then
		    p = obj.Picture
		  ElseIf Obj.FolderItemAvailable Then
		    p = Picture.Open(obj.FolderItem)
		    CurrentImageFile=obj.FolderItem
		  End If
		  
		  CurrentImage = p
		  
		  DropObject(obj, action)
		  
		  Connector.CheckForRowChange
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Enabled = False
		  
		  'Allow this control to accept a JPEG dropped on it
		  AcceptPictureDrop
		  AcceptFileDrop("image/jpeg")
		  
		  Opening
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Bind(tc As DBKit.Connector)
		  // Part of the DBKit.KitControl interface.
		  
		  If Column = "" Then
		    Column = Name
		  End If
		  Connector = tc
		  
		  If Table = "" Then
		    Table = tc.Table
		  End If
		  
		  'Only bind controls are for the same table as this connector
		  If Table = tc.Table Then
		    tc.BindEntryControl(Self, Column)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ImageAsFolderItem(ID_PK As Integer)
		  //Var img As picture
		  //If connector<>nil and connector.Connection IsA Database Then
		  //
		  //Var rs As RowSet
		  //Var sql As string="SELECT FlyPhoto FROM t_Fly WHERE ID_FLY=?"
		  //
		  //rs=Connector.Connection.SelectSQL(sql, ID_PK)
		  //
		  //var f As New FolderItem(rs.Column("FlyPhoto"))
		  //CurrentImage=Picture.open(f)
		  //
		  //End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event DropObject(obj as DragItem, action as DragItem.Types)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook


	#tag Property, Flags = &h0
		Column As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Connector As DBKit.Connector
	#tag EndProperty

	#tag Property, Flags = &h0
		CurrentImage As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		CurrentImageFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		Table As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Image"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Picture"
			EditorType="Picture"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="32"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="32"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabStop"
			Visible=true
			Group="Focus Control"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CurrentImage"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Picture"
			EditorType="Picture"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Table"
			Visible=true
			Group="DBKit"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Column"
			Visible=true
			Group="DBKit"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PanelIndex"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="_mIndex"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="_mInitialParent"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_mName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_mPanelIndex"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Active"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
