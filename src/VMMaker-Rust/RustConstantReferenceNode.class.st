Class {
	#name : #RustConstantReferenceNode,
	#superclass : #RustTVariableNode,
	#instVars : [
		'definingClass'
	],
	#category : #'VMMaker-Rust-Nodes'
}

{ #category : #accessing }
RustConstantReferenceNode >> definingClass [
	^ definingClass
]

{ #category : #accessing }
RustConstantReferenceNode >> definingClass: anObject [
	definingClass := anObject
]

{ #category : #'C code generation' }
RustConstantReferenceNode >> emitCCodeOn: aStream level: level generator: aCodeGen [

	aStream nextPutAll: self definingClass name.
	aStream nextPutAll: '::'.
	aStream nextPutAll: (aCodeGen returnPrefixFromVariable: name).

	aCodeGen currentMethod ifNotNil: [ :m | m noteUsedVariableName: name ]
]

{ #category : #'type inference' }
RustConstantReferenceNode >> typeOrNilFrom: aCodeGenerator in: aTMethod [
	<return: #RustTypedValue>

	^ (self definingClass classVarNamed: self name) asRustType
]
