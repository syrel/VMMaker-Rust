Class {
	#name : #RustExampleLocation,
	#superclass : #Object,
	#instVars : [
		'latitude',
		'longitude'
	],
	#classVars : [
		'RADIUS'
	],
	#category : #'VMMaker-Rust-Examples - Cities'
}

{ #category : #initialization }
RustExampleLocation class >> initialize [
	RADIUS := 1000
]

{ #category : #'as yet unclassified' }
RustExampleLocation class >> rustInstanceVariableDeclariation [
	^ {
		#latitude -> RustFloat64.
		#longitude -> RustFloat64
	}
]

{ #category : #converting }
RustExampleLocation >> asPoint [
	| x y point |
	
	x := self x.
	y := self y.

	point := RustExamplePoint new.
	point x: x.
	point y: y.
	
	^ point
]

{ #category : #accessing }
RustExampleLocation >> latitude [
	^ latitude
]

{ #category : #accessing }
RustExampleLocation >> latitude: anObject [
	latitude := anObject
]

{ #category : #accessing }
RustExampleLocation >> longitude [
	^ longitude
]

{ #category : #accessing }
RustExampleLocation >> longitude: anObject [
	longitude := anObject
]

{ #category : #geometry }
RustExampleLocation >> x [
	^ RADIUS * self longitude * self latitude cos
]

{ #category : #geometry }
RustExampleLocation >> y [
	^ RADIUS * self latitude
]
