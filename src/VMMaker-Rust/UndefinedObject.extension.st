Extension { #name : #UndefinedObject }

{ #category : #'*VMMaker-Rust' }
UndefinedObject >> asRustType [
	<return: #RustTypedValue>

	^ RustNone value: self
]
