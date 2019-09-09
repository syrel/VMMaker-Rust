Class {
	#name : #RustVariable,
	#superclass : #Object,
	#instVars : [
		'variableClass',
		'name',
		'type'
	],
	#category : #'VMMaker-Rust-Variables'
}

{ #category : #accessing }
RustVariable >> name [
	^ name
]

{ #category : #accessing }
RustVariable >> name: anObject [
	name := anObject
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
