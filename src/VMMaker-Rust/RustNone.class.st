Class {
	#name : #RustNone,
	#superclass : #RustOption,
	#category : #'VMMaker-Rust-Types'
}

{ #category : #arithmetic }
RustNone >> + anotherType [
	^ self class new
]

{ #category : #arithmetic }
RustNone >> - anotherType [
	^ self class new
]

{ #category : #converting }
RustNone >> asRustLiteral [
	^ 'None'
]

{ #category : #asserting }
RustNone >> assertValueType: anObject [
	self 
		assert: [ anObject isNil ]
		description: [ 'Must be nil' ]
]
