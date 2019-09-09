Class {
	#name : #RustTypedValue,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'VMMaker-Rust-Types'
}

{ #category : #accessing }
RustTypedValue class >> value: anObject [
	^ self new value: anObject
]

{ #category : #comparing }
RustTypedValue >> = anotherObject [
	self == anotherObject
		ifTrue: [ ^ true ].

	self class == anotherObject class
		ifFalse: [ ^ false ].

	^ self value = anotherObject value
]

{ #category : #converting }
RustTypedValue >> asRustBaseType [
	<return: #RustTypedValue>

	^ self subclassResponsibility
]

{ #category : #converting }
RustTypedValue >> asRustLiteral [
	"Return a string representing the Rust literal value for my value"
	<return: #String>

	^ self subclassResponsibility
]

{ #category : #converting }
RustTypedValue >> asRustType [
	<return: #RustTypedValue>

	^ self
]

{ #category : #converting }
RustTypedValue >> asRustTypeGroup [
	<return: #Symbol>
	
	^ self subclassResponsibility
]

{ #category : #converting }
RustTypedValue >> asRustTypeName [
	"Return a string representing this Rust type"
	<return: #String>

	^ self subclassResponsibility
]

{ #category : #asserting }
RustTypedValue >> assertHasValue [
	self
		assert: [ self hasValue ]
		description: [ 'I must have a value' ]
]

{ #category : #asserting }
RustTypedValue >> assertValueType: anObject [
	self subclassResponsibility
]

{ #category : #testing }
RustTypedValue >> hasValue [
	^ value isNotNil
]

{ #category : #comparing }
RustTypedValue >> hash [
	^ self class hash bitXor: self value hash
]

{ #category : #testing }
RustTypedValue >> isOption [
	^ false
]

{ #category : #testing }
RustTypedValue >> isPointer [
	^ false
]

{ #category : #testing }
RustTypedValue >> isSimple [
	"For the purposes of the read-before-written initializer, answer if
	 aType is simple, e.g. not a structure, and array or an opaque type."

	^ self subclassResponsibility
]

{ #category : #testing }
RustTypedValue >> isUnknown [
	^ false
]

{ #category : #accessing }
RustTypedValue >> sizeOf [
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
RustTypedValue >> value [
	^ value
]

{ #category : #accessing }
RustTypedValue >> value: anObject [

	self assertValueType: anObject.
	value := anObject
]
