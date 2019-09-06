Class {
	#name : #RustString,
	#superclass : #RustTypedValue,
	#category : #'VMMaker-Rust-Types'
}

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
