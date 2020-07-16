Class {
	#name : #RustExamplePoint,
	#superclass : #Object,
	#instVars : [
		'x',
		'y'
	],
	#category : #'VMMaker-Rust-Examples - Cities'
}

{ #category : #'as yet unclassified' }
RustExamplePoint class >> rustInstanceVariableDeclariation [
	^ {
		#x -> RustFloat64.
		#y -> RustFloat64
	}
]

{ #category : #initialization }
RustExamplePoint >> initialize [
	super initialize.
	
	x := 0.
	y := 0.
]

{ #category : #accessing }
RustExamplePoint >> x [
	^ x
]

{ #category : #accessing }
RustExamplePoint >> x: anObject [
	x := anObject
]

{ #category : #accessing }
RustExamplePoint >> y [
	^ y
]

{ #category : #accessing }
RustExamplePoint >> y: anObject [
	y := anObject
]
