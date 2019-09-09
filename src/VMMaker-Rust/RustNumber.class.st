Class {
	#name : #RustNumber,
	#superclass : #RustTypedValue,
	#category : #'VMMaker-Rust-Types'
}

{ #category : #'instance creation' }
RustNumber class >> ofSize: amountBits [
	"Return an instance of a number type for a given amount of bits"
	<return: #RustNumber>
	
	^ self subclassResponsibility
]

{ #category : #arithmetic }
RustNumber >> * anotherType [
	anotherType isUnknown
		ifTrue: [ ^ RustUnknownType new ].

	(self hasValue and: [ anotherType hasValue ])
		ifTrue: [ ^ (self value * anotherType value) asRustType ].

	^ (self common: anotherType) largerType
]

{ #category : #arithmetic }
RustNumber >> + anotherType [
	anotherType isUnknown
		ifTrue: [ ^ RustUnknownType new ].

	(self hasValue and: [ anotherType hasValue ])
		ifTrue: [ ^ (self value + anotherType value) asRustType ].

	^ (self common: anotherType) largerType
]

{ #category : #arithmetic }
RustNumber >> - anotherType [
	anotherType isUnknown
		ifTrue: [ ^ RustUnknownType new ].
		
	(self hasValue and: [ anotherType hasValue ])
		ifTrue: [
			| aResultingType |
			aResultingType := (self value - anotherType value) asRustType.
			"in case of substructions resulting type must not be smaller than me. it can grow however"
			
			^ aResultingType class ofSize: ({ self . anotherType . aResultingType } detectMax: [ :eachType | eachType sizeOf ]) sizeOf ].

	^ (self common: anotherType) largerType
]

{ #category : #converting }
RustNumber >> asRustBaseType [
	<return: #RustTypedValue>
	
	^ self
]

{ #category : #converting }
RustNumber >> asRustLiteral [
	self assertHasValue.
	
	^ self value asString
]

{ #category : #converting }
RustNumber >> asRustTypeGroup [
	<return: #Symbol>

	^ #number
]

{ #category : #'as yet unclassified' }
RustNumber >> common: anotherType [
	"Return a common type for arithmetic operations such as * and /"
	<return: #RustTypedValue>
	
	anotherType isNumber
		ifFalse: [ ^ RustUnknownType new ].
		
	(self isFloat and: [ anotherType isFloat ])
		ifTrue: [ ^ self max: anotherType ].
		
	(self isInteger and: [ anotherType isInteger ])
		ifTrue: [ ^ self max: anotherType ].

	^ RustFloat ofSize: (self max: anotherType) sizeOf
]

{ #category : #testing }
RustNumber >> isNumber [
	^ true
]

{ #category : #testing }
RustNumber >> isSimple [
	^ true
]

{ #category : #accessing }
RustNumber >> max: anotherType [
	"Return a larger type between me and another type"
	<return: #RustTypedValue>
	
	^ self sizeOf >= anotherType sizeOf
		ifTrue: [ self ]
		ifFalse: [ anotherType ]
]
