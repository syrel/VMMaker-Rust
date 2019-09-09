Class {
	#name : #RustConstant,
	#superclass : #RustVariable,
	#instVars : [
		'value'
	],
	#category : #'VMMaker-Rust-Meta'
}

{ #category : #accessing }
RustConstant >> value [
	^ value
]

{ #category : #accessing }
RustConstant >> value: anObject [
	value := anObject
]
