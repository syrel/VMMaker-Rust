Class {
	#name : #RustArray,
	#superclass : #RustTypedValue,
	#category : #'VMMaker-Rust-Types'
}

{ #category : #converting }
RustArray >> asRustBaseType [
	<return: #RustTypedValue>
	
	^ self
]

{ #category : #converting }
RustArray >> asRustLiteral [
	"Return a string representing the Rust literal value for my value"
	<return: #String>

	self assertHasValue.
	
	^ String streamContents: [ :aStream |
		aStream nextPut: $[.
		self value
			do: [ :each | aStream nextPutAll: each asRustType asRustLiteral ]
			separatedBy: [ aStream nextPutAll: ', ' ].
		aStream nextPut: $] ]
]

{ #category : #converting }
RustArray >> asRustTypeGroup [
	<return: #Symbol>
	
	^ #array
]

{ #category : #converting }
RustArray >> asRustTypeName [
	"Return a string representing this Rust type"
	<return: #String>
	| aLargestType |
	self assertHasValue.
	
	aLargestType := (self value detectMax: [ :eachValue | eachValue asRustType sizeOf ]) asRustType.

	^ '[{1}; {2}]' format: { aLargestType asRustTypeName . self value size }
]

{ #category : #asserting }
RustArray >> assertValueType: anObject [
	self 
		assert: [ anObject isKindOf: Array ]
		description: [ 'Must be array' ]
]

{ #category : #accessing }
RustArray >> sizeOf [
	| aLargestType |
	
	self assertHasValue.
	aLargestType := (self value detectMax: [ :eachValue | eachValue asRustType sizeOf ]) asRustType.
	
	^ aLargestType sizeOf * self value size
]
