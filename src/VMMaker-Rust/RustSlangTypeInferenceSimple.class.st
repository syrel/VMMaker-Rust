Class {
	#name : #RustSlangTypeInferenceSimple,
	#superclass : #VMClass,
	#category : #'VMMaker-Rust-Examples'
}

{ #category : #methods }
RustSlangTypeInferenceSimple >> returnsConstant [
	^ 42
]

{ #category : #conditionals }
RustSlangTypeInferenceSimple >> returnsResultOfFalseCondition [
	^ self returnsConstant = 0
		ifFalse: [ self returnsConstant * 2 ]
]

{ #category : #conditionals }
RustSlangTypeInferenceSimple >> returnsResultOfFalseCondition_plus_5 [
	^ self returnsResultOfFalseCondition + 5
]

{ #category : #conditionals }
RustSlangTypeInferenceSimple >> returnsResultOfTrueCondition [
	^ self returnsConstant = 0
		ifTrue: [ self returnsConstant * 2 ]
]

{ #category : #conditionals }
RustSlangTypeInferenceSimple >> returnsResultOfTrueFalseCondition [
	^ self returnsConstant = 0
		ifTrue: [ self returnsConstant * 2 ]
		ifFalse: [ self returnsConstant ]
]
