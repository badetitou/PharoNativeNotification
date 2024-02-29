Class {
	#name : #BaselineOfNativeNotification,
	#superclass : #BaselineOf,
	#category : #BaselineOfNativeNotification
}

{ #category : #baselines }
BaselineOfNativeNotification >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		self defineDependencies: spec.
		self definePackages: spec.
		self defineGroups: spec ]
]

{ #category : #baselines }
BaselineOfNativeNotification >> defineDependencies: spec [

	spec baseline: 'OSSubprocess' with: [ 
		spec repository:
			'github://pharo-contributions/OSSubprocess:v1.4.2/repository' ].
	spec baseline: 'OSWinSubprocess' with: [ 
		spec repository:
			'github://pharo-contributions/OSWinSubprocess:v1' ]
]

{ #category : #baselines }
BaselineOfNativeNotification >> defineGroups: spec [
]

{ #category : #baselines }
BaselineOfNativeNotification >> definePackages: spec [

	spec
		package: 'NativeNotification'
		with: [ spec requires: #( 'OSSubprocess' 'OSWinSubprocess' ) ]
]
