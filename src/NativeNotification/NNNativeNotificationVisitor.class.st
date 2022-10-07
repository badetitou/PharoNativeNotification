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
NNNativeNotificationVisitor >> buildWindowsCommand [

	^ String streamContents: [ :stream | 
		  stream
		  <<
			  'start powershell -noprofil -command "& { function Show-Notification {
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
		  stream << ''' }"' ]
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
	LibC runCommand: self buildWindowsCommand
]
