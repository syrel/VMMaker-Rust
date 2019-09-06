Class {
	#name : #RustSlangCodeClass,
	#superclass : #VMClass,
	#category : #'VMMaker-Rust-Examples'
}

{ #category : #abs }
RustSlangCodeClass >> positiveSmallIntegerAbs [
	^ 10 abs
]

{ #category : #abs }
RustSlangCodeClass >> returnFalse [
	^ false
]

{ #category : #abs }
RustSlangCodeClass >> returnTrue [
	<returnTypeC: #bool>

	^ true
]

{ #category : #abs }
RustSlangCodeClass >> toDo [
	1 to: 10 do: [ :i | i + 1 ]
]

{ #category : #abs }
RustSlangCodeClass >> trueAndFalse [
	^ true and: [ false ]
]
