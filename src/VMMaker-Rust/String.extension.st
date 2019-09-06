Extension { #name : #String }

{ #category : #'*VMMaker-Rust' }
String >> asRustType [
	<return: #RustTypedValue>

	^ RustString value: self
]
