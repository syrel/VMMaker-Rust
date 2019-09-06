Extension { #name : #Symbol }

{ #category : #'*VMMaker-Rust' }
Symbol >> asRustType [
	<return: #RustTypedValue>

	^ RustUnknownType value: self
]
