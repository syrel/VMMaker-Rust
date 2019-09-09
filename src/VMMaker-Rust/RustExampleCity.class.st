Class {
	#name : #RustExampleCity,
	#superclass : #Object,
	#instVars : [
		'name',
		'population',
		'location'
	],
	#category : #'VMMaker-Rust-Examples - Cities'
}

{ #category : #'as yet unclassified' }
RustExampleCity class >> rustInstanceVariableDeclariation [
	^ {
		#name -> RustString.
		#population -> RustInt64.
		#location -> RustExampleLocation
	}
]

{ #category : #accessing }
RustExampleCity >> location [
	^ location
]

{ #category : #accessing }
RustExampleCity >> name [
	^ name
]

{ #category : #accessing }
RustExampleCity >> population [
	^ population
]
