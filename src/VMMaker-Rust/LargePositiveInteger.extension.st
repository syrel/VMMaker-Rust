Extension { #name : #LargePositiveInteger }

{ #category : #'*VMMaker-Rust' }
LargePositiveInteger >> asRustType [
	<return: #RustTypedValue>

	^ self <= 9223372036854775807
		ifTrue: [ RustInt64 value: self ]
		ifFalse: [ RustUnknownType value: self ]
]
