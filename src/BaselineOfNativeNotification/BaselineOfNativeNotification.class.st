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
]

{ #category : #baselines }
BaselineOfNativeNotification >> defineGroups: spec [
]

{ #category : #baselines }
BaselineOfNativeNotification >> definePackages: spec [

	spec package: 'NativeNotification'
]
