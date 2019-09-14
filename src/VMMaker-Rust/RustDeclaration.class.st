Class {
	#name : #RustDeclaration,
	#superclass : #Object,
	#instVars : [
		'variableName',
		'variableType'
	],
	#category : #'VMMaker-Rust-Declarations'
}

{ #category : #'instance creation' }
RustDeclaration class >> name: aNameSymbol type: aRustType [
	^ self new
		variableName: aNameSymbol;
		variableType: aRustType
]

{ #category : #'api - converting' }
RustDeclaration >> beSigned [
	self
		assert: [ self variableType isInteger ]
		description: [ 'Must be integer' ].

	self variableType: self variableType asSigned
]

{ #category : #accessing }
RustDeclaration >> variableName [
	^ variableName
]

{ #category : #accessing }
RustDeclaration >> variableName: aNameSymbol [

	self
		assert: [ aNameSymbol isSymbol ]
		description: [ 'Must be a symbol' ].

	variableName := aNameSymbol
]

{ #category : #accessing }
RustDeclaration >> variableType [
	^ variableType
]

{ #category : #accessing }
RustDeclaration >> variableType: aRustType [
	self
		assert: [ aRustType isKindOf: RustTypedValue ]
		description: [ 'Must be rust typed value' ].

	variableType := aRustType
]
