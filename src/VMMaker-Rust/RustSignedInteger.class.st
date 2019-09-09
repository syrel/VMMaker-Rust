Class {
	#name : #RustSignedInteger,
	#superclass : #RustInteger,
	#category : #'VMMaker-Rust-Types'
}

{ #category : #'instance creation' }
RustSignedInteger class >> ofSize: amountBits [
	"Return an instance of a number type for a given amount of bits"
	<return: #RustNumber>
	
	^ amountBits <= 1
		ifTrue: [ RustInt8 new ]
		ifFalse: [
			amountBits <= 2
				ifTrue: [ RustInt16 new ]
				ifFalse: [
					amountBits <= 4
						ifTrue: [ RustInt32 new ]
						ifFalse: [ RustInt64 new ] ] ]
]
