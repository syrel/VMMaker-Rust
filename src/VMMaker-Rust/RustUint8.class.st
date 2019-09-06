Class {
	#name : #RustUint8,
	#superclass : #RustUnsignedInteger,
	#category : #'VMMaker-Rust-Types'
}

{ #category : #asserting }
RustUint8 >> assertValueType: anObject [
	| aHighBit |

	self
		assert: [ anObject isInteger ]
		description: [ 'Must be integer' ].

	self
		assert: [ anObject positive ]
		description: [ 'Must be positive' ].

	aHighBit := anObject highBit.
		
	self
		assert: [ aHighBit <= 8 ]
		description: [ 'Must fit in 8 bit unsinged integer' ]
]
