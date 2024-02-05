#tag Class
 Attributes ( Version = 1.0 ) Protected Class Connector
	#tag Method, Flags = &h21
		Private Function ArePicturesIdentical(image1 As Picture, image2 As Picture) As Boolean
		  ' First, check if both images are not nil
		  If image1 Is Nil Or image2 Is Nil Then
		    Return False
		  End If
		  
		  ' Check if both images have the same dimensions
		  If image1.Width <> image2.Width Or image1.Height <> image2.Height Then
		    Return False
		  End If
		  
		  ' Get RGBSurfaces to access pixel data
		  Var surf1 As RGBSurface = image1.RGBSurface
		  Var surf2 As RGBSurface = image2.RGBSurface
		  
		  ' If either image lacks an RGBSurface, they can't be compared
		  If surf1 Is Nil Or surf2 Is Nil Then
		    Return False
		  End If
		  
		  ' Compare pixel by pixel
		  For y As Integer = 0 To image1.Height - 1
		    For x As Integer = 0 To image1.Width - 1
		      Var color1 As Color = surf1.Pixel(x, y)
		      Var color2 As Color = surf2.Pixel(x, y)
		      
		      ' Check the absolute difference of Red, Green, Blue, and Alpha components
		      'If it's greater than 50 then it probably a different picture
		      Const colorDelta = 50
		      If Abs(color1.Red - color2.Red) > colorDelta Or Abs(color1.Green - color2.Green) > colorDelta Or Abs(color1.Blue - color2.Blue) > colorDelta Or Abs(color1.Alpha - color2.Alpha) > colorDelta Then
		        Var diff As Integer 'only for debugging images to determine what color delta they have
		        diff = Abs(color1.Red - color2.Red)
		        diff = Abs(color1.Green - color2.Green)
		        diff = Abs(color1.Blue - color2.Blue)
		        diff = Abs(color1.Alpha - color2.Alpha)
		        Return False
		      End If
		    Next
		  Next
		  
		  ' If all pixels are the same (within the tolerance), the images are identical
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetDesktop and (Target32Bit or Target64Bit)) )
		Sub BindControls(layout As DesktopWindow)
		  If Table = "" Then
		    Var e As New DatabaseException
		    e.Message = "The Table property for an instance of DBKit.Connector cannot be nil."
		    Raise e
		  Else
		    Var controlTabIndex As Integer = 100000
		    For Each c As DesktopUIControl In layout.Controls
		      If c IsA DBKit.Control Then
		        DBKit.Control(c).Bind(Self)
		        'Now let's find out which DBKit control is first in the tab order
		        If (c IsA DBKit.TextField Or c IsA DBKit.TextArea) Then
		          If c.TabIndex < controlTabIndex Then
		            controlTabIndex = c.TabIndex
		            firstDBKitDesktopControlInTabOrder = c
		          End If
		        End If
		      End If
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetWeb and (Target32Bit or Target64Bit)) )
		Sub BindControls(layout As WebPage)
		  If Table = "" Then
		    Var e As New DatabaseException
		    e.Message = "The Table property for an instance of DBKit.Connector cannot be nil."
		    Raise e
		  Else
		    Var controlTabIndex As Integer = 100000
		    For Each c As WebUIControl In layout.Controls
		      If c IsA DBKit.Control Then
		        DBKit.Control(c).Bind(Self)
		        'Now let's find out which DBKit control is first in the tab order
		        If (c IsA DBKit.Web.DBTextField Or c IsA DBKit.Web.DBTextArea) Then
		          If c.TabIndex < controlTabIndex Then
		            controlTabIndex = c.TabIndex
		            firstDBKitWebControlInTabOrder = c
		          End If
		        End If
		      End If
		    Next
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetDesktop and (Target32Bit or Target64Bit)) )
		Sub BindDeleteButton(button As DesktopToolbarButton)
		  DeleteButton = button
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetDesktop and (Target32Bit or Target64Bit)) )
		Sub BindDeleteButton(button As DesktopUIControl)
		  DeleteButton = button
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetWeb and (Target32Bit or Target64Bit)) )
		Sub BindDeleteButton(button As WebToolbarButton)
		  DeleteButton = button
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetWeb and (Target32Bit or Target64Bit)) )
		Sub BindDeleteButton(button As WebUIControl)
		  DeleteButton = button
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) )
		Sub BindEditButton(button As DesktopToolbarButton)
		  EditButton = button
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetDesktop and (Target32Bit or Target64Bit)) )
		Sub BindEditButton(button As DesktopUIControl)
		  EditButton = button
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetWeb and (Target32Bit or Target64Bit)) )
		Sub BindEditButton(button As WebToolbarButton)
		  EditButton = button
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetWeb and (Target32Bit or Target64Bit)) )
		Sub BindEditButton(button As WebUIControl)
		  EditButton = button
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetDesktop and (Target32Bit or Target64Bit)) )
		Sub BindEntryControl(control As DesktopUIControl, column As String = "")
		  Var cntrl As New Dictionary
		  cntrl.Value("control") = control
		  If Column = "" Then
		    cntrl.Value("Column") = control.Name.Lowercase
		  Else
		    cntrl.Value("Column") = Column.Lowercase
		  End If
		  
		  BoundControls.Add(cntrl)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetWeb and (Target32Bit or Target64Bit)) )
		Sub BindEntryControl(control As WebUIControl, column As String = "")
		  Var cntrl As New Dictionary
		  cntrl.Value("control") = control
		  If Column = "" Then
		    cntrl.Value("Column") = control.Name.Lowercase
		  Else
		    cntrl.Value("Column") = Column.Lowercase
		  End If
		  
		  BoundControls.Add(cntrl)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetDesktop and (Target32Bit or Target64Bit)) )
		Sub BindListBoxColumn(control As DesktopListBox, columnNumber As Integer, column As String)
		  control.ColumnTagAt(columnNumber) = Column.Lowercase
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetWeb and (Target32Bit or Target64Bit)) )
		Sub BindListBoxColumn(control As WebListBox, columnNumber As Integer, column As String)
		  'Requires 2023r2 as WebListBox.ColumnTagAt did not exist prior to that
		  #If XojoVersion > 2023.01 Then
		    control.ColumnTagAt(columnNumber) = Column.Lowercase
		  #Else
		    MessageBox("Using DBKit for web applications with Xojo versions prior to 2023r2 is not supported.")
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) )
		Sub BindListBoxControl(control As DBKit.SearchResultsListBox)
		  BoundListBoxControl = control
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetDesktop and (Target32Bit or Target64Bit)) )
		Sub BindNewButton(button As DesktopButton)
		  NewButton = button
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetWeb and (Target32Bit or Target64Bit)) )
		Sub BindNewButton(button As WebButton)
		  NewButton = button
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) )
		Sub BindUndoButton(button As DesktopToolbarButton)
		  UndoButton = button
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetDesktop and (Target32Bit or Target64Bit)) )
		Sub BindUndoButton(button As DesktopUIControl)
		  UndoButton = button
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetWeb and (Target32Bit or Target64Bit)) )
		Sub BindUndoButton(button As WebToolbarButton)
		  UndoButton = button
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetWeb and (Target32Bit or Target64Bit)) )
		Sub BindUndoButton(button As WebUIControl)
		  UndoButton = button
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CheckForRowChange()
		  If AllowCheckForRowChange Then
		    
		    If UndoButton <> Nil Then
		      Var changed As Boolean = CurrentRowChanged
		      
		      If UndoButton <> Nil And NewRow = Nil Then
		        
		        SetButtonEnabledState(UndoButton, changed)
		        
		      End If
		      
		    End If
		    
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ColumnValueChanged(column As String, Value As Variant) As Boolean
		  Try
		    If NewRow = Nil Then
		      
		      Var colType As Integer = currentRow.ColumnType(CurrentRow.IndexOf(Column))
		      If colType >= 14 And colType <= 17 Then
		        'It's a BLOB
		        If value IsA Picture Then
		          'Has the picture changed?
		          If Not ArePicturesIdentical(Picture(value), CurrentRow.Column(Column).PictureValue) Then
		            Return True
		          End If
		        End If
		        
		      Else
		        If value.Type = 8 or value.Type=5 Then 'if it's a string
		          'see if the it's a perfect match - case included
		          If value.StringValue.Compare(CurrentRow.Column(Column).StringValue, ComparisonOptions.CaseSensitive) <> 0 Then
		            Return True
		          End If
		        ElseIf CurrentRow.Column(Column).Value <> value Then
		          Return True
		        End If
		        
		      End If
		    End If
		    
		    Return False
		    
		  Catch error As DatabaseException
		    MessageBox(ErrorColumnValueChanged + Column)
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) )
		Sub ConfirmDeleteRow(windowToClose As DesktopWindow = Nil)
		  System.Beep
		  'Create the confirmation dialog box
		  Var confirmDialog As New MessageDialog
		  confirmDialog.IconType = MessageDialog.IconTypes.Caution
		  confirmDialog.Title = DeleteConfirmTitle
		  confirmDialog.Message = DeleteConfirmMessage
		  confirmDialog.Explanation = DeleteConfirmExplanation
		  confirmDialog.ActionButton.Caption = DeleteConfirmContinue
		  confirmDialog.CancelButton.Caption = DeleteConfirmCancel
		  confirmDialog.CancelButton.Visible = True
		  confirmDialog.CancelButton.Default = True
		  'Display the dialog
		  Var buttonPressed As MessageDialogButton
		  buttonPressed = confirmDialog.ShowModal
		  If buttonPressed.Caption = DeleteConfirmContinue Then
		    RemoveSelectedRow
		    If windowToClose <> Nil Then
		      windowToClose.Close
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetWeb and (Target32Bit or Target64Bit)) )
		Sub ConfirmDeleteRow(pageToClose As WebPage = Nil)
		  'Confirm the user wants to continue (delete) or cancel.
		  Var confirmDialog As New WebMessageDialog
		  confirmDialog.Message = DeleteConfirmMessage + " " + DeleteConfirmExplanation
		  confirmDialog.ActionButton.Caption = DeleteConfirmContinue
		  confirmDialog.ActionButton.Default = False
		  confirmDialog.CancelButton.Caption = DeleteConfirmCancel
		  confirmDialog.CancelButton.Default = True
		  confirmDialog.CancelButton.Visible = True
		  AddHandler confirmDialog.ButtonPressed, AddressOf WebConfirmDeleteDialogButtonPressed
		  Self.pageToClose = pageToClose
		  confirmDialog.Show
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = API2Only and ( (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) )
		Private Sub ConfirmUnsavedChanges(continueMethod As noParameters = Nil, cancelMethod As NoParameters = Nil)
		  
		  'The user has unsaved changes. Ask them if they wish to continue.
		  
		  #If TargetDesktop Or TargetiOS Then
		    System.Beep
		    'Create the confirmation dialog box
		    Var confirmDialog As New MessageDialog
		    confirmDialog.IconType = MessageDialog.IconTypes.Caution
		    confirmDialog.Title = ConfirmTitle
		    confirmDialog.Message = ConfirmMessage
		    confirmDialog.Explanation = ConfirmExplanation
		    confirmDialog.ActionButton.Caption = ConfirmContinue
		    confirmDialog.CancelButton.Caption = ConfirmCancel
		    confirmDialog.CancelButton.Visible = True
		    confirmDialog.CancelButton.Default = True
		    
		    'Display the dialog
		    Var buttonPressed As MessageDialogButton
		    buttonPressed = confirmDialog.ShowModal
		    If buttonPressed.Caption = ConfirmContinue Then
		      continueMethod.Invoke
		    ElseIf buttonPressed.Caption = ConfirmCancel Then
		      If cancelMethod <> Nil Then
		        cancelMethod.Invoke
		      End If
		    End If
		    
		  #ElseIf TargetWeb Then
		    
		    'Confirm the user wants to continue (and lose changes) or cancel (and have the opportunity to save changes).
		    Var confirmDialog As New WebMessageDialog
		    confirmDialog.Message = ConfirmMessage + " " + ConfirmExplanation
		    confirmDialog.ActionButton.Caption = ConfirmContinue
		    confirmDialog.ActionButton.Default = False
		    confirmDialog.CancelButton.Caption = ConfirmCancel
		    confirmDialog.CancelButton.Default = True
		    confirmDialog.CancelButton.Visible = True
		    If continueMethod <> Nil Then
		      WebConfirmContinueMethod = continueMethod
		    End If
		    If cancelMethod <> Nil Then
		      WebConfirmCancelMethod = cancelMethod
		    End If
		    AddHandler confirmDialog.ButtonPressed, AddressOf WebConfirmDialogButtonPressed
		    confirmDialog.Show
		    
		  #EndIf
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Connected(serverType As DatabaseServer, host As String, port As Integer, databaseName As String, user As String, password As String) As Boolean
		  Try
		    If Connection = Nil Then
		      
		      Select Case serverType
		      Case DatabaseServer.MySQL
		        Connection = New MySQLCommunityServer
		        MySQLCommunityServer(Connection).Host = host
		        MySQLCommunityServer(Connection).Port = port
		        MySQLCommunityServer(Connection).databaseName = databaseName
		        MySQLCommunityServer(Connection).UserName = user
		        MySQLCommunityServer(Connection).Password = password
		        
		      Case DatabaseServer.Postgres
		        Connection = New PostgreSQLDatabase
		        PostgreSQLDatabase(Connection).Host = host
		        PostgreSQLDatabase(Connection).Port = port
		        PostgreSQLDatabase(Connection).databaseName = databaseName
		        PostgreSQLDatabase(Connection).UserName = user
		        PostgreSQLDatabase(Connection).Password = password
		      End Select
		      
		      Try
		        Connection.Connect
		        Return True
		      Catch error As DatabaseException
		        Return False
		      End Try
		      
		    Else
		      Return (connection <> Nil)
		    End If
		    
		  Catch error As DatabaseException
		    MessageBox(ErrorNoConnection)
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Connected(dbFile As FolderItem = Nil) As boolean
		  Try
		    If Connection = Nil And dbFile <> Nil Then
		      
		      Connection = New SQLiteDatabase
		      SQLiteDatabase(Connection).DatabaseFile = dbFile
		      Try
		        Connection.Connect
		        Return True
		      Catch error As DatabaseException
		        Return False
		      End Try
		      
		    Else
		      return (connection <> nil)
		    End If
		    
		  Catch error As DatabaseException
		    MessageBox(ErrorNoConnection)
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  #If TargetWeb Then
		    If session <> Nil Then
		      SessionID = session.Identifier
		    End If
		  #EndIf
		  
		  'If a connection has already been established in the app class, use that.
		  Connection = ExistingDBConnection
		  
		  'Wait 100 ms so the controls can be created (desktop)
		  Timer.CallLater(100, AddressOf FireOpeningEvent)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) )
		Private Function ControlForColumnDesktop(column As String) As DesktopUIControl
		  'Returns the control bound to the column passed
		  For Each item As Variant In BoundControls
		    If item IsA Dictionary Then
		      Var colName As String = Dictionary(item).Lookup("Column", "")
		      If colName = Column Then
		        Return DesktopUIControl(Dictionary(item).Value("control"))
		      End If
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = API2Only and ( (TargetIOS and (Target64Bit)) )
		Private Function ControlForColumnMobile(columnName As String) As MobileUIControl
		  'Returns the control bound to the column passed
		  For Each item As Variant In BoundControls
		    If item IsA Dictionary Then
		      If Dictionary(item).HasKey(Column) Then
		        Return MobileUIControl(Dictionary(item).Value(Column))
		      End If
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = API2Only and ( (TargetWeb and (Target32Bit or Target64Bit)) )
		Private Function ControlForColumnWeb(column As String) As WebUIControl
		  'Returns the control bound to the column passed
		  For Each item As Variant In BoundControls
		    If item IsA Dictionary Then
		      If Dictionary(item).HasKey("Column") Then
		        If Dictionary(item).Value("Column") = Column Then
		          Return WebUIControl(Dictionary(item).Value("control"))
		        End If
		      End If
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CurrentRowChanged() As Boolean
		  'Compare the row that was loaded to the values in the UI controls to determine
		  'if the user has changed the row or not. This allows the app to check for a changed
		  'row in whatever row list control the interface has (a ListBox for example) and 
		  'optionally confirm with the user that they want to continue and lose the changes they
		  'made or not.
		  
		  If NewRow <> Nil Then Return TRUE
		  
		  For Each cntrl As Dictionary In BoundControls
		    
		    Var Column As String = cntrl.Value("Column").StringValue
		    
		    #If TargetDesktop Then
		      
		      Var c As DesktopUIControl = cntrl.Value("control")
		      If Not c.Enabled Then
		        c.Enabled = True
		      End If
		      
		      Select Case c
		      Case IsA DBKit.CheckBox
		        Var cbValue As Integer
		        If DBKit.CheckBox(c).Value Then
		          cbValue = 1
		        End If
		        If ColumnValueChanged(Column, cbValue) Then
		          Return True
		        End If
		        
		      Case IsA DBKit.ComboBox
		        If ColumnValueChanged(Column, DBKit.ComboBox(c).Text) Then
		          Return True
		        End If
		        
		      Case IsA DBKit.DateTimePicker
		        Var pickerValue As String
		        Select Case DBKit.DateTimePicker(c).DisplayMode
		        Case DBKit.DateTimePicker.DisplayModes.DateAndTime
		          pickerValue = DBKit.DateTimePicker(c).SelectedDate.SQLDateTime
		        Case DBKit.DateTimePicker.DisplayModes.DateOnly
		          pickerValue = DBKit.DateTimePicker(c).SelectedDate.SQLDate
		        End Select
		        If ColumnValueChanged(Column, pickerValue) Then
		          Return True
		        End If
		        
		      Case IsA DBKit.ImageViewer
		        
		        If ColumnValueChanged(Column, DBKit.ImageViewer(c).CurrentImage) Then
		          DBKit.ImageViewer(c).Enabled=True
		          Return True
		        End If
		        
		      Case IsA DBKit.Label
		        If ColumnValueChanged(Column, DBKit.Label(c).Text) Then
		          Return True
		        End If
		        
		      Case IsA DBKit.PopupMenu
		        If ColumnValueChanged(Column, DBKit.PopupMenu(c).SelectedRowValue) Then
		          Return True
		        End If
		        
		      Case IsA DBKit.RadioGroup
		        Select Case CurrentRow.Column(Column).Type
		        Case 2, 3, 19 'Integers
		          If ColumnValueChanged(Column, DBKit.RadioGroup(c).SelectedIndex) Then
		            Return True
		          End If
		        Case 4, 18 'Char,String
		          If ColumnValueChanged(Column, DBKit.RadioGroup(c).SelectedItem.Caption) Then
		            Return True
		          End If
		        End Select
		        
		      Case IsA DBKit.Slider
		        If ColumnValueChanged(Column, DBKit.Slider(c).Value) Then
		          Return True
		        End If
		        
		      Case IsA DBKit.TextArea
		        If ColumnValueChanged(Column, DBKit.TextArea(c).Text) Then
		          Return True
		        End If
		        
		      Case IsA DBKit.TextField
		        If ColumnValueChanged(Column, DBKit.TextField(c).Text) Then
		          Return True
		        End If
		      End Select
		      
		    #ElseIf TargetiOS Then
		      
		      Var c As MobileUIControl = cntrl.Value("control")
		      c.Enabled = True
		      
		      Select Case c
		        
		      Case IsA MobileDateTimePicker
		        Var pickerValue As Variant
		        Select Case MobileDateTimePicker(c).DisplayMode
		        Case MobileDateTimePicker.DisplayModes.DateAndTime
		          pickerValue = MobileDateTimePicker(c).SelectedDate.SQLDateTime
		        Case MobileDateTimePicker.DisplayModes.DateOnly
		          pickerValue = MobileDateTimePicker(c).SelectedDate.SQLDate
		        End Select
		        If ColumnValueChanged(Column, pickerValue) Then
		          Return True
		        End If
		        
		      Case IsA MobileImageViewer
		        If ColumnValueChanged(Column, DKImageViewer(c).CurrentImage) Then
		          Return True
		        End If
		        
		      Case IsA MobileLabel
		        If ColumnValueChanged(Column, MobileLabel(c).Text) Then
		          Return True
		        End If
		        
		      Case IsA MobileSwitch
		        Var swValue As Integer
		        If MobileSwitch(c).Value Then
		          swValue = 1
		        End If
		        If ColumnValueChanged(Column, swValue) Then
		          Return True
		        End If
		        
		      Case IsA MobileSlider
		        If ColumnValueChanged(Column, MobileSlider(c).Value) Then
		          Return True
		        End If
		        
		      Case IsA MobileTextArea
		        If ColumnValueChanged(Column, MobileTextArea(c).Text) Then
		          Return True
		        End If
		        
		      Case IsA MobileTextField
		        If ColumnValueChanged(Column, MobileTextField(c).Text) Then
		          Return True
		        End If
		        
		      End Select
		      
		    #ElseIf TargetWeb Then
		      
		      Var c As WebUIControl = cntrl.Value("control")
		      c.Enabled = True
		      
		      Select Case c
		      Case IsA Web.DBCheckBox
		        Var cbValue As Integer
		        If Web.DBCheckBox(c).Value Then
		          cbValue = 1
		        End If
		        If ColumnValueChanged(Column, cbValue) Then
		          Return True
		        End If
		        
		      Case IsA Web.DBComboBox
		        If ColumnValueChanged(Column, Web.DBComboBox(c).Text) Then
		          Return True
		        End If
		        
		      Case IsA Web.DBDatePicker
		        If ColumnValueChanged(Column, Web.DBDatePicker(c).SelectedDate.SQLDate) Then
		          Return True
		        End If
		        
		      Case IsA Web.DBImageViewer
		        If ColumnValueChanged(Column, Web.DBImageViewer(c).CurrentImage) Then
		          Return True
		        End If
		        
		      Case IsA Web.DBLabel
		        If ColumnValueChanged(Column, Web.DBLabel(c).Text) Then
		          Return True
		        End If
		        
		      Case IsA Web.DBPopupMenu
		        If ColumnValueChanged(Column, Web.DBPopupMenu(c).SelectedRowValue) Then
		          Return True
		        End If
		        
		      Case IsA Web.DBRadioGroup
		        Select Case CurrentRow.Column(Column).Type
		        Case 2, 3, 19 'Integers
		          If ColumnValueChanged(Column, Web.DBRadioGroup(c).SelectedIndex) Then
		            Return True
		          End If
		        Case 4, 18 'Char,String
		          If ColumnValueChanged(Column, Web.DBRadioGroup(c).SelectedItem.Caption) Then
		            Return True
		          End If
		        End Select
		        
		      Case IsA Web.DBSlider
		        If ColumnValueChanged(Column, Web.DBSlider(c).Value) Then
		          Return True
		        End If
		        
		      Case IsA Web.DBTextArea
		        If ColumnValueChanged(Column, Web.DBTextArea(c).Text) Then
		          Return True
		        End If
		        
		      Case IsA Web.DBTextField
		        If ColumnValueChanged(Column, Web.DBTextField(c).Text) Then
		          Return True
		        End If
		      End Select
		      
		    #EndIf
		    
		  Next
		  
		  RaiseEvent ControlsStateChanged(True)
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  Closing
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EditRow()
		  'The user wishes to edit the current row or save the row they are editing
		  
		  AllowCheckForRowChange = False
		  
		  If EditingRow Then
		    
		    SaveRow
		    
		    SetEditButtonIcon(EditIconImage)
		    
		  Else
		    
		    EditingRow = True
		    
		    'Attempt to lock the row
		    
		    Try
		      
		      CurrentRow.EditRow
		      connection.BeginTransaction
		      
		      'Set the entry controls to readwrite/enabled controls
		      
		      For Each cntrl As Dictionary In BoundControls
		        
		        #If TargetDesktop Then
		          Var c As DesktopUIControl = cntrl.Value("control")
		          
		        #ElseIf TargetiOS Then
		          Var c As MobileUIControl = cntrl.Value("control")
		          
		        #ElseIf TargetWeb Then
		          Var c As WebUIControl = cntrl.Value("control")
		        #EndIf
		        
		        SetEntryControlState(c, True)
		        
		      Next
		      
		      SetEditButtonCaption(EditButtonDoneCaption)
		      SetEditButtonIcon(DoneIconImage)
		      
		      'set the focus to the first control in the tab order
		      SetFocusToFirstControl
		      
		    Catch error As DatabaseException
		      MessageBox(ErrorRowCannotBeEdited)
		    End Try
		    
		  End If
		  
		  RaiseEvent ControlsStateChanged(True)
		  
		  AllowCheckForRowChange = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ExistingDBConnection() As Database
		  'Looks for a property in the app class of type DBKit.Connector
		  'If it finds it and it's not nil, it assumes this is the database connection
		  'The user can always override this in the Opening event of an instance of 
		  'DBKit.Connector
		  
		  Var target As Object
		  #If TargetDesktop Then
		    target = app
		  #ElseIf TargetWeb Then
		    target = Session
		  #EndIf
		  
		  Var MyTypeInfo As Introspection.TypeInfo = GetTypeInfo(DBKit.Connector)
		  Var myProperties() As Introspection.PropertyInfo = Introspection.GetType(target).GetProperties
		  For Each prop As Introspection.PropertyInfo In myProperties
		    If prop.PropertyType.IsSubclassOf(MyTypeInfo) Then
		      If prop.Value(target) <> Nil Then
		        Var connector As DBKit.Connector = prop.Value(target)
		        Return Connector.Connection
		      End If
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FireOpeningEvent()
		  'Fire the DBKit.Connector opening event
		  #If TargetWeb Then
		    Var Session As WebSessionContext
		    If SessionID <> "" Then
		      session = New WebSessionContext(SessionID)
		    End If
		  #EndIf
		  
		  RaiseEvent Opening
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = API2Only and ( (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Private Sub LoadRow()
		  AllowCheckForRowChange = False
		  
		  'Load the columns into the bound controls
		  For Each cntrl As Dictionary In BoundControls
		    
		    #If TargetDesktop Then
		      Var c As DesktopUIControl = cntrl.Value("control")
		      
		    #ElseIf TargetiOS Then
		      Var c As MobileUIControl = cntrl.Value("control")
		      
		    #ElseIf TargetWeb Then
		      Var c As WebUIControl = cntrl.Value("control")
		    #EndIf
		    
		    SetEntryControlState(c, False)
		    
		    Var Column As String = cntrl.Value("Column")
		    
		    SetControlValue(c, Column, CurrentRow)
		  Next
		  
		  SetEditButtonCaption(EditButtonEditCaption)
		  
		  RaiseEvent ControlsStateChanged(False)
		  
		  AllowCheckForRowChange = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit))
		Sub LoadSelectedRow()
		  If AllowCheckForRowChange And  CurrentRowChanged  Then //
		    
		    'See if the user clicked on a row different from the one that is for the
		    'row being displayed for editing
		    #If TargetDesktop Then
		      Var sri As Integer = DesktopListBox(BoundListBoxControl).SelectedRowIndex
		    #ElseIf TargetWeb Then
		      Var sri As Integer = WebListBox(BoundListBoxControl).SelectedRowIndex
		    #EndIf
		    Var cri As Integer = RowWithPrimaryKey
		    
		    'The user has unsaved changes. Ask them if they wish to continue.
		    If sri <> cri Then
		      ConfirmUnsavedChanges(AddressOf LoadSelectedRowContinue, AddressOf LoadSelectedRowCancel)
		    End If
		    
		  Else
		    LoadSelectedRowContinue
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadSelectedRowCancel()
		  'Set the selected row back to the row already displayed
		  #If TargetDesktop Then
		    DesktopListBox(BoundListBoxControl).SelectedRowIndex = RowWithPrimaryKey
		  #ElseIf TargetWeb Then
		    WebListBox(BoundListBoxControl).SelectedRowIndex = RowWithPrimaryKey
		  #EndIf
		  NewRow = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadSelectedRowContinue()
		  #If TargetDesktop Then
		    Var control As DesktopListBox = BoundListBoxControl
		  #ElseIf TargetiOS Then
		    Var control As iOSMobileTable = BoundListBoxControl
		  #ElseIf TargetWeb Then
		    Var control As WebListBox = BoundListBoxControl
		  #EndIf
		  
		  If control.SelectedRowCount = 1 Then
		    
		    Try
		      
		      'The user had made changes and decided to lose them to switch records so
		      'rollback the transaction
		      If EditingRow Then
		        EditingRow = False
		        connection.RollbackTransaction
		      End If
		      
		      PrimaryKeyValue = control.RowTagAt(control.SelectedRowIndex)
		      CurrentRow = Connection.SelectSQL("SELECT * FROM " + Table + " WHERE " + PrimaryKeyColumn + " = " + PrimaryKeyValue)
		      
		      'Raise the LoadingRow event to give the developer the opportunity to determine if
		      'the row should load or not
		      Var loadingRow As Boolean = True
		      If IsEventImplemented("LoadingRow") Then
		        loadingRow = RaiseEvent LoadingRow(CurrentRow)
		      End If
		      If loadingRow Then
		        NewRow = Nil
		        
		        LoadRow
		        
		        SetButtonEnabledState(DeleteButton, True)
		        SetButtonEnabledState(EditButton, True)
		        
		      End If
		      
		    Catch error As DatabaseException
		      MessageBox(error.Message)
		    End Try
		    
		  Else
		    NoRowSelected
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit))
		Sub NewRow()
		  If AllowCheckForRowChange And CurrentRowChanged Then
		    ConfirmUnsavedChanges(AddressOf NewRowContinue)
		  Else
		    NewRowContinue
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub NewRowContinue()
		  'Prepare controls so the user can enter values for a new row
		  
		  AllowCheckForRowChange = False
		  
		  EditingRow = True
		  
		  NewRow = New DatabaseRow
		  
		  'Clear the columns into the bound controls
		  For Each cntrl As Dictionary In BoundControls
		    
		    #If TargetDesktop Then
		      Var c As DesktopUIControl = cntrl.Value("control")
		      
		    #ElseIf TargetiOS Then
		      Var c As MobileUIControl = cntrl.Value("control")
		      
		    #ElseIf TargetWeb Then
		      Var c As WebUIControl = cntrl.Value("control")
		    #EndIf
		    
		    c.Enabled = True
		    
		    SetEntryControlState(c, True)
		    SetControlValue(c)
		  Next
		  
		  SetFocusToFirstControl
		  
		  SetButtonEnabledState(EditButton, True)
		  SetEditButtonCaption(EditButtonDoneCaption)
		  
		  RaiseEvent ControlsStateChanged(True)
		  
		  AllowCheckForRowChange = True
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Sub NoParameters()
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h21, CompatibilityFlags = API2Only and ( (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Private Sub NoRowSelected()
		  //#My Change: Removed method paramenter TableName As String="" as TableName is unused in method
		  'Clear the values of bound controls and disable them
		  
		  AllowCheckForRowChange = False
		  
		  For Each cntrl As Dictionary In BoundControls
		    
		    #If TargetDesktop Then
		      Var c As DesktopUIControl = cntrl.Value("control")
		    #ElseIf TargetiOS Then
		      Var c As MobileUIControl = cntrl.Value("control")
		    #ElseIf TargetWeb Then
		      Var c As WebUIControl = cntrl.Value("control")
		    #EndIf
		    
		    c.Enabled = False
		    
		    SetControlValue(c)
		  Next
		  
		  RaiseEvent ControlsStateChanged(False)
		  
		  CurrentRow = Nil
		  
		  'Now disable the Save, Undo and Delete buttons if any
		  SetButtonEnabledState(EditButton, False)
		  SetButtonEnabledState(UndoButton, False)
		  SetButtonEnabledState(DeleteButton, False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PrimaryKeyColumn() As String
		  If Table = "" Then
		    Var e As New DatabaseException
		    e.Message = "The primary key cannot be found without a Table."
		    Raise e
		  Else
		    Try
		      Var rs As RowSet
		      rs = Connection.TableColumns(Table)
		      For Each column As DatabaseRow In rs
		        If rs.Column("IsPrimary").BooleanValue Then
		          Return rs.Column("ColumnName").StringValue
		        End If
		      Next
		      
		      Var e As New DatabaseException
		      e.Message = "The " + Table + " table has no primary key column."
		      Raise e
		      
		    Catch error As DatabaseException
		      MessageBox("Error: The primary key for " + Table + " could not be determined.")
		    End Try
		    
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit))
		Sub RemoveSelectedRow()
		  If NewRow = Nil Then
		    
		    #If TargetDesktop Then
		      Var control As DesktopListBox = BoundListBoxControl
		    #ElseIf TargetiOS Then
		      Var control As iOSMobileTable = BoundListBoxControl
		    #ElseIf TargetWeb Then
		      Var control As WebListBox = BoundListBoxControl
		    #EndIf 
		    
		    Try
		      connection.ExecuteSQL("DELETE FROM " + Table + " WHERE " + PrimaryKeyColumn + " = " + PrimaryKeyValue)
		      
		      'Remove the row from the bound list control
		      control.RemoveRowAt(RowWithPrimaryKey)
		      
		      NoRowSelected
		    Catch error As DatabaseException
		      MessageBox(ErrorRowCouldNotBeRemovedTable + Table)
		    End Try
		    
		  Else 'The user pressed Delete while making a new record
		    NoRowSelected
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RowWithPrimaryKey() As Integer
		  'Return the number of the row whose RowTag has the primary key for the current row
		  #If TargetDesktop Then
		    Var lc As DesktopListBox = DesktopListBox(BoundListBoxControl)
		  #ElseIf TargetiOS Then
		    Var lc As iOSMobileTable = iOSMobileTable(BoundListBoxControl)
		  #ElseIf TargetWeb Then
		    Var lc As WebListBox = WebListBox(BoundListBoxControl)
		  #EndIf
		  For i As Integer = 0 To lc.LastRowIndex
		    If lc.RowTagAt(i) = PrimaryKeyValue Then
		      Return i
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = API2Only and ( (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Private Sub SaveRow()
		  Var row As Variant
		  
		  If NewRow <> Nil Then
		    row = NewRow
		  Else
		    row = CurrentRow
		  End If
		  
		  For Each cntrl As Dictionary In BoundControls
		    
		    #If TargetDesktop Then
		      Var c As DesktopUIControl = cntrl.Value("control")
		    #ElseIf TargetiOS Then
		      Var c As MobileUIControl = cntrl.Value("control")
		    #ElseIf TargetWeb Then
		      Var c As WebUIControl = cntrl.Value("control")
		    #EndIf
		    
		    c.Enabled = False
		    
		    'set the bound column in the row to the value from the control
		    Var Column As String = cntrl.Value("Column")
		    
		    #If TargetDesktop Then
		      
		      Select Case c
		      Case IsA DBKit.CheckBox
		        If DBKit.CheckBox(c).Value Then
		          SetColumnValue(row, Column, 1)
		        Else
		          SetColumnValue(row, Column, 0)
		        End If
		        
		      Case IsA DBKit.ComboBox
		        SetColumnValue(row, Column, DBKit.ComboBox(c).Text)
		        
		      Case IsA DBKit.DateTimePicker
		        Var pickerValue As DateTime = DBKit.DateTimePicker(c).SelectedDate
		        Select Case DBKit.DateTimePicker(c).DisplayMode
		        Case DBKit.DateTimePicker.DisplayModes.DateAndTime
		          SetColumnValue(row, Column, pickerValue.SQLDateTime)
		        Case DBKit.DateTimePicker.DisplayModes.DateOnly
		          SetColumnValue(row, Column, pickerValue.SQLDate)
		        End Select
		        
		      Case IsA DBKit.ImageViewer
		        SetColumnValue(row, Column, DBKit.ImageViewer(c).CurrentImage)
		        
		      Case IsA DBKit.Label
		        SetColumnValue(row, Column, DBKit.Label(c).Text)
		        
		      Case IsA DBKit.PopupMenu
		        SetColumnValue(row, Column, DBKit.PopupMenu(c).SelectedRowValue)
		        
		      Case IsA DBKit.RadioGroup
		        Select Case DatabaseRow(row).Column(Column).Type
		        Case 2, 3, 19 'Integers
		          SetColumnValue(row, Column, DBKit.RadioGroup(c).SelectedIndex)
		        Case 4, 18 'Char,String
		          SetColumnValue(row, Column, DBKit.RadioGroup(c).SelectedItem.Caption)
		        End Select
		        
		      Case IsA DBKit.Slider
		        SetColumnValue(row, Column, DBKit.Slider(c).Value)
		        
		      Case IsA DBKit.TextArea
		        SetColumnValue(row, Column, DBKit.TextArea(c).Text)
		        DBKit.TextArea(c).ReadOnly = True
		        DBKit.TextArea(c).Enabled = True
		        
		      Case IsA DBKit.TextField
		        SetColumnValue(row, Column, DBKit.TextField(c).Text)
		        DBKit.TextField(c).ReadOnly = True
		        DBKit.TextField(c).Enabled = True
		      End Select
		      
		    #ElseIf TargetiOS Then
		      
		      Select Case c
		        
		      Case IsA MobileDateTimePicker
		        Var pickerValue As DateTime = MobileDateTimePicker(c).SelectedDate
		        Select Case MobileDateTimePicker(c).DisplayMode
		        Case MobileDateTimePicker.DisplayModes.DateAndTime
		          SetColumnValue(row, Column, pickerValue.SQLDateTime)
		        Case MobileDateTimePicker.DisplayModes.DateOnly
		          SetColumnValue(row, Column, pickerValue.SQLDate)
		        End Select
		        
		      Case IsA MobileImageViewer
		        SetColumnValue(row, Column, DKImageViewer(c).CurrentImage)
		        
		      Case IsA MobileLabel
		        SetColumnValue(row, Column, MobileLabel(c).Text)
		        
		      Case IsA MobileSlider
		        SetColumnValue(row, Column, MobileSlider(c).Value)
		        
		      Case IsA MobileSwitch
		        If MobileSwitch(c).Value Then
		          SetColumnValue(row, Column, 1)
		        Else
		          SetColumnValue(row, Column, 0)
		        End If
		        
		      Case IsA MobileTextArea
		        SetColumnValue(row, Column, MobileTextArea(c).Text)
		        MobileTextArea(c).ReadOnly = True
		        MobileTextArea(c).Enabled = True
		        
		      Case IsA MobileTextField
		        SetColumnValue(row, Column, MobileTextField(c).Text)
		        MobileTextField(c).ReadOnly = True
		        MobileTextField(c).Enabled = True
		      End Select
		      
		    #ElseIf TargetWeb Then
		      
		      Select Case c
		      Case IsA Web.DBCheckBox
		        If Web.DBCheckBox(c).Value Then
		          SetColumnValue(row, Column, 1)
		        Else
		          SetColumnValue(row, Column, 0)
		        End If
		        
		      Case IsA Web.DBComboBox
		        SetColumnValue(row, Column, Web.DBComboBox(c).Text)
		        
		      Case IsA Web.DBDatePicker
		        SetColumnValue(row, Column, Web.DBDatePicker(c).SelectedDate.SQLDate)
		        
		      Case IsA Web.DBImageViewer
		        SetColumnValue(row, Column, Web.DBImageViewer(c).CurrentImage)
		        
		      Case IsA Web.DBLabel
		        SetColumnValue(row, Column, Web.DBLabel(c).Text)
		        
		      Case IsA Web.DBPopupMenu
		        SetColumnValue(row, Column, Web.DBPopupMenu(c).SelectedRowValue)
		        
		      Case IsA Web.DBRadioGroup
		        Select Case DatabaseRow(row).Column(Column).Type
		        Case 2, 3, 19 'Integers
		          SetColumnValue(row, Column, Web.DBRadioGroup(c).SelectedIndex)
		        Case 4, 18 'Char,String
		          SetColumnValue(row, Column, Web.DBRadioGroup(c).SelectedItem.Caption)
		        End Select
		        
		      Case IsA Web.DBTextArea
		        SetColumnValue(row, Column, Web.DBTextArea(c).Text)
		        Web.DBTextArea(c).ReadOnly = True
		        Web.DBTextArea(c).Enabled = True
		        
		      Case IsA Web.DBTextField
		        SetColumnValue(row, Column, Web.DBTextField(c).Text)
		        Web.DBTextField(c).ReadOnly = True
		        Web.DBTextField(c).Enabled = True
		      End Select
		      
		    #EndIf
		    
		  Next
		  
		  'Raise the SavingRow event to give the user a chance to execute code and/or modify the row
		  'then decide if they still want to save or not.
		  Var savingRow As Boolean = True
		  If IsEventImplemented("SavingRow") Then
		    savingRow = RaiseEvent SavingRow(CurrentRow)
		  End If
		  If savingRow Then
		    
		    'Update the existing row or add a new one
		    If row IsA DatabaseRow Then
		      Connection.BeginTransaction
		      Connection.AddRow(Table, DatabaseRow(row))
		      Connection.CommitTransaction
		      'Get the rowid for this newly added row so we can load the row
		      Var rowID As Integer
		      Select Case Connection
		        
		      Case IsA PostgreSQLDatabase
		        Var rs As RowSet = PostgreSQLDatabase(Connection).SelectSQL("SELECT lastval()")
		        rowID = rs.ColumnAt(0).Value
		        
		      Case IsA MySQLCommunityServer
		        rowID = MySQLCommunityServer(Connection).LastInsertedRowID
		        
		      Case IsA SQLiteDatabase
		        rowID = SQLiteDatabase(Connection).LastRowID
		        
		      End Select
		      'Now load the new row into CurrentRow so the user can continue to modify it.
		      'This is so that should the user click on a row in a listbox that is bound to the DBKit.Connector
		      'it won't complain that the row has been changed.
		      CurrentRow = Connection.SelectSQL("SELECT * FROM " + Table + " WHERE rowid = " + rowID.ToString)
		      row = Nil
		      NewRow = Nil
		    ElseIf row IsA RowSet Then
		      RowSet(row).SaveRow
		      Connection.CommitTransaction
		    End If
		    
		    If row IsA RowSet Then
		      'Now update the bound list control
		      #If TargetDesktop Then
		        Var lc As DBKit.SearchResultsListBox = BoundListBoxControl
		      #ElseIf TargetWeb Then
		        Var lc As DBKit.Web.DBSearchResultsListBox = BoundListBoxControl
		      #EndIf
		      Var selectedRow As Integer = RowWithPrimaryKey
		      For i As Integer = 0 To lc.ColumnCount - 1
		        lc.CellTextAt(selectedRow, i) = lc.ColumnValue(lc.ColumnTagAt(i), RowSet(row))
		      Next
		      
		      RowSet(row).Close 'unlock the row
		      'Now reload the row in case the user wants to edit it again
		      CurrentRow = Connection.SelectSQL("SELECT * FROM " + Table + " WHERE " + PrimaryKeyColumn + " = " + PrimaryKeyValue)
		    End If
		    
		    'Set the EditSave Button back to Edit
		    SetEditButtonCaption(EditButtonEditCaption)
		    SetEditButtonIcon(editicon)
		    'Disable the Undo Button
		    SetButtonEnabledState(UndoButton, False)
		  End If
		  
		  EditingRow = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ScaleImageTo(p As Picture, width As Integer, height As Integer) As Picture
		  'Scale the image to the size passed while maintaining the aspect ratio
		  'I generated this function by describing it to ChatGPT4.
		  
		  Var ratio As Double
		  Var newW, newH As Integer
		  
		  // Calculate aspect ratios
		  Var wRatio As Double = width / p.Width
		  Var hRatio As Double = height / p.Height
		  
		  // Maintain aspect ratio
		  If wRatio < hRatio Then
		    ratio = wRatio
		  Else
		    ratio = hRatio
		  End If
		  
		  // Calculate new dimensions
		  newW = p.Width * ratio
		  newH = p.Height * ratio
		  
		  // Create new picture
		  Var newPic As New Picture(newW, newH)
		  
		  // Draw scaled picture
		  newPic.Graphics.DrawPicture(p, 0, 0, newW, newH, 0, 0, p.Width, p.Height)
		  
		  Return newPic
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = API2Only and ( (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit)) )
		Private Sub SetButtonEnabledState(button As Variant, state As Boolean)
		  If button <> Nil Then
		    #If TargetDesktop Then
		      If button IsA DesktopUIControl Then
		        DesktopUIControl(button).Enabled = state
		      ElseIf button IsA DesktopToolbarButton Then
		        DesktopToolbarButton(button).Enabled = state
		      End If
		      
		    #ElseIf TargetiOS Then
		      If button IsA MobileUIControl Then
		        MobileUIControl(button).Enabled = state
		      ElseIf button IsA MobileToolbarButton Then
		        MobileToolbarButton(button).Enabled = state
		      End If
		      
		    #ElseIf TargetWeb Then
		      If button IsA WebUIControl Then
		        WebUIControl(button).Enabled = state
		      ElseIf button IsA WebToolbarButton Then
		        WebToolbarButton(button).Enabled = state
		      End If
		    #EndIf
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetColumnValue(row As Variant, column As String, Value As Variant)
		  Try
		    If row IsA DatabaseRow Then
		      If value IsA Picture Then
		        DatabaseRow(row).Column(Column).PictureValue(Picture.Formats.JPEG) = Picture(value)
		      Else
		        DatabaseRow(row).Column(Column).Value = value
		      End If
		    Else
		      If value IsA Picture Then
		        RowSet(row).Column(Column).PictureValue(Picture.Formats.JPEG) = Picture(value)
		      Else
		        RowSet(row).Column(Column).Value = value
		      End If
		    End If
		    
		  Catch error As DatabaseException
		    MessageBox(ErrorColumnCouldNotBeSet + Column)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = API2Only and ( (TargetDesktop and (Target32Bit or Target64Bit)) )
		Private Sub SetControlValue(c As DesktopUIControl, column As String = "", row As RowSet = Nil)
		  Try
		    
		    Select Case c
		    Case IsA DBKit.CheckBox
		      If row = Nil Then
		        DBKit.CheckBox(c).Value = False
		      Else
		        DBKit.CheckBox(c).Value = (row.Column(Column).IntegerValue = 1)
		      End If
		      
		    Case IsA DBKit.ComboBox
		      If row = Nil Then
		        DBKit.ComboBox(c).Text = ""
		      Else
		        DBKit.ComboBox(c).Text = row.Column(Column).StringValue
		      End If
		      
		    Case IsA DBKit.DateTimePicker
		      If row = Nil Then
		        DBKit.DateTimePicker(c).SelectedDate = DateTime.Now
		      Else
		        DBKit.DateTimePicker(c).SelectedDate = row.Column(Column).DateTimeValue
		      End If
		      
		    Case IsA DBKit.ImageViewer
		      If row = Nil Then
		        DBKit.ImageViewer(c).Image = Nil
		        DBKit.ImageViewer(c).CurrentImage = Nil
		      Else
		        var ImageType As Integer = row.Column(column).Type
		        Var p As picture
		        dim f As FolderItem
		        
		        //#my change starts
		        //If image is stored in db as path to image as string
		        
		        If ImageType=5 or ImageType=18 then 
		          var ImagePath As String=row.Column(column).StringValue //Get path as string
		          f = New FolderItem(ImagePath) //Get folderItem of image
		          If f<>nil then
		            p=picture.Open(f)
		            DBKit.ImageViewer(c).CurrentImageFile=f
		          End If
		          
		        Else //Image is probably stored as a BLOB
		          p=row.Column(Column).PictureValue 
		        End If
		        //#my change ends
		        
		        If p = Nil Then
		          DBKit.ImageViewer(c).Image = Nil
		          DBKit.ImageViewer(c).CurrentImage = Nil
		        Else
		          'Store the picture in the CurrentImage property as the Image property will be scaled
		          DBKit.ImageViewer(c).CurrentImage = p
		          'Use the ImageMargin constant so the image doesn't hit the border of the imageviewer
		          DesktopImageViewer(c).Image = ScaleImageTo(p, DBKit.ImageViewer(c).Width * ImageMargin, DBKit.ImageViewer(c).Height * ImageMargin)
		        End If
		      End If
		      
		    Case IsA DBKit.Label
		      If row = Nil Then
		        DBKit.Label(c).Text = ""
		      Else
		        DBKit.Label(c).Text = row.Column(Column).StringValue
		      End If
		      
		    Case IsA DBKit.PopupMenu
		      If row = Nil Then
		        DBKit.PopupMenu(c).SelectedRowIndex = -1
		      Else
		        Var value As String = CurrentRow.Column(Column).StringValue
		        If value = "" Then
		          DBKit.PopupMenu(c).SelectedRowIndex = -1
		        Else
		          DBKit.PopupMenu(c).SelectRowWithValue(value)
		        End If
		      End If
		      
		    Case IsA DBKit.RadioGroup
		      Select Case CurrentRow.Column(Column).Type
		      Case 2, 3, 19 'Integers
		        If row = Nil Then
		          DBKit.RadioGroup(c).SelectedIndex = -1
		        Else
		          DBKit.RadioGroup(c).SelectedIndex = CurrentRow.Column(Column).IntegerValue
		        End If
		      Case 4, 18 'Char,String
		        If row = Nil Then
		          DBKit.RadioGroup(c).SelectedIndex = -1
		        Else
		          Var index As Integer = DBKit.RadioGroup(c).IndexOf(CurrentRow.Column(Column).StringValue)
		          DBKit.RadioGroup(c).SelectedIndex = index
		        End If
		      End Select
		      
		    Case IsA DBKit.Slider
		      If row = Nil Then
		        DBKit.Slider(c).Value = DBKit.Slider(c).MinimumValue
		      Else
		        DBKit.Slider(c).Value = CurrentRow.Column(Column).IntegerValue
		      End If
		      
		    Case IsA DBKit.TextArea
		      If row = Nil Then
		        DBKit.TextArea(c).Text = ""
		      Else
		        DBKit.TextArea(c).Text = CurrentRow.Column(Column).StringValue
		      End If
		      
		    Case IsA DBKit.TextField
		      If row = Nil Then
		        DBKit.TextField(c).Text = ""
		      Else
		        DBKit.TextField(c).Text = CurrentRow.Column(Column).StringValue
		      End If
		    End Select
		    
		  Catch error As DatabaseException
		    MessageBox("Error: The value of the control " + c.Name + " could not be set. Message: " + error.Message)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) )
		Private Sub SetControlValue(c As WebUIControl, column As String = "", row As RowSet = Nil)
		  Try
		    
		    Select Case c
		    Case IsA Web.DBCheckBox
		      If row = Nil Then
		        Web.DBCheckBox(c).Value = False
		      Else
		        Web.DBCheckBox(c).Value = (row.Column(Column).IntegerValue = 1)
		      End If
		      
		    Case IsA Web.DBComboBox
		      If row = Nil Then
		        Web.DBComboBox(c).Text = ""
		      Else
		        Web.DBComboBox(c).Text = row.Column(Column).StringValue
		      End If
		      
		    Case IsA Web.DBDatePicker
		      If row = Nil Then
		        Web.DBDatePicker(c).SelectedDate = DateTime.Now
		      Else
		        Web.DBDatePicker(c).SelectedDate = row.Column(Column).DateTimeValue
		      End If
		      
		    Case IsA Web.DBImageViewer
		      If row = Nil Then
		        Web.DBImageViewer(c).Image = Nil
		        Web.DBImageViewer(c).CurrentImage = Nil
		      Else
		        Var p As picture = row.Column(Column).PictureValue
		        If p = Nil Then
		          Web.DBImageViewer(c).Image = Nil
		          Web.DBImageViewer(c).CurrentImage = Nil
		        Else
		          'Store the picture in the CurrentImage property as the Image property will be scaled
		          Web.DBImageViewer(c).CurrentImage = p
		          'Subtract 10% so the image doesn't hit the border of the imageviewer
		          Web.DBImageViewer(c).Image = ScaleImageTo(p, Web.DBImageViewer(c).Width * ImageMargin, Web.DBImageViewer(c).Height * ImageMargin)
		        End If
		      End If
		      
		    Case IsA Web.DBLabel
		      If row = Nil Then
		        Web.DBLabel(c).Text = ""
		      Else
		        Web.DBLabel(c).Text = row.Column(Column).StringValue
		      End If
		      
		    Case IsA Web.DBPopupMenu
		      If row = Nil Then
		        Web.DBPopupMenu(c).SelectedRowIndex = -1
		      Else
		        Var value As String = CurrentRow.Column(Column).StringValue
		        If value = "" Then
		          Web.DBPopupMenu(c).SelectedRowIndex = -1
		        Else
		          Web.DBPopupMenu(c).SelectRowWithValue(value)
		        End If
		      End If
		      
		    Case IsA Web.DBRadioGroup
		      Select Case CurrentRow.Column(Column).Type
		      Case 2, 3, 19 'Integers
		        If row = Nil Then
		          Web.DBRadioGroup(c).SelectedIndex = -1
		        Else
		          Web.DBRadioGroup(c).SelectedIndex = CurrentRow.Column(Column).IntegerValue
		        End If
		      Case 4, 18 'Char,String
		        If row = Nil Then
		          Web.DBRadioGroup(c).SelectedIndex = -1
		        Else
		          Var index As Integer = Web.DBRadioGroup(c).IndexOf(CurrentRow.Column(Column).StringValue)
		          Web.DBRadioGroup(c).SelectedIndex = index
		        End If
		      End Select
		      
		    Case IsA Web.DBSlider
		      If row = Nil Then
		        Web.DBSlider(c).Value = Web.DBSlider(c).MinimumValue
		      Else
		        Web.DBSlider(c).Value = CurrentRow.Column(Column).IntegerValue
		      End If
		      
		    Case IsA Web.DBTextArea
		      If row = Nil Then
		        Web.DBTextArea(c).Text = ""
		      Else
		        Web.DBTextArea(c).Text = CurrentRow.Column(Column).StringValue
		      End If
		      
		    Case IsA Web.DBTextField
		      If row = Nil Then
		        Web.DBTextField(c).Text = ""
		      Else
		        Web.DBTextField(c).Text = CurrentRow.Column(Column).StringValue
		      End If
		    End Select
		    
		  Catch error As DatabaseException
		    MessageBox("Error: The value of the control " + c.Name + " could not be set. Message: " + error.Message)
		  End Try
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetEditButtonCaption(theCaption As String)
		  #If TargetDesktop Then
		    If EditButton IsA DesktopButton Then
		      DesktopButton(EditButton).Caption = theCaption
		    ElseIf EditButton IsA DesktopToolbarButton Then
		      DesktopToolbarButton(EditButton).Caption = theCaption
		    End If
		    
		  #ElseIf TargetIOS Then
		    If EditButton IsA MobileButton Then
		      MobileButton(EditButton).Caption = theCaption
		    ElseIf EditButton IsA MobileToolbarButton Then
		      MobileToolbarButton(EditButton).Caption = theCaption
		    End If
		    
		  #ElseIf TargetWeb Then
		    If EditButton IsA WebButton Then
		      WebButton(EditButton).Caption = theCaption
		    ElseIf EditButton IsA WebToolbarButton Then
		      WebToolbarButton(EditButton).Caption = theCaption
		    End If
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetEditButtonIcon(theIcon As Picture)
		  If theIcon <> Nil Then
		    #If TargetDesktop Then
		      If EditButton IsA DesktopToolbarButton Then
		        DesktopToolbarButton(EditButton).Icon = theIcon
		      End If
		      
		    #ElseIf TargetIOS Then
		      If EditButton IsA MobileToolbarButton Then
		        MobileToolbarButton(EditButton).Icon = theIcon
		      End If
		      
		    #ElseIf TargetWeb Then
		      If EditButton IsA WebToolbarButton Then
		        WebToolbarButton(EditButton).Icon = theIcon
		      End If
		    #EndIf
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = API2Only and ( (TargetDesktop and (Target32Bit or Target64Bit)) )
		Private Sub SetEntryControlState(theControl As DesktopUIControl, theState As Boolean)
		  'Set to true to make the data entry controls editable by the user and false to make them not.
		  If theControl IsA DesktopTextField Or theControl IsA DesktopTextArea Then
		    DesktopTextControl(theControl).ReadOnly = Not theState
		    theControl.Enabled = True
		  Else
		    theControl.Enabled = theState
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = API2Only and ( (TargetIOS and (Target64Bit)) )
		Private Sub SetEntryControlState(theControl as MobileUIControl, theState as Boolean)
		  'Set to true to make the data entry controls editable by the user and false to make them not.
		  If theControl IsA MobileTextField Or theControl IsA MobileTextArea Then
		    MobileTextControl(theControl).ReadOnly = Not theState
		    theControl.Enabled = True
		  Else
		    theControl.Enabled = theState
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = API2Only and ( (TargetWeb and (Target32Bit or Target64Bit)) )
		Private Sub SetEntryControlState(theControl as WebUIControl, theState as Boolean)
		  'Set to true to make the data entry controls editable by the user and false to make them not.
		  If theControl IsA WebTextField Or theControl IsA WebTextArea Then
		    WebTextControl(theControl).ReadOnly = Not theState
		    theControl.Enabled = True
		  Else
		    theControl.Enabled = theState
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetFocusToFirstControl()
		  #If TargetDesktop Then
		    firstDBKitDesktopControlInTabOrder.SetFocus
		  #ElseIf TargetWeb Then
		    firstDBKitWebControlInTabOrder.SetFocus
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UndoRowChanges()
		  'Called from a User's Undo button
		  
		  Try
		    
		    'Requery the row
		    Var key As Variant = CurrentRow.Column(PrimaryKeyColumn).Value
		    Var SQL As String = "SELECT * FROM " + Table + " WHERE " + PrimaryKeyColumn + " = " + key
		    CurrentRow = connection.SelectSQL(sql)
		    
		    'Reload that row into the bound controls
		    LoadRow
		    
		    'set their states
		    EditingRow = False
		    connection.RollbackTransaction
		    SetButtonEnabledState(UndoButton, False)
		    
		  Catch error As DatabaseException
		    MessageBox("Error: The row changes could not be undone. Message: " + error.Message)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) )
		Private Sub WebConfirmDeleteDialogButtonPressed(d As WebMessageDialog, button As WebMessageDialogButton)
		  If button.Caption = DeleteConfirmContinue Then
		    RemoveSelectedRow
		    If pageToClose <> Nil Then
		      pageToClose.close
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = API2Only and ( (TargetWeb and (Target32Bit or Target64Bit)) )
		Private Sub WebConfirmDialogButtonPressed(d As WebMessageDialog, button As WebMessageDialogButton)
		  If button.Caption = ConfirmContinue Then
		    If WebConfirmContinueMethod <> Nil Then
		      WebConfirmContinueMethod.Invoke
		    End If
		  ElseIf button.Caption = ConfirmCancel Then
		    If WebConfirmCancelMethod <> Nil Then
		      WebConfirmCancelMethod.Invoke
		    end if
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Closing()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ControlsStateChanged(controlsEnabled As Boolean)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event LoadingRow(row As RowSet) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SavingRow(row As Variant) As Boolean
	#tag EndHook


	#tag Note, Name = Temp Code
		var ImagePath As String=row.Column(column).StringValue
		var f As New FolderItem(ImagePath)
		var p As picture
		If f<>nil then
		  p=picture.Open(f)
		End If
		
		If p = Nil Then
		  DBKit.ImageViewer(c).Image = Nil
		  DBKit.ImageViewer(c).CurrentImage = Nil
		Else
		  'Store the picture in the CurrentImage property as the Image property will be scaled
		  DBKit.ImageViewer(c).CurrentImage = p
		  'Use the ImageMargin constant so the image doesn't hit the border of the imageviewer
		  DesktopImageViewer(c).Image = ScaleImageTo(p, DBKit.ImageViewer(c).Width * ImageMargin, DBKit.ImageViewer(c).Height * ImageMargin)
		End If
		
		
		
	#tag EndNote


	#tag Property, Flags = &h21
		Private AllowCheckForRowChange As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private BoundControls() As Variant
	#tag EndProperty

	#tag Property, Flags = &h21
		Private BoundListBoxControl As Variant
	#tag EndProperty

	#tag Property, Flags = &h0
		Connection As Database
	#tag EndProperty

	#tag Property, Flags = &h0
		CreateNewRow As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private CurrentRow As RowSet
	#tag EndProperty

	#tag Property, Flags = &h21
		Private DeleteButton As Variant
	#tag EndProperty

	#tag Property, Flags = &h0
		DoneIconImage As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private EditButton As Variant
	#tag EndProperty

	#tag Property, Flags = &h0
		EditIconImage As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private EditingRow As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private firstDBKitDesktopControlInTabOrder As DesktopUIControl
	#tag EndProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (TargetWeb and (Target32Bit or Target64Bit))
		Private firstDBKitWebControlInTabOrder As WebUIControl
	#tag EndProperty

	#tag Property, Flags = &h21
		Private NewButton As Variant
	#tag EndProperty

	#tag Property, Flags = &h21
		Private NewRow As DatabaseRow
	#tag EndProperty

	#tag Property, Flags = &h21, CompatibilityFlags = API2Only and ( (TargetWeb and (Target32Bit or Target64Bit)) )
		Private pageToClose As WebPage
	#tag EndProperty

	#tag Property, Flags = &h21
		Private PrimaryKeyValue As Variant
	#tag EndProperty

	#tag Property, Flags = &h21
		Private SessionID As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Table As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private UndoButton As Variant
	#tag EndProperty

	#tag Property, Flags = &h21
		Private WebConfirmCancelMethod As NoParameters
	#tag EndProperty

	#tag Property, Flags = &h21
		Private WebConfirmContinueMethod As NoParameters
	#tag EndProperty


	#tag Constant, Name = ConfirmCancel, Type = String, Dynamic = True, Default = \"Cancel", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ConfirmContinue, Type = String, Dynamic = True, Default = \"Continue", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ConfirmExplanation, Type = String, Dynamic = True, Default = \"If you continue\x2C your changes will not be saved.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ConfirmMessage, Type = String, Dynamic = True, Default = \"You have unsaved changes.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ConfirmTitle, Type = String, Dynamic = True, Default = \"Unsaved Changes", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DeleteConfirmCancel, Type = String, Dynamic = True, Default = \"Cancel", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DeleteConfirmContinue, Type = String, Dynamic = True, Default = \"Delete", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DeleteConfirmExplanation, Type = String, Dynamic = True, Default = \"This action cannot be undone.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DeleteConfirmMessage, Type = String, Dynamic = True, Default = \"Are you sure you want to delete this record\?", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DeleteConfirmTitle, Type = String, Dynamic = True, Default = \"Delete Record", Scope = Public
	#tag EndConstant

	#tag Constant, Name = EditButtonDoneCaption, Type = String, Dynamic = True, Default = \"Done", Scope = Public
	#tag EndConstant

	#tag Constant, Name = EditButtonEditCaption, Type = String, Dynamic = True, Default = \"Edit", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrorAutoPopulateColumn, Type = String, Dynamic = True, Default = \"An error occurred attempted to populate the menu: ", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrorColumnCouldNotBeSet, Type = String, Dynamic = True, Default = \"Error: The column could not be set. Column: ", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrorColumnValueChanged, Type = String, Dynamic = True, Default = \"Determining if the value of column has changed could not be completed because the column could not be accessed. Column: ", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrorNoConnection, Type = String, Dynamic = True, Default = \"Error: No connection to the database could be made.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrorRowCannotBeEdited, Type = String, Dynamic = True, Default = \"The row cannot be edited due to an error.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrorRowCouldNotBeRemovedTable, Type = String, Dynamic = True, Default = \"Error: The selected row could not be removed. Table: ", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrorValueOfControlNotSet, Type = String, Dynamic = True, Default = \"Error: The value of the control could not be set: ", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ImageMargin, Type = Double, Dynamic = False, Default = \".9", Scope = Private
	#tag EndConstant


	#tag Enum, Name = DatabaseServer, Type = Integer, Flags = &h0
		MySQL
		Postgres
	#tag EndEnum


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
		#tag ViewProperty
			Name="Table"
			Visible=true
			Group="DBKit"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Connection"
			Visible=false
			Group="DBKit"
			InitialValue=""
			Type="Database"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CreateNewRow"
			Visible=false
			Group="DBKit"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="EditIconImage"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DoneIconImage"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
