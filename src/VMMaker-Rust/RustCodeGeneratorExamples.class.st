Class {
	#name : #RustCodeGeneratorExamples,
	#superclass : #Object,
	#category : #'VMMaker-Rust-Examples'
}

{ #category : #'examples - arithmetic plus' }
RustCodeGeneratorExamples >> code_arithmetic_0_plus_0 [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #arithmetic_0_plus_0.
	self assert: aCode equals: '/* RustSlangCodeClass>>#arithmetic_0_plus_0 */
pub fn arithmetic_0_plus_0(&self) -> i8 {
	return 0;
}'.

	^ aCode
]

{ #category : #'examples - arithmetic multiply' }
RustCodeGeneratorExamples >> code_arithmetic_127_multiply_1 [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #arithmetic_127_multiply_1.
	self assert: aCode equals: '/* RustSlangCodeClass>>#arithmetic_127_multiply_1 */
pub fn arithmetic_127_multiply_1(&self) -> i8 {
	return 127;
}'.

	^ aCode
]

{ #category : #'examples - arithmetic multiply' }
RustCodeGeneratorExamples >> code_arithmetic_127_multiply_127 [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #arithmetic_127_multiply_127.
	self assert: aCode equals: '/* RustSlangCodeClass>>#arithmetic_127_multiply_127 */
pub fn arithmetic_127_multiply_127(&self) -> i16 {
	return 127 * 127;
}'.

	^ aCode
]

{ #category : #'examples - arithmetic multiply' }
RustCodeGeneratorExamples >> code_arithmetic_127_multiply_127f32 [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #arithmetic_127_multiply_127f32.
	self assert: aCode equals: '/* RustSlangCodeClass>>#arithmetic_127_multiply_127f32 */
pub fn arithmetic_127_multiply_127f32(&self) -> f32 {
	return 127 as f32 * 127.0;
}'.

	^ aCode
]

{ #category : #'examples - arithmetic plus' }
RustCodeGeneratorExamples >> code_arithmetic_127_plus_1 [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #arithmetic_127_plus_1.
	self assert: aCode equals: '/* RustSlangCodeClass>>#arithmetic_127_plus_1 */
pub fn arithmetic_127_plus_1(&self) -> i16 {
	return 127 + 1;
}'.

	^ aCode
]

{ #category : #'examples - arithmetic plus' }
RustCodeGeneratorExamples >> code_arithmetic_127_plus_127 [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #arithmetic_127_plus_127.
	self assert: aCode equals: '/* RustSlangCodeClass>>#arithmetic_127_plus_127 */
pub fn arithmetic_127_plus_127(&self) -> i16 {
	return 127 + 127;
}'.

	^ aCode
]

{ #category : #'examples - arithmetic plus' }
RustCodeGeneratorExamples >> code_arithmetic_127_plus_127f32 [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #arithmetic_127_plus_127f32.
	self assert: aCode equals: '/* RustSlangCodeClass>>#arithmetic_127_plus_127f32 */
pub fn arithmetic_127_plus_127f32(&self) -> f32 {
	return 127 as f32 + 127.0;
}'.

	^ aCode
]

{ #category : #'examples - arithmetic multiply' }
RustCodeGeneratorExamples >> code_arithmetic_127f32_multiply_127 [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #arithmetic_127f32_multiply_127.
	self assert: aCode equals: '/* RustSlangCodeClass>>#arithmetic_127f32_multiply_127 */
pub fn arithmetic_127f32_multiply_127(&self) -> f32 {
	return 127.0 * 127 as f32;
}'.

	^ aCode
]

{ #category : #'examples - arithmetic multiply' }
RustCodeGeneratorExamples >> code_arithmetic_127f32_multiply_127f32 [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #arithmetic_127f32_multiply_127f32.
	self assert: aCode equals: '/* RustSlangCodeClass>>#arithmetic_127f32_multiply_127f32 */
pub fn arithmetic_127f32_multiply_127f32(&self) -> f32 {
	return 127.0 * 127.0;
}'.

	^ aCode
]

{ #category : #'examples - arithmetic plus' }
RustCodeGeneratorExamples >> code_arithmetic_127f32_plus_127 [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #arithmetic_127f32_plus_127.
	self assert: aCode equals: '/* RustSlangCodeClass>>#arithmetic_127f32_plus_127 */
pub fn arithmetic_127f32_plus_127(&self) -> f32 {
	return 127.0 + 127 as f32;
}'.

	^ aCode
]

{ #category : #'examples - arithmetic plus' }
RustCodeGeneratorExamples >> code_arithmetic_127f32_plus_127f32 [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #arithmetic_127f32_plus_127f32.
	self assert: aCode equals: '/* RustSlangCodeClass>>#arithmetic_127f32_plus_127f32 */
pub fn arithmetic_127f32_plus_127f32(&self) -> f32 {
	return 127.0 + 127.0;
}'.

	^ aCode
]

{ #category : #'examples - arithmetic minus' }
RustCodeGeneratorExamples >> code_arithmetic_128_minus_1 [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #arithmetic_128_minus_1.
	self assert: aCode equals: '/* RustSlangCodeClass>>#arithmetic_128_minus_1 */
pub fn arithmetic_128_minus_1(&self) -> i16 {
	return 128 - 1 as i16;
}'.

	^ aCode
]

{ #category : #'examples - arithmetic minus' }
RustCodeGeneratorExamples >> code_arithmetic_128_minus_1f32 [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #arithmetic_128_minus_1f32.
	self assert: aCode equals: '/* RustSlangCodeClass>>#arithmetic_128_minus_1f32 */
pub fn arithmetic_128_minus_1f32(&self) -> f32 {
	return 128 as f32 - 1.0;
}'.

	^ aCode
]

{ #category : #'examples - arithmetic minus' }
RustCodeGeneratorExamples >> code_arithmetic_128f32_minus_1 [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #arithmetic_128f32_minus_1.
	self assert: aCode equals: '/* RustSlangCodeClass>>#arithmetic_128f32_minus_1 */
pub fn arithmetic_128f32_minus_1(&self) -> f32 {
	return 128.0 - 1 as f32;
}'.

	^ aCode
]

{ #category : #'examples - arithmetic minus' }
RustCodeGeneratorExamples >> code_arithmetic_128f32_minus_1f32 [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #arithmetic_128f32_minus_1f32.
	self assert: aCode equals: '/* RustSlangCodeClass>>#arithmetic_128f32_minus_1f32 */
pub fn arithmetic_128f32_minus_1f32(&self) -> f32 {
	return 128.0 - 1.0;
}'.

	^ aCode
]

{ #category : #'examples - arithmetic minus' }
RustCodeGeneratorExamples >> code_arithmetic_1_minus_1 [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #arithmetic_1_minus_1.
	self assert: aCode equals: '/* RustSlangCodeClass>>#arithmetic_1_minus_1 */
pub fn arithmetic_1_minus_1(&self) -> i8 {
	return 1 - 1;
}'.

	^ aCode
]

{ #category : #'examples - arithmetic minus' }
RustCodeGeneratorExamples >> code_arithmetic_negated128_minus_128 [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #arithmetic_negated128_minus_128.
	self assert: aCode equals: '/* RustSlangCodeClass>>#arithmetic_negated128_minus_128 */
pub fn arithmetic_negated128_minus_128(&self) -> i16 {
	return -128 as i16 - 128;
}'.

	^ aCode
]

{ #category : #'examples - conditionals' }
RustCodeGeneratorExamples >> code_equal_ifTrue_return_10 [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #equal_ifTrue_return_10.

	^ aCode
]

{ #category : #'examples - conditionals' }
RustCodeGeneratorExamples >> code_ifFalse [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #ifFalse.
	self assert: aCode equals: '/* RustSlangCodeClass>>#ifFalse */
pub fn if_false(&self) -> Option<bool> {
	return false;
}'.

	^ aCode
]

{ #category : #'examples - conditionals' }
RustCodeGeneratorExamples >> code_ifTrue [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #ifTrue.
	self assert: aCode equals: '/* RustSlangCodeClass>>#ifTrue */
pub fn if_true(&self) -> Option<bool> {
	return true;
}'.

	^ aCode
]

{ #category : #'examples - comparison' }
RustCodeGeneratorExamples >> code_integersLessThan [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #integersLessThan.
	self assert: aCode equals: '/* RustSlangCodeClass>>#integersLessThan */
pub fn integers_less_than(&self) -> bool {
	return 5 < 10;
}'.

	^ aCode
]

{ #category : #'examples - arrays' }
RustCodeGeneratorExamples >> code_literalArrayOfIntegers [
	<gtExample>
	| aCode |
	
	aCode := self generator cCodeForMethod: #literalArrayOfIntegers.
	self assert: aCode equals: '/* RustSlangCodeClass>>#literalArrayOfIntegers */
pub fn literal_array_of_integers(&self) -> [i8; 6] {
	return [0, 1, 2, 3, 4, 5];
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
pub fn return_false(&self) -> bool {
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
pub fn return_negative_one(&self) -> i8 {
	return -1;
}'.

	^ aCode
]

{ #category : #'examples - return' }
RustCodeGeneratorExamples >> code_returnNew [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #returnNew.

	^ aCode
]

{ #category : #'examples - return' }
RustCodeGeneratorExamples >> code_returnNil [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #returnNil.
	self assert: aCode equals: '/* RustSlangCodeClass>>#returnNil */
pub fn return_nil(&self) {
	return /* nil */;
}'.

	^ aCode
]

{ #category : #'examples - return' }
RustCodeGeneratorExamples >> code_returnSelf [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #returnSelf.
	self assert: aCode equals: '/* RustSlangCodeClass>>#returnSelf */
pub fn return_self(&self) {
}'.

	^ aCode
]

{ #category : #'examples - return' }
RustCodeGeneratorExamples >> code_returnString [
	<gtExample>
	| aCode |
		
	aCode := self generator cCodeForMethod: #returnString.
	self assert: aCode equals: '/* RustSlangCodeClass>>#returnString */
pub fn return_string(&self) -> String {
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
pub fn return_true(&self) -> bool {
	return true;
}'.

	^ aCode
]

{ #category : #'examples - return' }
RustCodeGeneratorExamples >> code_returnZero [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #returnZero.
	self assert: aCode equals: '/* RustSlangCodeClass>>#returnZero */
pub fn return_zero(&self) -> i8 {
	return 0;
}'.

	^ aCode
]

{ #category : #'examples - return' }
RustCodeGeneratorExamples >> code_returnZeroFloat [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #returnZeroFloat.
	self assert: aCode equals: '/* RustSlangCodeClass>>#returnZeroFloat */
pub fn return_zero_float(&self) -> f32 {
	return 0.0;
}'.

	^ aCode
]

{ #category : #'examples - self' }
RustCodeGeneratorExamples >> code_selfTrueOrFalse [
	<gtExample>
	| aCode |
	
	aCode := self generator cCodeForMethod: #selfTrueOrFalse.
	self assert: aCode equals: '/* RustSlangCodeClass>>#selfTrueOrFalse */
pub fn self_true_or_false(&self) -> bool {
	return self.true_or_false();
}'.

	^ aCode
]

{ #category : #'examples - conditionals' }
RustCodeGeneratorExamples >> code_self_trueAndFalse_ifTrue_return_10 [
	<gtExample>
	| aCode |

	aCode := self generator cCodeForMethod: #self_trueAndFalse_ifTrue_return_10.

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
pub fn true_and_false(&self) -> bool {
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
pub fn true_or_false(&self) -> bool {
	return true;
}'.

	^ aCode
]

{ #category : #'instance creation' }
RustCodeGeneratorExamples >> generator [
	<gtExample>
	
	^ RustCodeGenerator new
		initialize
		vmClass: Cogit;
		addClass: RustSlangCodeClass;
		addClassVarsFor: RustSlangCodeClass;
		inferTypesForImplicitlyTypedVariablesAndMethods;
		prepareMethods
]

{ #category : #'examples - abs' }
RustCodeGeneratorExamples >> method_positiveSmallIntegerAbs [
	<gtExample>
	| aGenerator aRustMethod |
	
	aGenerator := self generator.
	aRustMethod := aGenerator methodNamed: #positiveSmallIntegerAbs.
	self assert: (aGenerator shouldGenerateMethod: aRustMethod).
	
	
	^ aRustMethod
]
