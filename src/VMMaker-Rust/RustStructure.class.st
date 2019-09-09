Class {
	#name : #RustStructure,
	#superclass : #Object,
	#instVars : [
		'variables',
		'methods',
		'constants'
	],
	#category : #'VMMaker-Rust-Variables'
}

{ #category : #accessing }
RustStructure >> constants [
	^ constants
]

{ #category : #accessing }
RustStructure >> constants: anObject [
	constants := anObject
]

{ #category : #accessing }
RustStructure >> methods [
	^ methods
]

{ #category : #accessing }
RustStructure >> methods: anObject [
	methods := anObject
]

{ #category : #accessing }
RustStructure >> variables [
	^ variables
]

{ #category : #accessing }
RustStructure >> variables: anObject [
	variables := anObject
]
