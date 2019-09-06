Class {
	#name : #RustInteger,
	#superclass : #RustNumber,
	#category : #'VMMaker-Rust-Types'
}

{ #category : #arithmetic }
RustInteger >> + anotherType [
	anotherType isUnknown
		ifTrue: [ ^ RustUnknownType new ].
		
	(self hasValue and: [ anotherType hasValue ])
		ifTrue: [ ^ (self value + anotherType value) asRustType ].

	^ { self . anotherType } detectMax: [ :eachType | eachType sizeOf ]
]
