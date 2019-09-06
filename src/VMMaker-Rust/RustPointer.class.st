Class {
	#name : #RustPointer,
	#superclass : #RustTypedValue,
	#category : #'VMMaker-Rust-Types'
}

{ #category : #asserting }
RustPointer >> assertValueType: anObject [
	
	self
		assert: [ anObject isKindOf: RustTypedValue ]
		description: [ 'A value must be a rust typed value' ].
]

{ #category : #testing }
RustPointer >> isPointer [
	^ true
]

{ #category : #testing }
RustPointer >> isSimple [
	^ true
]
