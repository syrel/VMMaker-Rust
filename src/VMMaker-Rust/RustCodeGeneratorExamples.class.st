Class {
	#name : #RustCodeGeneratorExamples,
	#superclass : #Object,
	#category : #'VMMaker-Rust-Examples'
}

{ #category : #'examples - arithmetic' }
RustCodeGeneratorExamples >> code_arithmetic_127_plus_1 [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #arithmetic_127_plus_1.
	self assert: aCode equals: '/* RustSlangCodeClass>>#arithmetic_127_plus_1 */
pub fn arithmetic_127_plus_1() -> i16 {
	return 0x7F + 1;
}'.

	^ aCode
]

{ #category : #'examples - abs' }
RustCodeGeneratorExamples >> code_positiveSmallIntegerAbs [
	<gtExample>
	| aCode |
	
	aCode := self generator cCodeForMethod: #positiveSmallIntegerAbs.
	
	^ aCode
]

{ #category : #'examples - return' }
RustCodeGeneratorExamples >> code_returnFalse [
	<gtExample>
	| aCode |
		
	aCode := self generator cCodeForMethod: #returnFalse.
	self assert: aCode equals: '/* RustSlangCodeClass>>#returnFalse */
pub fn return_false() -> bool {
	return false;
}'.

	^ aCode
]

{ #category : #'examples - return' }
RustCodeGeneratorExamples >> code_returnNegativeOne [
	<gtExample>
	| aCode |
		
	aCode := self generator cCodeForMethod: #returnNegativeOne.
	self assert: aCode equals: '/* RustSlangCodeClass>>#returnNegativeOne */
pub fn return_negative_one() -> i8 {
	return -1;
}'.

	^ aCode
]

{ #category : #'examples - return' }
RustCodeGeneratorExamples >> code_returnString [
	<gtExample>
	| aCode |
		
	aCode := self generator cCodeForMethod: #returnString.
	self assert: aCode equals: '/* RustSlangCodeClass>>#returnString */
pub fn return_string() -> String {
	return "Hello".to_string();
}'.
	
	^ aCode
]

{ #category : #'examples - return' }
RustCodeGeneratorExamples >> code_returnTrue [
	<gtExample>
	| aCode |
		
	aCode := self generator cCodeForMethod: #returnTrue.
	self assert: aCode equals: '/* RustSlangCodeClass>>#returnTrue */
pub fn return_true() -> bool {
	return true;
}'.

	^ aCode
]

{ #category : #'examples - return' }
RustCodeGeneratorExamples >> code_returnZero [
	<gtExample>
	| aCode |
		
	aCode := self generator cCodeForMethod: #returnZero.

	^ aCode
]

{ #category : #'examples - return' }
RustCodeGeneratorExamples >> code_returnZeroFloat [
	<gtExample>
	| aCode |
		
	aCode := self generator cCodeForMethod: #returnZeroFloat.

	^ aCode
]

{ #category : #'examples - abs' }
RustCodeGeneratorExamples >> code_toDo [
	<gtExample>
	| aCode |
	
	aCode := self generator cCodeForMethod: #toDo.
	
	^ aCode
]

{ #category : #'examples - boolean' }
RustCodeGeneratorExamples >> code_trueAndFalse [
	<gtExample>
	| aCode |
	
	aCode := self generator cCodeForMethod: #trueAndFalse.
	self assert: aCode equals: '/* RustSlangCodeClass>>#trueAndFalse */
pub fn true_and_false() -> bool {
	return false;
}'.
	
	^ aCode
]

{ #category : #'examples - boolean' }
RustCodeGeneratorExamples >> code_trueOrFalse [
	<gtExample>
	| aCode |
	
	aCode := self generator cCodeForMethod: #trueOrFalse.
	self assert: aCode equals: '/* RustSlangCodeClass>>#trueOrFalse */
pub fn true_or_false() -> bool {
	return true;
}'.

	^ aCode
]

{ #category : #'examples - arithmetic' }
RustCodeGeneratorExamples >> code_zeroPlusZero [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #zeroPlusZero.
	self assert: aCode equals: '/* RustSlangCodeClass>>#zeroPlusZero */
pub fn zero_plus_zero() -> i8 {
	return 0;
}'.

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
		inferTypesForImplicitlyTypedVariablesAndMethods;
		prepareMethods
]

{ #category : #'examples - abs' }
RustCodeGeneratorExamples >> method_positiveSmallIntegerAbs [
	<gtExample>
	| aRustMethod |
	
	aRustMethod := self generator methodNamed: #positiveSmallIntegerAbs.
	^ aRustMethod
]
