Extension { #name : #Float }

{ #category : #'*VMMaker-Rust' }
Float >> asRustType [
	<return: #RustTypedValue>
	
	^ self exponent abs highBit <= 7
		ifTrue: [ RustFloat32 value: self ]
		ifFalse: [ RustFloat64 value: self ]
]
