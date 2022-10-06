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

	LibC runCommand: (String streamContents: [ :stream | 
			 stream
			 <<
			 'start powershell -noprofil -command "& New-BurntToastNotification -Text '''.
			 stream << notification title ifNil: [ '' ].
			 stream << ''', '''.
			 stream << notification text ifNil: [ '' ].
			 stream << '''"' ])
]
