Class {
	#name : #RustFloat64,
	#superclass : #RustFloat,
	#category : #'VMMaker-Rust-Types'
}

{ #category : #converting }
RustFloat64 >> asRustTypeName [
	^ 'f64'
]

{ #category : #asserting }
RustFloat64 >> assertValueType: anObject [
	
	self
		assert: [ anObject isFloat ]
		description: [ 'Must be float' ]
]

{ #category : #'as yet unclassified' }
RustFloat64 >> largerType [
	"Return a larger type of me if possible"
	<return: #RustFloat>

	^ RustFloat64 new
]

{ #category : #accessing }
RustFloat64 >> sizeOf [
	^ 8
]
