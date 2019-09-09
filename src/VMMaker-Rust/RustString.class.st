Class {
	#name : #RustString,
	#superclass : #RustTypedValue,
	#category : #'VMMaker-Rust-Types'
}

{ #category : #converting }
RustString >> asRustBaseType [
	<return: #RustTypedValue>
	
	^ self
]

{ #category : #converting }
RustString >> asRustLiteral [
	self assertHasValue.

	^ '"', (self value copyReplaceAll: (String with: Character cr) with: '\n') , '".to_string()'
]

{ #category : #converting }
RustString >> asRustTypeGroup [
	<return: #Symbol>

	^ #string
]

{ #category : #converting }
RustString >> asRustTypeName [
	^ 'String'
]

{ #category : #asserting }
RustString >> assertValueType: anObject [

	self
		assert: [ anObject isString ]
		description: [ 'Must be a string' ].

	self
		assert: [ anObject isSymbol not ]
		description: [ 'Must not be a symbol' ].
]

{ #category : #accessing }
RustString >> sizeOf [
	^ 8
]
