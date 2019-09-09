Class {
	#name : #RustSome,
	#superclass : #RustOption,
	#category : #'VMMaker-Rust-Types'
}

{ #category : #asserting }
RustSome >> assertValueType: anObject [
	self
		assert: [ anObject isKindOf: RustTypedValue ]
		description: [ 'Must be a typed value' ]
]
