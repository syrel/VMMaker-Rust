Class {
	#name : #RustTVariableNode,
	#superclass : #RustTParseNode,
	#instVars : [
		'name'
	],
	#category : #'VMMaker-Rust'
}

{ #category : #transformations }
RustTVariableNode >> bindVariableUsesIn: aDictionary [

	^ (aDictionary at: name ifAbsent: [^ self]) copy
]

{ #category : #transformations }
RustTVariableNode >> bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen [
	"Answer either the receiver, if it is not a reference to one of the given variables, or the replacement if it is."
	^(aDictionary at: name ifAbsent: [^self]) copy
]

{ #category : #transformations }
RustTVariableNode >> bindVariablesIn: aDictionary [ 
	^ (aDictionary at: name ifAbsent: [^ self]) copy
]

{ #category : #'C code generation' }
RustTVariableNode >> emitCCodeOn: aStream level: level generator: aCodeGen [

	aStream nextPutAll: (name = 'nil'
						ifTrue: [aCodeGen cLiteralFor: nil]
						ifFalse: [aCodeGen returnPrefixFromVariable: name]).
	aCodeGen currentMethod ifNotNil:
		[:m| m noteUsedVariableName: name]
]

{ #category : #testing }
RustTVariableNode >> hasSideEffect [
	"Answer if the parse tree rooted at this node has a side-effect or not."
	^false
]

{ #category : #testing }
RustTVariableNode >> isLeaf [

	^true
]

{ #category : #comparing }
RustTVariableNode >> isSameAs: aTParseNode [
	^aTParseNode isVariable
	 and: [name = aTParseNode name]
]

{ #category : #testing }
RustTVariableNode >> isVariable [

	^true
]

{ #category : #accessing }
RustTVariableNode >> name [

	^name asString
]

{ #category : #accessing }
RustTVariableNode >> nameOrValue [

	^name
]

{ #category : #enumerating }
RustTVariableNode >> nodesDo: aBlock parent: parent [
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	aBlock value: self value: parent
]

{ #category : #printing }
RustTVariableNode >> printOn: aStream level: level [

	aStream nextPutAll: name.
]

{ #category : #accessing }
RustTVariableNode >> setName: aString [

	name := aString.
]

{ #category : #testing }
RustTVariableNode >> structTargetKindIn: aCodeGen [
	"Answer if the recever evaluates to a struct or struct pointer
	 and hence can be dereferenced using . or ->.  Answer any of
	 #struct #pointer or nil"
	^aCodeGen structTargetKindForVariableName: name
]

{ #category : #'type inference' }
RustTVariableNode >> typeOrNilFrom: aCodeGenerator in: aTMethod [
	^aTMethod typeFor: self in: aCodeGenerator
]

{ #category : #accessing }
RustTVariableNode >> variableNameOrNil [
	^name
]
