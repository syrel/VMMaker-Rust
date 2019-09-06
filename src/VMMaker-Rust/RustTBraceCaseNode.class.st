Class {
	#name : #RustTBraceCaseNode,
	#superclass : #RustTParseNode,
	#instVars : [
		'caseLabels',
		'cases'
	],
	#category : #'VMMaker-Rust-Nodes'
}

{ #category : #transformations }
RustTBraceCaseNode >> bindVariableUsesIn: aDictionary [

	caseLabels := caseLabels collect: [:node| node bindVariableUsesIn: aDictionary].
	cases := cases collect: [:node| node bindVariableUsesIn: aDictionary]
]

{ #category : #transformations }
RustTBraceCaseNode >> bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen [
	"Answer either the receiver, if it contains no references to the given variables, or a new node with the given variables rebound."
	| newCaseLabels newCases |
	newCaseLabels := caseLabels collect: [:node| node bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen].
	newCases := cases collect: [:node| node bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen].
	^(newCaseLabels = caseLabels
	   and: [newCases = cases])
		ifTrue: [self]
		ifFalse: [self shallowCopy
					caseLabels: newCaseLabels;
					cases: newCases;
					yourself]
]

{ #category : #transformations }
RustTBraceCaseNode >> bindVariablesIn: aDictionary [

	caseLabels := caseLabels collect: [:node| node bindVariablesIn: aDictionary].
	cases := cases collect: [:node| node bindVariablesIn: aDictionary]
]

{ #category : #accessing }
RustTBraceCaseNode >> caseLabels [
	"Answer the value of caseLabels"

	^ caseLabels
]

{ #category : #accessing }
RustTBraceCaseNode >> caseLabels: anObject [
	"Set the value of caseLabels"

	caseLabels := anObject
]

{ #category : #accessing }
RustTBraceCaseNode >> cases [
	"Answer the value of cases"

	^ cases
]

{ #category : #accessing }
RustTBraceCaseNode >> cases: anObject [
	"Set the value of cases"

	cases := anObject
]

{ #category : #enumerating }
RustTBraceCaseNode >> nodesDo: aBlock [
	"Apply aBlock to all nodes in the receiver.
	 N.B. This is assumed to be bottom-up, leaves first."
	caseLabels do:
		[:node| node nodesDo: aBlock].
	cases do:
		[:node| node nodesDo: aBlock].
	aBlock value: self
]

{ #category : #enumerating }
RustTBraceCaseNode >> nodesDo: aBlock parent: parent [
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	caseLabels do:
		[:node| node nodesDo: aBlock parent: self.].
	cases do:
		[:node| node nodesDo: aBlock parent: self].
	aBlock value: self value: parent
]

{ #category : #enumerating }
RustTBraceCaseNode >> nodesDo: aBlock parent: parent unless: cautionaryBlock [

	(cautionaryBlock value: self value: parent) ifTrue: [^self].
	caseLabels do:
		[:node| node nodesDo: aBlock parent: self unless: cautionaryBlock].
	cases do:
		[:node| node nodesDo: aBlock parent: self unless: cautionaryBlock].
	aBlock value: self value: parent
]

{ #category : #enumerating }
RustTBraceCaseNode >> nodesDo: aBlock unless: cautionaryBlock [

	(cautionaryBlock value: self) ifTrue: [^self].
	caseLabels do:
		[:node| node nodesDo: aBlock unless: cautionaryBlock].
	cases do:
		[:node| node nodesDo: aBlock unless: cautionaryBlock].
	aBlock value: self
]

{ #category : #enumerating }
RustTBraceCaseNode >> replaceNodesIn: aDictionary [

	^aDictionary at: self ifAbsent: [
		caseLabels := caseLabels collect: [:node| node replaceNodesIn: aDictionary].
		cases := cases collect: [:node| node replaceNodesIn: aDictionary].
		self]
]

{ #category : #'type inference' }
RustTBraceCaseNode >> typeOrNilFrom: aCodeGenerator in: aTMethod [
	| types |
	types := Set withAll: (cases collect: [:case| case typeOrNilFrom: aCodeGenerator in: aTMethod]).
	^types size = 1 ifTrue: [types anyOne]
]
