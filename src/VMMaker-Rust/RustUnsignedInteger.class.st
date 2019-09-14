Class {
	#name : #RustUnsignedInteger,
	#superclass : #RustInteger,
	#category : #'VMMaker-Rust-Types'
}

{ #category : #converting }
RustUnsignedInteger >> asSigned [
	"Convert me to a signed integer"
	<return: #RustSignedInteger>
	
	^ self subclassResponsibility
]

{ #category : #testing }
RustUnsignedInteger >> isUnsigned [
	^ false
]
