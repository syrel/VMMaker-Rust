Class {
	#name : #RustSlangTypeInferenceSimpleExamples,
	#superclass : #VMClass,
	#category : #'VMMaker-Rust-Examples'
}

{ #category : #'instance creation' }
RustSlangTypeInferenceSimpleExamples >> basicGenerator [
	<gtExample>

	^ RustCodeGenerator new
		initialize
		vmClass: Cogit;
		addClass: RustSlangTypeInferenceSimple
]

{ #category : #'examples - return' }
RustSlangTypeInferenceSimpleExamples >> code_returnsConstant [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #returnsConstant.
	self assert: aCode equals: '/* RustSlangTypeInferenceSimple>>#returnsConstant */
pub fn returns_constant() -> i8 {
	return 42;
}'.

	^ aCode
]

{ #category : #'examples - return' }
RustSlangTypeInferenceSimpleExamples >> code_returnsResultOfFalseCondition [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #returnsResultOfFalseCondition.
	self assert: aCode equals: '/* RustSlangTypeInferenceSimple>>#returnsResultOfFalseCondition */
pub fn returns_result_of_false_condition() -> Option<i8> {
	return (returns_constant()) * 2;
}'.

	^ aCode
]

{ #category : #'examples - return' }
RustSlangTypeInferenceSimpleExamples >> code_returnsResultOfFalseCondition_plus_5 [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #returnsResultOfFalseCondition_plus_5.

	^ aCode
]

{ #category : #'examples - return' }
RustSlangTypeInferenceSimpleExamples >> code_returnsResultOfTrueCondition [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #returnsResultOfTrueCondition.
	self assert: aCode equals: '/* RustSlangTypeInferenceSimple>>#returnsResultOfTrueCondition */
pub fn returns_result_of_true_condition() -> Option<i8> {
	return None;
}'.

	^ aCode
]

{ #category : #'examples - return' }
RustSlangTypeInferenceSimpleExamples >> code_returnsResultOfTrueFalseCondition [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #returnsResultOfTrueFalseCondition.
	self assert: aCode equals: '/* RustSlangTypeInferenceSimple>>#returnsResultOfTrueFalseCondition */
pub fn returns_result_of_true_false_condition() -> i8 {
	return returns_constant();
}'.

	^ aCode
]

{ #category : #'instance creation' }
RustSlangTypeInferenceSimpleExamples >> generator [
	<gtExample>

	^ self basicGenerator
		inferTypesForImplicitlyTypedVariablesAndMethods;
		prepareMethods
]

{ #category : #'type inference' }
RustSlangTypeInferenceSimpleExamples >> method_returnsConstant [
	<gtExample>
	| aGenerator aMethod |

	aGenerator := self basicGenerator.
	aMethod := aGenerator methodNamed: #returnsConstant.

	"before inference is nil"
	self assert: aMethod returnType isNil.

	aGenerator inferReturnTypeForSimpleMethod: aMethod.

	self assert: aMethod returnType equals: (RustInt8 value: 42).

	^ aMethod
]

{ #category : #'type inference' }
RustSlangTypeInferenceSimpleExamples >> method_returnsResultOfTrueCondition [
	<gtExample>
	| aGenerator aMethod |

	aGenerator := self basicGenerator.
	aMethod := aGenerator methodNamed: #returnsResultOfTrueCondition.

	"before inference is nil"
	self assert: aMethod returnType isNil.

	"this is not a simple method. direct type inference failed"
	aGenerator inferReturnTypeForSimpleMethod: aMethod.

	self assert: aMethod returnType isNil.

	^ aMethod
]
