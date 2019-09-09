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

{ #category : #converting }
RustNumber >> asRustTypeGroup [
	<return: #Symbol>

	^ #number
]

{ #category : #testing }
RustNumber >> isSimple [
	^ true
]
