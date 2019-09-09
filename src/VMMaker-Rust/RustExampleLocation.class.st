Class {
	#name : #RustExampleLocation,
	#superclass : #Object,
	#instVars : [
		'latitude',
		'longitude'
	],
	#category : #'VMMaker-Rust-Examples - Cities'
}

{ #category : #'as yet unclassified' }
RustExampleLocation class >> rustInstanceVariableTypeOf: aVariableName [
	aVariableName = #latitude
		ifTrue: [ ^ RustInt32 new ].
		
	aVariableName = #longitude
		ifTrue: [ ^ RustInt32 new ]
]

{ #category : #accessing }
RustExampleLocation >> latitude [
	^ latitude
]

{ #category : #accessing }
RustExampleLocation >> latitude: anObject [
	latitude := anObject
]

{ #category : #accessing }
RustExampleLocation >> longitude [
	^ longitude
]

{ #category : #accessing }
RustExampleLocation >> longitude: anObject [
	longitude := anObject
]
