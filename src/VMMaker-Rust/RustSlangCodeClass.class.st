Class {
	#name : #RustSlangCodeClass,
	#superclass : #VMClass,
	#category : #'VMMaker-Rust-Examples'
}

{ #category : #arithmetic }
RustSlangCodeClass >> arithmetic_127_plus_1 [
	^ 127 + 1
]

{ #category : #comparison }
RustSlangCodeClass >> integersLessThan [
	^ 5 < 10
]

{ #category : #arrays }
RustSlangCodeClass >> literalArrayOfIntegers [
	^ #(0 1 2 3 4 5)
]

{ #category : #abs }
RustSlangCodeClass >> positiveSmallIntegerAbs [
	^ 10 abs
]

{ #category : #return }
RustSlangCodeClass >> returnFalse [
	^ false
]

{ #category : #return }
RustSlangCodeClass >> returnMax32 [
	^ 2147483647
]

{ #category : #return }
RustSlangCodeClass >> returnMin32 [
	^ -2147483648
]

{ #category : #return }
RustSlangCodeClass >> returnNegativeOne [
	^ -1
]

{ #category : #return }
RustSlangCodeClass >> returnOne [
	^ 1
]

{ #category : #return }
RustSlangCodeClass >> returnString [
	^ 'Hello'
]

{ #category : #return }
RustSlangCodeClass >> returnTrue [
	^ true
]

{ #category : #return }
RustSlangCodeClass >> returnZero [
	^ 0
]

{ #category : #return }
RustSlangCodeClass >> returnZeroFloat [
	^ 0.0
]

{ #category : #self }
RustSlangCodeClass >> selfTrueOrFalse [
	^ self trueOrFalse
]

{ #category : #abs }
RustSlangCodeClass >> toDo [
	1 to: 10 do: [ :i | i + 1 ]
]

{ #category : #boolean }
RustSlangCodeClass >> trueAndFalse [
	^ true and: [ false ]
]

{ #category : #boolean }
RustSlangCodeClass >> trueOrFalse [
	^ true or: [ false ]
]

{ #category : #arithmetic }
RustSlangCodeClass >> zeroPlusZero [
	^ 0 + 0
]
