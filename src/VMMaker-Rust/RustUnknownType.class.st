Class {
	#name : #RustUnknownType,
	#superclass : #RustTypedValue,
	#category : #'VMMaker-Rust-Types'
}

{ #category : #arithmetic }
RustUnknownType >> * anotherType [
	^ RustUnknownType new
]

{ #category : #arithmetic }
RustUnknownType >> + anotherType [
	^ RustUnknownType new
]

{ #category : #arithmetic }
RustUnknownType >> - anotherType [
	^ RustUnknownType new
]

{ #category : #arithmetic }
RustUnknownType >> / anotherType [
	^ RustUnknownType new
]

{ #category : #converting }
RustUnknownType >> asRustBaseType [
	<return: #RustTypedValue>
	
	^ self
]

{ #category : #converting }
RustUnknownType >> asRustTypeGroup [
	<return: #Symbol>

	^ #unknown
]

{ #category : #converting }
RustUnknownType >> asRustTypeName [
	^ 'unknown ({1})' format: { self value }
]

{ #category : #asserting }
RustUnknownType >> assertValueType: anObject [
]

{ #category : #testing }
RustUnknownType >> isSimple [
	^ false
]

{ #category : #testing }
RustUnknownType >> isUnknown [
	^ true
]

{ #category : #accessing }
RustUnknownType >> sizeOf [
	^ 8
]
