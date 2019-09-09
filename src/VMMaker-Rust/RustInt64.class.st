Class {
	#name : #RustInt64,
	#superclass : #RustSignedInteger,
	#category : #'VMMaker-Rust-Types'
}

{ #category : #converting }
RustInt64 >> asRustTypeName [
	^ 'i64'
]

{ #category : #asserting }
RustInt64 >> assertValueType: anObject [
	| aHighBit |

	self
		assert: [ anObject isInteger ]
		description: [ 'Must be integer' ].

	aHighBit := anObject positive
		ifTrue: [ anObject highBit ]
		ifFalse: [ anObject bitInvert highBit ].
		
	self
		assert: [ aHighBit between: 32 and: 63 ]
		description: [ 'Must be less than between 32 and 63 bit integer' ].
]

{ #category : #'as yet unclassified' }
RustInt64 >> largerType [
	"Return a larger type of me if possible"
	<return: #RustInteger>
	
	^ self class new
]

{ #category : #accessing }
RustInt64 >> sizeOf [
	^ 8
]
