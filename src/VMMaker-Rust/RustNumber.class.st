Class {
	#name : #RustNumber,
	#superclass : #RustTypedValue,
	#category : #'VMMaker-Rust-Types'
}

{ #category : #converting }
RustNumber >> asRustBaseType [
	<return: #RustTypedValue>
	
	^ self
]

{ #category : #testing }
RustNumber >> isSimple [
	^ true
]
