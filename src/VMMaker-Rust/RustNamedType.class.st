Class {
	#name : #RustNamedType,
	#superclass : #RustTypedValue,
	#instVars : [
		'name'
	],
	#category : #'VMMaker-Rust-Types'
}

{ #category : #converting }
RustNamedType >> asRustBaseType [
	<return: #RustTypedValue>
	
	^ self
]

{ #category : #converting }
RustNamedType >> asRustLiteral [
	self assertHasValue.

	^ self value asString
]

{ #category : #converting }
RustNamedType >> asRustTypeGroup [
	<return: #Symbol>
	
	^ self name asSymbol
]

{ #category : #converting }
RustNamedType >> asRustTypeName [
	^ self name
]

{ #category : #testing }
RustNamedType >> isSimple [
	^ false
]

{ #category : #accessing }
RustNamedType >> name [
	^ name
]

{ #category : #accessing }
RustNamedType >> name: anObject [
	name := anObject
]
