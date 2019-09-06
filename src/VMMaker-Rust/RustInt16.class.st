Class {
	#name : #RustInt16,
	#superclass : #RustSignedInteger,
	#category : #'VMMaker-Rust-Types'
}

{ #category : #converting }
RustInt16 >> asRustTypeName [
	^ 'i16'
]

{ #category : #asserting }
RustInt16 >> assertValueType: anObject [
	| aHighBit |
	
	self
		assert: [ anObject isInteger ]
		description: [ 'Must be integer' ].

	aHighBit := anObject positive
		ifTrue: [ anObject highBit ]
		ifFalse: [ anObject bitInvert highBit ].
		
	self
		assert: [ aHighBit between: 8 and: 15 ]
		description: [ 'Must be 8 to 15 bit integer' ].
]

{ #category : #accessing }
RustInt16 >> sizeOf [
	^ 2
]
