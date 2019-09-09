Class {
	#name : #RustClassType,
	#superclass : #RustTypedValue,
	#instVars : [
		'typeClass'
	],
	#category : #'VMMaker-Rust-Types'
}

{ #category : #converting }
RustClassType >> asRustBaseType [
	<return: #RustTypedValue>
	
	^ self
]

{ #category : #converting }
RustClassType >> asRustLiteral [
	self assertHasValue.

	^ self value asString
]

{ #category : #converting }
RustClassType >> asRustTypeGroup [
	<return: #Symbol>
	
	^ self value asSymbol
]

{ #category : #converting }
RustClassType >> asRustTypeName [
	^ self typeClass name
]

{ #category : #asserting }
RustClassType >> assertValueType: anObject [
	
]

{ #category : #testing }
RustClassType >> isSimple [
	^ true
]

{ #category : #accessing }
RustClassType >> sizeOf [
	^ 8
]

{ #category : #accessing }
RustClassType >> typeClass [
	^ typeClass
]

{ #category : #accessing }
RustClassType >> typeClass: aClass [
	typeClass := aClass
]
