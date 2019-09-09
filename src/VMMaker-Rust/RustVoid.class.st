Class {
	#name : #RustVoid,
	#superclass : #RustTypedValue,
	#category : #'VMMaker-Rust-Types'
}

{ #category : #converting }
RustVoid >> asRustLiteral [
	"Return a string representing the Rust literal value for my value"
	<return: #String>

	^ '/* {1} */' format: { value }
]

{ #category : #asserting }
RustVoid >> assertValueType: anObject [
	self
		assert: [ anObject isNil ]
		description: [ 'Must be nil' ]
]

{ #category : #testing }
RustVoid >> isVoid [
	^ true
]
