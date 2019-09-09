Class {
	#name : #RustInt32,
	#superclass : #RustSignedInteger,
	#category : #'VMMaker-Rust-Types'
}

{ #category : #converting }
RustInt32 >> asRustTypeName [
	^ 'i32'
]

{ #category : #asserting }
RustInt32 >> assertValueType: anObject [
	| aHighBit |
	
	self
		assert: [ anObject isInteger ]
		description: [ 'Must be integer' ].
		
	aHighBit := anObject positive
		ifTrue: [ anObject highBit ]
		ifFalse: [ anObject bitInvert highBit ].
		
	self
		assert: [ aHighBit between: 16 and: 31 ]
		description: [ 'Must be 16 to 31 bit integer' ].
]

{ #category : #'as yet unclassified' }
RustInt32 >> largerType [
	"Return a larger type of me if possible"
	<return: #RustInteger>
	
	^ RustInt64 new
]

{ #category : #accessing }
RustInt32 >> sizeOf [
	^ 4
]
