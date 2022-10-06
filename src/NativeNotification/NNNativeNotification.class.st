Class {
	#name : #NNNativeNotification,
	#superclass : #OSPlatformVisitor,
	#instVars : [
		'title',
		'text'
	],
	#category : #NativeNotification
}

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
