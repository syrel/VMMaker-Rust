Class {
	#name : #RustInteger,
	#superclass : #RustNumber,
	#category : #'VMMaker-Rust-Types'
}

{ #category : #arithmetic }
RustInteger >> * anotherType [
	anotherType isUnknown
		ifTrue: [ ^ RustUnknownType new ].
		
	(self hasValue and: [ anotherType hasValue ])
		ifTrue: [ ^ (self value * anotherType value) asRustType ].

	^ ({ self . anotherType } detectMax: [ :eachType | eachType sizeOf ]) largerType
]

{ #category : #arithmetic }
RustInteger >> + anotherType [
	anotherType isUnknown
		ifTrue: [ ^ RustUnknownType new ].

	(self hasValue and: [ anotherType hasValue ])
		ifTrue: [ ^ (self value + anotherType value) asRustType ].

	^ ({ self . anotherType } detectMax: [ :eachType | eachType sizeOf ]) largerType
]

{ #category : #arithmetic }
RustInteger >> - anotherType [
	anotherType isUnknown
		ifTrue: [ ^ RustUnknownType new ].
		
	(self hasValue and: [ anotherType hasValue ])
		ifTrue: [
			| aResultingType |
			aResultingType := (self value - anotherType value) asRustType.
			"in case of substructions resulting type must not be smaller than me. it can grow however"
			^ ({ self . anotherType . aResultingType } detectMax: [ :eachType | eachType sizeOf ]) ].

	^ ({ self . anotherType } detectMax: [ :eachType | eachType sizeOf ]) largerType
]

{ #category : #converting }
RustInteger >> asRustLiteral [
	self assertHasValue.
	
	^ self value asString
]

{ #category : #'as yet unclassified' }
RustInteger >> largerType [
	"Return a larger type of me if possible"
	<return: #RustInteger>
	
	^ self subclassResponsibility
]
