Class {
	#name : #RustOption,
	#superclass : #RustTypedValue,
	#category : #'VMMaker-Rust-Types'
}

{ #category : #arithmetic }
RustOption >> + anotherType [
	| aResultingType |

	aResultingType := self value + anotherType.
	^ self class value: aResultingType
]

{ #category : #converting }
RustOption >> asRustBaseType [
	^ self
]

{ #category : #converting }
RustOption >> asRustTypeGroup [
	<return: #Symbol>

	^ #optional
]

{ #category : #converting }
RustOption >> asRustTypeName [
	<return: #String>
	
	self assertHasValue.
	
	^ 'Option<{1}>' format: { self value asRustTypeName }
]

{ #category : #asserting }
RustOption >> assertValueType: anObject [
	self
		assert: [ anObject isKindOf: RustTypedValue ]
		description: [ 'Must be a typed value' ]
]

{ #category : #testing }
RustOption >> isOption [
	^ true
]
