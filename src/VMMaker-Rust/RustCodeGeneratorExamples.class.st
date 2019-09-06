Class {
	#name : #RustCodeGeneratorExamples,
	#superclass : #Object,
	#category : #'VMMaker-Rust-Examples'
}

{ #category : #'examples - abs' }
RustCodeGeneratorExamples >> code_positiveSmallIntegerAbs [
	<gtExample>
	| aCode |
	
	aCode := self generator cCodeForMethod: #positiveSmallIntegerAbs.
	
	^ aCode
]

{ #category : #'examples - abs' }
RustCodeGeneratorExamples >> code_returnTrue [
	<gtExample>
	| aCode |
		
	aCode := self generator cCodeForMethod: #returnTrue.
	
	^ aCode
]

{ #category : #'examples - abs' }
RustCodeGeneratorExamples >> code_toDo [
	<gtExample>
	| aCode |
	
	aCode := self generator cCodeForMethod: #toDo.
	
	^ aCode
]

{ #category : #'examples - abs' }
RustCodeGeneratorExamples >> code_trueAndFalse [
	<gtExample>
	| aCode |
	
	aCode := self generator cCodeForMethod: #trueAndFalse.
	
	^ aCode
]

{ #category : #'instance creation' }
RustCodeGeneratorExamples >> generator [
	<gtExample>
	
	CoInterpreter initializeWithOptions: Dictionary new.

	^ RustCodeGenerator new
		initialize
		vmClass: Cogit;
		addClass: RustSlangCodeClass;
		prepareMethods
]

{ #category : #'examples - abs' }
RustCodeGeneratorExamples >> method_positiveSmallIntegerAbs [
	<gtExample>
	| aRustMethod |
	
	aRustMethod := self generator methodNamed: #positiveSmallIntegerAbs.
	^ aRustMethod
]
