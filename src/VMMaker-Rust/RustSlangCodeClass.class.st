Class {
	#name : #RustSlangCodeClass,
	#superclass : #VMClass,
	#instVars : [
		'question'
	],
	#classVars : [
		'TheAnswer'
	],
	#category : #'VMMaker-Rust-Examples'
}

{ #category : #translation }
RustSlangCodeClass class >> implicitReturnTypeFor: aSelector [
	"Answer the return type for methods that don't have an explicit return."
	^ RustVoid new
]

{ #category : #initialization }
RustSlangCodeClass class >> initialize [
	
	TheAnswer := 42
]

{ #category : #'arithmetic - plus' }
RustSlangCodeClass >> arithmetic_0_plus_0 [
	^ 0 + 0
]

{ #category : #'arithmetic - multiply' }
RustSlangCodeClass >> arithmetic_127_multiply_1 [
	^ 127 * 1
]

{ #category : #'arithmetic - multiply' }
RustSlangCodeClass >> arithmetic_127_multiply_127 [
	^ 127 * 127
]

{ #category : #'arithmetic - multiply' }
RustSlangCodeClass >> arithmetic_127_multiply_127f32 [
	^ 127 * 127.0
]

{ #category : #'arithmetic - plus' }
RustSlangCodeClass >> arithmetic_127_plus_1 [
	^ 127 + 1
]

{ #category : #'arithmetic - plus' }
RustSlangCodeClass >> arithmetic_127_plus_127 [
	^ 127 + 127
]

{ #category : #'arithmetic - plus' }
RustSlangCodeClass >> arithmetic_127_plus_127f32 [
	^ 127 + 127.0
]

{ #category : #'arithmetic - multiply' }
RustSlangCodeClass >> arithmetic_127f32_multiply_127 [
	^ 127.0 * 127
]

{ #category : #'arithmetic - multiply' }
RustSlangCodeClass >> arithmetic_127f32_multiply_127f32 [
	^ 127.0 * 127.0
]

{ #category : #'arithmetic - plus' }
RustSlangCodeClass >> arithmetic_127f32_plus_127 [
	^ 127.0 + 127
]

{ #category : #'arithmetic - plus' }
RustSlangCodeClass >> arithmetic_127f32_plus_127f32 [
	^ 127.0 + 127.0
]

{ #category : #'arithmetic - minus' }
RustSlangCodeClass >> arithmetic_128_minus_1 [
	^ 128 - 1
]

{ #category : #'arithmetic - minus' }
RustSlangCodeClass >> arithmetic_128_minus_1f32 [
	^ 128 - 1.0
]

{ #category : #'arithmetic - minus' }
RustSlangCodeClass >> arithmetic_128f32_minus_1 [
	^ 128.0 - 1
]

{ #category : #'arithmetic - minus' }
RustSlangCodeClass >> arithmetic_128f32_minus_1f32 [
	^ 128.0 - 1.0
]

{ #category : #'arithmetic - minus' }
RustSlangCodeClass >> arithmetic_1_minus_1 [
	^ 1 - 1
]

{ #category : #'arithmetic - minus' }
RustSlangCodeClass >> arithmetic_negated128_minus_128 [
	^ -128 - 128
]

{ #category : #conditionals }
RustSlangCodeClass >> equal_ifTrue_return_10 [
	^ 5 = 10 ifTrue: [ 10 ]
]

{ #category : #conditionals }
RustSlangCodeClass >> ifFalse [
	^ false ifFalse: [ false ]
]

{ #category : #conditionals }
RustSlangCodeClass >> ifTrue [
	^ true ifTrue: [ true ]
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
RustSlangCodeClass >> returnNil [
	^ nil
]

{ #category : #return }
RustSlangCodeClass >> returnOne [
	^ 1
]

{ #category : #return }
RustSlangCodeClass >> returnSelf [
	^ self
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

{ #category : #return }
RustSlangCodeClass >> returnsConstant [
	^ 42
]

{ #category : #self }
RustSlangCodeClass >> selfTrueOrFalse [
	^ self trueOrFalse
]

{ #category : #conditionals }
RustSlangCodeClass >> self_trueAndFalse_ifTrue_return_10 [
	^ self trueAndFalse
		ifTrue: [ 10 ]
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
