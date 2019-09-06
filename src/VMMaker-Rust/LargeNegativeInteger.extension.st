Extension { #name : #LargeNegativeInteger }

{ #category : #'*VMMaker-Rust' }
LargeNegativeInteger >> asRustType [
	<return: #RustTypedValue>

	^ self >= -9223372036854775808
		ifTrue: [ RustInt64 value: self ]
		ifFalse: [ RustUnknownType value: self ]
]
