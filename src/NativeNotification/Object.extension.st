Extension { #name : #Object }

{ #category : #'*NativeNotification' }
Object >> nativeInform: aString withText: aTextString [

	NNNativeNotificationVisitor display: (NNNativeNotification new
			 title: aString;
			 text: aTextString;
			 yourself)
]
