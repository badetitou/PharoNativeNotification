Class {
	#name : #NNNativeNotificationVisitor,
	#superclass : #OSPlatformVisitor,
	#instVars : [
		'notification'
	],
	#category : #NativeNotification
}

{ #category : #api }
NNNativeNotificationVisitor class >> display: aNotification [

	^ self new
		  notification: aNotification;
		  visit;
		  yourself
]

{ #category : #visiting }
NNNativeNotificationVisitor >> buildWindowsNotificationCommand [

	^ String streamContents: [ :stream | 
		  stream
		  <<
			  '& { function Show-Notification {
    [cmdletbinding()]
    Param (
        [string]
        $ToastTitle,
        [string]
        [parameter(ValueFromPipeline)]
        $ToastText
    )

    [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null;
    $Template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02);

    $RawXml = [xml] $Template.GetXml();
    ($RawXml.toast.visual.binding.text|where {$_.id -eq ''1''}).AppendChild($RawXml.CreateTextNode($ToastTitle)) > $null;
    ($RawXml.toast.visual.binding.text|where {$_.id -eq ''2''}).AppendChild($RawXml.CreateTextNode($ToastText)) > $null;

    $SerializedXml = New-Object Windows.Data.Xml.Dom.XmlDocument;
    $SerializedXml.LoadXml($RawXml.OuterXml);

    $Toast = [Windows.UI.Notifications.ToastNotification]::new($SerializedXml);
    $Toast.Tag = ''Pharo'';
    $Toast.Group = ''Pharo'';
    $Toast.ExpirationTime = [DateTimeOffset]::Now.AddMinutes(1);

    $Notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier(''Pharo'');
    $Notifier.Show($Toast);
};

Show-Notification -ToastTitle '''.
		  stream << notification title ifNil: [ '' ].
		  stream << ''''.
		  notification text ifNotNil: [ 
			  stream
				  << ' -ToastText ''';
				  << notification text;
				  << '''' ].
		  stream << ' }' ]
]

{ #category : #visiting }
NNNativeNotificationVisitor >> configWin [

	| directory |
	directory := (FileLocator temp / 'PharoNativeNotification')
		             ensureCreateDirectory.
	directory / 'ps-run.vbs' writeStreamDo: [ :stream | 
		stream << 'Set objShell = CreateObject("Wscript.Shell")
Set args = Wscript.Arguments
For Each arg In args
    objShell.Run("powershell -windowstyle hidden -executionpolicy bypass -noninteractive ""&"" ""''" & arg & "''"""),0
Next
' ].
	directory / 'notification-script.ps1' writeStreamDo: [ :stream | 
		stream << self buildWindowsNotificationCommand ]
]

{ #category : #accessing }
NNNativeNotificationVisitor >> notification [

	^ notification
]

{ #category : #accessing }
NNNativeNotificationVisitor >> notification: anObject [

	notification := anObject
]

{ #category : #visiting }
NNNativeNotificationVisitor >> visitWindows: aPlatform [

	| directory |
	directory := (FileLocator temp / 'PharoNativeNotification')
		             ensureCreateDirectory.
	self configWin.
	OSWSWinProcess new
		shellCommand: (String streamContents: [ :stream | 
					 stream
						 << 'wscript "';
						 << (directory / 'ps-run.vbs') pathString;
						 << '" "';
						 << (directory / 'notification-script.ps1') pathString;
						 << '"' ]);
		run
]
