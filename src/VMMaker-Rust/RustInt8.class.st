Class {
	#name : #RustInt8,
	#superclass : #RustSignedInteger,
	#category : #'VMMaker-Rust-Types'
}

{ #category : #converting }
RustInt8 >> asRustTypeName [
	^ 'i8'
]

{ #category : #asserting }
RustInt8 >> assertValueType: anObject [
	| aHighBit |

	self
		assert: [ anObject isInteger ]
		description: [ 'Must be integer' ].

	aHighBit := anObject positive
		ifTrue: [ anObject highBit ]
		ifFalse: [ anObject bitInvert highBit ].
		
	self
		assert: [ aHighBit < 8 ]
		description: [ 'Must be less than 8 bit integer' ]
]

{ #category : #'as yet unclassified' }
RustInt8 >> largerType [
	"Return a larger type of me if possible"
	<return: #RustInteger>
	
	^ RustInt16 new
]

{ #category : #accessing }
RustInt8 >> sizeOf [
	^ 1
]
