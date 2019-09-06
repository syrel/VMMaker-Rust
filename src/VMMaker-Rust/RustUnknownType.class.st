Class {
	#name : #RustUnknownType,
	#superclass : #RustTypedValue,
	#category : #'VMMaker-Rust-Types'
}

{ #category : #arithmetic }
RustUnknownType >> + anotherType [
	^ RustUnknownType new
]

{ #category : #converting }
RustUnknownType >> asRustTypeName [
	^ 'unknown'
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
