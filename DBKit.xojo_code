#tag Module
Protected Module DBKit
	#tag CompatibilityFlags = API2Only and ( (TargetDesktop and (Target64Bit)) )
	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetDesktop and (Target32Bit or Target64Bit)) )
		Function IndexOf(Extends cntrl As DesktopRadioGroup, theCaption As String) As Integer
		  'Takes a caption and returns it's index
		  For i As Integer = 0 To cntrl.Count - 1
		    If cntrl.ItemAt(i).Caption = theCaption Then
		      Return i
		    End If
		  Next
		  
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(extends rows As RowSet, column As String) As Integer
		  Try
		    'Returns the column index for the Column provided
		    For i As Integer = 0 To rows.LastColumnIndex
		      Var dbc As DatabaseColumn
		      dbc = rows.ColumnAt(i)
		      If dbc.Name = Column Then
		        Return i
		      End If
		    Next
		    
		  Catch error As DatabaseException
		    MessageBox("Error: This column not be found in the database: " + column)
		  End Try
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetWeb and (Target32Bit or Target64Bit)) )
		Function IndexOf(Extends cntrl As WebRadioGroup, theCaption As String) As Integer
		  'Takes a caption and returns it's index
		  For i As Integer = 0 To cntrl.Count - 1
		    If cntrl.ItemAt(i).Caption = theCaption Then
		      Return i
		    End If
		  Next
		  
		  Return -1
		End Function
	#tag EndMethod


	#tag Constant, Name = Version, Type = String, Dynamic = False, Default = \"1.0b6", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
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
			InitialValue="-2147483648"
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
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
