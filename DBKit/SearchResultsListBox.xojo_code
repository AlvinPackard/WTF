#tag Class
Protected Class SearchResultsListBox
Inherits DesktopListBox
Implements  DBKit.Control
	#tag CompatibilityFlags = (TargetDesktop and (Target32Bit or Target64Bit))
	#tag Event
		Sub Opening()
		  If Columns <> "" Then
		    Var theColumns() As String = Columns.Split(",")
		    BindDatabaseColumns(theColumns)
		  End If
		  
		  Opening
		End Sub
	#tag EndEvent

	#tag Event
		Sub SelectionChanged()
		  SelectionChanged
		  
		  If Connector <> Nil Then
		    Connector.LoadSelectedRow
		  end if
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AddRowsFromRowSet(rs As RowSet)
		  'Add rows to the listbox matching the columns in the rowset to the column bound
		  'via BindListBoxColumn
		  
		  For Each row As DatabaseRow In rs
		    AddRow("")
		    For i As Integer = 0 To row.ColumnCount - 1
		      Var cntrlColumnIndex As Integer
		      Var rowIndex As Integer = LastAddedRowIndex
		      For j As Integer = 0 To LastColumnIndex
		        If ColumnTagAt(j) <> "" Then 
		          CellTextAt(rowIndex, j) = ColumnValue(ColumnTagAt(j), row)
		        End If
		      Next
		    Next
		    'Set the row tag to the primary key so we can find this row to display it in the bound entry controls
		    var colWanted As String
		    colWanted=Connector.PrimaryKeyColumn
		    var newValue As variant=rs.Column(Connector.PrimaryKeyColumn).Value
		    RowTagAt(LastAddedRowIndex) = rs.Column(Connector.PrimaryKeyColumn).Value
		  Next
		  
		  'If there is at least one row, select and load it
		  If RowCount > 0 Then
		    SelectedRowIndex = 0
		    Connector.LoadSelectedRow
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Bind(tc As DBKit.Connector)
		  // Part of the DBKit.KitControl interface.
		  
		  Connector = tc
		  tc.BindListBoxControl(Self)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BindDatabaseColumns(theColumns() As String)
		  Var listboxColumnIndex As Integer
		  if ColumnCount < theColumns.Count then ColumnCount = theColumns.Count
		  For Each colName As String In theColumns
		    If colName <> "" Then
		      ColumnTagAt(listboxColumnIndex) = colName.Lowercase.Trim
		    End If
		    listboxColumnIndex = listboxColumnIndex + 1
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BindDatabaseColumns(paramarray columns As String)
		  'So it can be passed a paramarray
		  BindDatabaseColumns(columns)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ColumnValue(columnNames As String, row As DatabaseRow) As String
		  Var theValue As String
		  Var columns() As String = columnNames.Split(",")
		  If Concatenater = "" Then Concatenater = " "
		  For Each column As String In columns
		    theValue = theValue + row.Column(column).StringValue + Concatenater
		  Next
		  
		  theValue = theValue.Trim(Concatenater)
		  
		  Return theValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ColumnValue(columnNames As String, row As RowSet) As String
		  Var theValue As String
		  Var columns() As String = columnNames.Split(",")
		  If Concatenater = "" Then Concatenater = " "
		  For Each column As String In columns
		    theValue = theValue + row.Column(column).StringValue + Concatenater
		  Next
		  
		  theValue = theValue.Trim(Concatenater)
		  
		  Return theValue
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SelectionChanged()
	#tag EndHook


	#tag Property, Flags = &h0
		Columns As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Concatenater As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Connector As DBKit.Connector
	#tag EndProperty


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
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue="False"
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
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
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
		#tag ViewProperty
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasBorder"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnCount"
			Visible=true
			Group="Appearance"
			InitialValue="1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnWidths"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultRowHeight"
			Visible=true
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
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
			Name="GridLineStyle"
			Visible=true
			Group="Appearance"
			InitialValue="0"
			Type="GridLineStyles"
			EditorType="Enum"
			#tag EnumValues
				"0 - None"
				"1 - Horizontal"
				"2 - Vertical"
				"3 - Both"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasHeader"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HeadingIndex"
			Visible=true
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
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
			Name="InitialValue"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasHorizontalScrollbar"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasVerticalScrollbar"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DropIndicatorVisible"
			Visible=true
			Group="Appearance"
			InitialValue="False"
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
			Name="AllowFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="True"
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
			Name="AllowAutoHideScrollbars"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowResizableColumns"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowRowDragging"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowRowReordering"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowExpandableRows"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RequiresSelection"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RowSelectionType"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="RowSelectionTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Single"
				"1 - Multiple"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Concatenater"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Bold"
			Visible=true
			Group="Font"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Italic"
			Visible=true
			Group="Font"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontName"
			Visible=true
			Group="Font"
			InitialValue="System"
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontSize"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="Single"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontUnit"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="FontUnits"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - Pixel"
				"2 - Point"
				"3 - Inch"
				"4 - Millimeter"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Underline"
			Visible=true
			Group="Font"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Columns"
			Visible=true
			Group="DBKit"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="_ScrollOffset"
			Visible=false
			Group="Appearance"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="_ScrollWidth"
			Visible=false
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
