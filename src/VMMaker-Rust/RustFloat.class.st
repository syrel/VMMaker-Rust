Class {
	#name : #RustFloat,
	#superclass : #RustNumber,
	#category : #'VMMaker-Rust-Types'
}

{ #category : #'instance creation' }
RustFloat class >> ofSize: amountBits [
	"Return an instance of a number type for a given amount of bits"
	<return: #RustNumber>
	
	^ amountBits <= 4
		ifTrue: [ RustFloat32 new ]
		ifFalse: [ RustFloat64 new ]
]

{ #category : #testing }
RustFloat >> isFloat [
	^ true
]
