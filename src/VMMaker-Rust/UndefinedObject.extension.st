Extension { #name : #UndefinedObject }

{ #category : #'*VMMaker-Rust' }
UndefinedObject >> asRustType [
	<return: #RustTypedValue>

	^ RustVoid value: self
]
