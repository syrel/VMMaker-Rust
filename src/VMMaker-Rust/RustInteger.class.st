Class {
	#name : #RustInteger,
	#superclass : #RustNumber,
	#category : #'VMMaker-Rust-Types'
}

{ #category : #converting }
RustInteger >> asRustLiteral [
	self assertHasValue.
	
	^ self value asString
]

{ #category : #testing }
RustInteger >> isInteger [
	^ true
]

{ #category : #testing }
RustInteger >> isSigned [
	^ false
]

{ #category : #testing }
RustInteger >> isUnsigned [
	^ false
]

{ #category : #'as yet unclassified' }
RustInteger >> largerType [
	"Return a larger type of me if possible"
	<return: #RustInteger>
	
	^ self subclassResponsibility
]
