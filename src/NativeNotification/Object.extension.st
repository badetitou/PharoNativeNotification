Extension { #name : #Object }

{ #category : #'*NativeNotification' }
Object >> nativeInform: aString [

	NNNativeNotificationVisitor display: (NNNativeNotification new
			 title: aString;
			 yourself)
]

{ #category : #'*NativeNotification' }
Object >> nativeInform: aString withText: aTextString [

	NNNativeNotificationVisitor display: (NNNativeNotification new
			 title: aString;
			 text: aTextString;
			 yourself)
]

{ #category : #'*NativeNotification' }
Object >> nativeInform: aString withText: aTextString withCreator: aCreator [

	NNNativeNotificationVisitor display: (NNNativeNotification new
			 title: aString;
			 text: aTextString;
			 creator: aCreator;
			 yourself)
]
