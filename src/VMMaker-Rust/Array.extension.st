Extension { #name : #Array }

{ #category : #'*VMMaker-Rust' }
Array >> asRustType [
	<return: #RustTypedValue>

	^ RustArray value: self
]
