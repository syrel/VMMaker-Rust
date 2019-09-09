Class {
	#name : #RustInstanceVariableReferenceNode,
	#superclass : #RustTVariableNode,
	#category : #'VMMaker-Rust-Nodes'
}

{ #category : #'C code generation' }
RustInstanceVariableReferenceNode >> emitCCodeOn: aStream level: level generator: aCodeGen [
	aStream nextPutAll: 'self.'.
	aStream nextPutAll: (aCodeGen returnPrefixFromVariable: name).

	aCodeGen currentMethod ifNotNil: [ :m | m noteUsedVariableName: name ]
]
