Class {
	#name : #RustVariable,
	#superclass : #Object,
	#instVars : [
		'variableClass',
		'name',
		'type'
	],
	#category : #'VMMaker-Rust-Meta'
}

{ #category : #accessing }
RustVariable >> name [
	^ name
]

{ #category : #accessing }
RustVariable >> name: aName [

	self
		assert: [ aName isSymbol ]
		description: [ 'Must be a symbol' ].

	name := aName
]

{ #category : #accessing }
RustVariable >> type [
	^ type
]

{ #category : #accessing }
RustVariable >> type: anObject [
	type := anObject
]

{ #category : #accessing }
RustVariable >> variableClass [
	^ variableClass
]

{ #category : #accessing }
RustVariable >> variableClass: anObject [
	variableClass := anObject
]
