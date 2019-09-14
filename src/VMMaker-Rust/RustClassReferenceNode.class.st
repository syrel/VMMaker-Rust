Class {
	#name : #RustClassReferenceNode,
	#superclass : #RustTVariableNode,
	#instVars : [
		'referencedClass'
	],
	#category : #'VMMaker-Rust-Nodes'
}

{ #category : #testing }
RustClassReferenceNode >> isClassReference [
	^ true
]

{ #category : #accessing }
RustClassReferenceNode >> referencedClass [
	<return: #Class>

	^ referencedClass
]

{ #category : #accessing }
RustClassReferenceNode >> referencedClass: aClass [
	referencedClass := aClass
]

{ #category : #'type inference' }
RustClassReferenceNode >> typeOrNilFrom: aCodeGenerator in: aTMethod [
	<return: #RustTypedValue>

	^ self referencedClass asRustType
]
