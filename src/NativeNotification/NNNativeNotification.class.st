Class {
	#name : #NNNativeNotification,
	#superclass : #OSPlatformVisitor,
	#instVars : [
		'title',
		'text',
		'creator'
	],
	#category : #NativeNotification
}

{ #category : #accessing }
NNNativeNotification >> creator [

	^ creator
]

{ #category : #accessing }
NNNativeNotification >> creator: anObject [

	creator := anObject
]

{ #category : #initialization }
NNNativeNotification >> initialize [
	super initialize.
	creator := 'Pharo'
]

{ #category : #accessing }
NNNativeNotification >> text [

	^ text
]

{ #category : #accessing }
NNNativeNotification >> text: anObject [

	text := anObject
]

{ #category : #accessing }
NNNativeNotification >> title [

	^ title
]

{ #category : #accessing }
NNNativeNotification >> title: anObject [

	title := anObject
]
