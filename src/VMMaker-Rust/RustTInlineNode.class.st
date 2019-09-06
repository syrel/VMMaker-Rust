Class {
	#name : #RustTInlineNode,
	#superclass : #RustTParseNode,
	#instVars : [
		'method'
	],
	#category : #'VMMaker-Rust'
}

{ #category : #transformations }
RustTInlineNode >> bindVariableUsesIn: aDictionary [
	method := method bindVariableUsesIn: aDictionary.

]

{ #category : #transformations }
RustTInlineNode >> bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen [
	"Answer either the receiver, if it contains no references to the given variables, or a new node with the given variables rebound."
	| newMethod |
	newMethod := method bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen.
	^newMethod = method
		ifTrue: [self]
		ifFalse: [self shallowCopy
					method: newMethod;
					yourself]
]

{ #category : #'C code generation' }
RustTInlineNode >> emitCCodeOn: aStream level: level generator: aCodeGen [
	method emitInlineOn: aStream level: level generator: aCodeGen.

]

{ #category : #testing }
RustTInlineNode >> isInline [
	^true
]

{ #category : #accessing }
RustTInlineNode >> method [
	^method
]

{ #category : #accessing }
RustTInlineNode >> method: aTMethod [
	method := aTMethod
]

{ #category : #enumerating }
RustTInlineNode >> nodesDo: aBlock [
	"Apply aBlock to all nodes in the receiver.
	 N.B. This is assumed to be bottom-up, leaves first."
	method parseTree nodesDo: aBlock.
	aBlock value: self
]

{ #category : #enumerating }
RustTInlineNode >> nodesDo: aBlock parent: parent [
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	method parseTree nodesDo: aBlock parent: self.
	aBlock value: self value: parent
]

{ #category : #enumerating }
RustTInlineNode >> nodesDo: aBlock parent: parent unless: cautionaryBlock [

	(cautionaryBlock value: self value: parent) ifTrue: [^self].
	method parseTree nodesDo: aBlock parent: self unless: cautionaryBlock.
	aBlock value: self value: parent
]

{ #category : #enumerating }
RustTInlineNode >> nodesDo: aBlock unless: cautionaryBlock [

	(cautionaryBlock value: self) ifTrue: [^self].
	method parseTree nodesDo: aBlock unless: cautionaryBlock.
	aBlock value: self.
]

{ #category : #copying }
RustTInlineNode >> postCopy [

	method := method copy
]

{ #category : #printing }
RustTInlineNode >> printOn: aStream level: anInteger [
	method parseTree printOn: aStream level: anInteger
]

{ #category : #transformations }
RustTInlineNode >> replaceNodesIn: map [
	^map at: self ifAbsent: [
		method replaceNodesIn: map.
		self]
]

{ #category : #inlining }
RustTInlineNode >> shouldExpand [
	^method extractExpandCaseDirective
]

{ #category : #'type inference' }
RustTInlineNode >> typeOrNilFrom: aCodeGenerator in: aTMethod [
	^method returnType
]
