Class {
	#name : #RustTDefineNode,
	#superclass : #RustTConstantNode,
	#instVars : [
		'name'
	],
	#category : #'VMMaker-Rust'
}

{ #category : #accessing }
RustTDefineNode >> constantNumbericValueOrNil [
	"Override so that named constants don't get elided."
	^nil
]

{ #category : #'C code generation' }
RustTDefineNode >> emitCCodeOn: aStream level: level generator: aCodeGen [
	"Emit a C literal."

	aStream nextPutAll: name.
]

{ #category : #testing }
RustTDefineNode >> isDefine [

	^true
]

{ #category : #comparing }
RustTDefineNode >> isSameAs: aTParseNode [
	^self class == aTParseNode class
	  and: [value class == aTParseNode value class
	  and: [value = aTParseNode value
	  and: [name = aTParseNode nameOrValue]]]
]

{ #category : #accessing }
RustTDefineNode >> name [
	^name
]

{ #category : #accessing }
RustTDefineNode >> name: aName [
	name := aName
]

{ #category : #accessing }
RustTDefineNode >> nameOrValue [
	^name
]

{ #category : #'C code generation' }
RustTDefineNode >> printOn: aStream level: level [

	aStream nextPutAll: name
]

{ #category : #accessing }
RustTDefineNode >> setName: aName value: aValue [
	self name: aName.
	self setValue: aValue.
]
