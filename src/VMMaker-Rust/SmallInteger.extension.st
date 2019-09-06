Extension { #name : #SmallInteger }

{ #category : #'*VMMaker-Rust' }
SmallInteger >> asRustType [
	<return: #RustTypedValue>
	| aHighBit |
	
	aHighBit := self positive
		ifTrue: [ self highBit ]
		ifFalse: [ self bitInvert highBit. ].
	
	aHighBit < 8
		ifTrue: [ ^ RustInt8 value: self ].
	aHighBit < 16
		ifTrue: [ ^ RustInt16 value: self ].
	aHighBit < 32
		ifTrue: [ ^ RustInt32 value: self ].
	
	^ RustInt64 value: self
]
