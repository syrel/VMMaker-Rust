Extension { #name : #Object }

{ #category : #'*VMMaker-Rust' }
Object >> asRustType [
	<return: #RustTypedValue>

	^ RustUnknownType value: self
]
