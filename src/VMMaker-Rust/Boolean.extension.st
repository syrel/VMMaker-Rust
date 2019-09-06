Extension { #name : #Boolean }

{ #category : #'*VMMaker-Rust' }
Boolean >> asRustType [
	<return: #RustTypedValue>

	^ RustBoolean value: self
]
