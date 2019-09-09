Class {
	#name : #RustBoolean,
	#superclass : #RustTypedValue,
	#category : #'VMMaker-Rust-Types'
}

{ #category : #converting }
RustBoolean >> asRustBaseType [
	<return: #RustTypedValue>
	
	^ self
]

{ #category : #converting }
RustBoolean >> asRustLiteral [
	self assertHasValue.

	^ self value
		ifTrue: [ 'true' ]
		ifFalse: [ 'false' ]
]

{ #category : #converting }
RustBoolean >> asRustTypeGroup [
	<return: #Symbol>
	
	^ #boolean
]

{ #category : #converting }
RustBoolean >> asRustTypeName [
	^ 'bool'
]

{ #category : #accessing }
RustBoolean >> assertValueType: anObject [
	self
		assert: [ anObject == true or: [ anObject == false ] ]
		description: [ 'Must be a boolean' ]
]

{ #category : #testing }
RustBoolean >> isSimple [
	^ true
]

{ #category : #accessing }
RustBoolean >> sizeOf [
	^ 1
]
