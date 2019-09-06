Class {
	#name : #RustTGoToNode,
	#superclass : #RustTParseNode,
	#instVars : [
		'label'
	],
	#category : #'VMMaker-Rust'
}

{ #category : #'C code generation' }
RustTGoToNode >> emitCCodeOn: aStream level: level generator: aCodeGen [
	"Emit a C goto statement."

	aStream nextPutAll: 'goto '.
	aStream nextPutAll: label.
]

{ #category : #'C code generation' }
RustTGoToNode >> emitCCodeOn: aStream prependToEnd: aNodeOrNil level: lev generator: gen [
	self emitCCodeOn: aStream level: lev generator: gen
]

{ #category : #testing }
RustTGoToNode >> isGoTo [

	^true
]

{ #category : #accessing }
RustTGoToNode >> label [

	^label
]

{ #category : #enumerating }
RustTGoToNode >> nodesDo: aBlock parent: parent [
	aBlock value: self value: parent
]

{ #category : #printing }
RustTGoToNode >> printOn: aStream level: level [

	aStream nextPutAll: 'goto '.
	aStream nextPutAll: label.
]

{ #category : #accessing }
RustTGoToNode >> setLabel: aString [
	label := aString
]
