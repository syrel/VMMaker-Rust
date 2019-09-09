Class {
	#name : #RustFloat32,
	#superclass : #RustFloat,
	#category : #'VMMaker-Rust-Types'
}

{ #category : #converting }
RustFloat32 >> asRustTypeName [
	^ 'f32'
]

{ #category : #asserting }
RustFloat32 >> assertValueType: anObject [
	
	self
		assert: [ anObject isFloat ]
		description: [ 'Must be float' ]
]

{ #category : #'as yet unclassified' }
RustFloat32 >> largerType [
	"Return a larger type of me if possible"
	<return: #RustFloat>

	^ RustFloat64 new
]

{ #category : #accessing }
RustFloat32 >> sizeOf [
	^ 4
]
