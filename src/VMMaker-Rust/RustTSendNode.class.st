Class {
	#name : #RustTSendNode,
	#superclass : #RustTParseNode,
	#instVars : [
		'selector',
		'receiver',
		'arguments',
		'isBuiltinOperator'
	],
	#category : #'VMMaker-Rust-Nodes'
}

{ #category : #accessing }
RustTSendNode >> args [

	^arguments
]

{ #category : #private }
RustTSendNode >> arguments: aSequence [
	arguments := aSequence
]

{ #category : #'inlining support' }
RustTSendNode >> argumentsForInliningCodeGenerator: aCodeGen [
	^(self shouldIncludeReceiverAsFirstArgument: aCodeGen)
		ifTrue: [{receiver}, arguments]
		ifFalse: [arguments]
]

{ #category : #converting }
RustTSendNode >> asTransformedConstantPerform [
	"If the receiver is a send of perform: with a constant selector,
	 answer a send node that elides the perform:, otherwise answer nil."
	^(selector isSymbol
	  and: [(selector beginsWith: #perform:)
	  and: [(selector keywords allSatisfy: [:kw| #('perform:' 'with:') includes: kw])
	  and: [arguments first isConstant
	  and: [arguments first value isSymbol
	  and: [arguments first value numArgs + 1 = arguments size]]]]]) ifTrue:
		[RustTSendNode new
			setSelector: arguments first value
			receiver: receiver
			arguments: arguments allButFirst]
]

{ #category : #transformations }
RustTSendNode >> bindVariableUsesIn: aDictionary [

	receiver := receiver bindVariableUsesIn: aDictionary.
	arguments := arguments collect: [ :a | a bindVariableUsesIn: aDictionary ].
]

{ #category : #transformations }
RustTSendNode >> bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen [
	"Answer either the receiver, if it contains no references to the given variables, or a new node with the given variables rebound.
	 Attempt to constant-fold and answer a constant node commented with the original expression.
	 Commenting with the original expression is important because it allows us to detect shared cases.
	 e.g. currentBytecode bitAnd: 15 is the same in case 1 and case 17, but '1 /* 1 bitAnd: 15 */' differs
	 from '1 /* 17 bitAnd: 15 */', whereas '1 /* currentBytecode bitAnd: 15 */' doesn't change."
	| newReceiver newArguments |
	"Constant-fold shiftForWord, but not BytesPerWord"
	((VMBasicConstants mostBasicConstantSelectors includes: selector)
	 and: [(codeGen isBuiltinSelector: selector) not]) ifTrue:
		[codeGen isConstantNode: self valueInto:
			[:val|
			 ^RustTConstantNode new
				setValue: val;
				yourself]].
	newReceiver := receiver bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen.
	newArguments := arguments collect: [:a| a bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen].
	(newReceiver = receiver
	 and: [newArguments = arguments]) ifTrue:
		[^self].
	(constantFold
	 and: [newReceiver isConstant and: [newReceiver value isInteger
	 and: [(newArguments allSatisfy: [:ea| ea isConstant and: [ea value isInteger]])
	 and: [codeGen isBuiltinSelector: selector]]]]) ifTrue:
		[| value |
		value := [newReceiver value perform: selector withArguments: (newArguments collect: [:ea| ea value])]
					on: Error
					do: [:ea| nil].
		 (value isInteger
		 or: [value == true
		 or: [value == false]]) ifTrue:
			[^RustTConstantNode new
				setValue: value;
				"We assume Message prints its keywords and arguments interleaved.
				 e.g. that (Message selector: #between:and: arguments: #(0 1)) printString = 'between: 0 and: 1'"
				comment: (receiver isLeaf
								ifTrue: [receiver printString]
								ifFalse: ['(', receiver printString, ')']),
							' ',
							(Message selector: selector arguments: (arguments collect: [:ea| ea value])) printString;
				yourself]].
	^self shallowCopy
		receiver: newReceiver;
		arguments: newArguments;
		yourself
		
]

{ #category : #transformations }
RustTSendNode >> bindVariablesIn: aDictionary [

	receiver := receiver bindVariablesIn: aDictionary.
	arguments := arguments collect: [ :a | a bindVariablesIn: aDictionary ].
]

{ #category : #accessing }
RustTSendNode >> constantNumbericValueIfAtAllPossibleOrNilIn: aCCodeGen [
	"This is a version of constantNumbericValueOrNil for type checking rather than code generation.
	 It aims to yield a value if at all possible."
	(#(* // + - << >> bitAnd: bitOr: bitShift:) includes: selector) ifTrue:
		[(receiver constantNumbericValueIfAtAllPossibleOrNilIn: aCCodeGen) ifNotNil:
			[:rval|
			(arguments first constantNumbericValueIfAtAllPossibleOrNilIn: aCCodeGen) ifNotNil:
				[:aval|
				^rval perform: selector with: aval]]].
	^(aCCodeGen anyMethodNamed: selector) ifNotNil:
		[:m|
		 m isReturnConstant ifTrue:
			[m statements last expression constantNumbericValueIfAtAllPossibleOrNilIn: aCCodeGen]]
]

{ #category : #accessing }
RustTSendNode >> constantNumbericValueOrNil [
	(#(* // + -) includes: selector) ifTrue:
		[receiver constantNumbericValueOrNil ifNotNil:
			[:rval|
			arguments first constantNumbericValueOrNil ifNotNil:
				[:aval|
				^rval perform: selector with: aval]]].
	^nil
]

{ #category : #transformations }
RustTSendNode >> copyWithoutReturn [
	self assert: self endsWithReturn.
	^self class new
		setSelector: selector
			receiver: receiver
				arguments: (arguments collect:
								[:arg|
								 arg endsWithReturn
									ifTrue: [arg copyWithoutReturn]
									ifFalse: [arg]]);
		yourself
]

{ #category : #'C code generation' }
RustTSendNode >> emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen [
	"Emit the receiver in a form that can be passed as an argument."

	"If the selector is a built-in construct, translate it and return"
	(aCodeGen emitBuiltinConstructAsArgumentFor: self on: aStream level: level) ifFalse:
		["If it is a pointer dereference generate it"
		(self emitCCodeAsFieldReferenceOn: aStream level: level generator: aCodeGen) ifFalse:
			["Otherwise generate the vanilla C function call."
			 self emitCCodeAsFunctionCallOn: aStream level: level generator: aCodeGen]]
]

{ #category : #'C code generation' }
RustTSendNode >> emitCCodeAsExpressionOn: aStream level: level generator: aCodeGen [
	^self emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen
]

{ #category : #'C code generation' }
RustTSendNode >> emitCCodeAsFieldReferenceOn: aStream level: level generator: aCodeGen [
	"If appropriate, translate this message send as a pointer dereference"
	| parenCount |

	false ifFalse: [ ^ false ].

	parenCount := receiver isSend
		ifTrue: [2]
		ifFalse: [1].

	aStream next: parenCount put: $(.

	receiver emitCCodeAsExpressionOn: aStream level: 0 generator: aCodeGen.
	parenCount > 1 ifTrue:
		[aStream nextPut: $)].

	aStream nextPut: $..
	aStream nextPutAll: (aCodeGen cFunctionNameFor: selector).
	arguments isEmpty ifFalse:
		[self assert: arguments size = 1.
		 aStream nextPutAll: ' = '.
		 arguments first emitCCodeAsExpressionOn: aStream level: level generator: aCodeGen].
	aStream nextPut: $).
	^true
]

{ #category : #'C code generation' }
RustTSendNode >> emitCCodeAsFunctionCallOn: aStream level: level generator: aCodeGen [
	"Translate this message send into a C function call"
	| aReceiverType anExpectedType shouldCast |

	selector == #break ifTrue:
		[aStream nextPutAll: '/* send of break elided */'.
		 ^self].

	"Special case for pluggable modules. Replace messages to interpreterProxy
	 by interpreterProxy->message(..) if the message is not builtin"
	(aCodeGen shouldGenerateAsInterpreterProxySend: self) ifTrue:
		[(aCodeGen noteUsedPluginFunction: selector) ifTrue:
			[aStream nextPutAll: 'interpreterProxy->']].
	
	aReceiverType := aCodeGen returnTypeForReceiver: self receiver.
	anExpectedType := aCodeGen receiverTypeForSend: self.
	
	shouldCast := anExpectedType isUnknown not
		and: [ (aReceiverType sameAs: anExpectedType) not ].

	shouldCast
		ifTrue: [ aStream nextPut: $( ].

	receiver emitCCodeOn: aStream level: level generator: aCodeGen.

	shouldCast
		ifTrue: [
			aStream nextPutAll: ' as '.
			aStream nextPutAll: anExpectedType asRustTypeName.
			aStream nextPut: $) ].

	aStream nextPut: $..
	aStream nextPutAll: (aCodeGen cFunctionNameFor: selector); nextPut: $(.

	arguments
		do: [ :arg| arg emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen]
		separatedBy: [ aStream nextPut: $,; space ].

	aStream nextPut: $)
]

{ #category : #'C code generation' }
RustTSendNode >> emitCCodeOn: aStream level: level generator: aCodeGen [
	"Emit the receiver as a statement."

	"If the selector is a built-in construct, translate it and return"
	(aCodeGen emitBuiltinConstructFor: self on: aStream level: level) ifFalse:
		["If it is a pointer dereference generate it"
		(self emitCCodeAsFieldReferenceOn: aStream level: level generator: aCodeGen) ifFalse:
			["Otherwise generate the vanilla C function call."
			 self emitCCodeAsFunctionCallOn: aStream level: level generator: aCodeGen]]
]

{ #category : #testing }
RustTSendNode >> endsWithReturn [
	^self isReturningIf
]

{ #category : #testing }
RustTSendNode >> hasSideEffect [
	"Answer if the parse tree rooted at this node has a side-effect or not."
	^(#(#+ #- #* #/ #// #\\ #= #== #~= #~~) includes: selector) not
]

{ #category : #testing }
RustTSendNode >> isAssertion [
	^(selector beginsWith: 'assert') or: [selector beginsWith: 'verify']
]

{ #category : #testing }
RustTSendNode >> isBuiltinOperator [

	^ isBuiltinOperator
]

{ #category : #testing }
RustTSendNode >> isBuiltinOperator: builtinFlag [

	isBuiltinOperator := builtinFlag.
]

{ #category : #testing }
RustTSendNode >> isConditionalSend [
	"Answer if the receiver is a send of any of the conditionals, ifTrue: ifTrue:ifFalse: et al"
	^#(	ifTrue:ifFalse: ifFalse:ifTrue: ifTrue: ifFalse:
		ifNil:ifNotNil: ifNotNil:ifNil: ifNil: ifNotNil) includes: selector
]

{ #category : #testing }
RustTSendNode >> isLiteralArrayDeclaration [
	^selector == #cCoerce:to:
	  and: [arguments first isConstant
	  and: [arguments first value isLiteral
	  and: [arguments first value isCollection]]]
]

{ #category : #testing }
RustTSendNode >> isNonNullCCode [
	^(#(cCode: cCode:inSmalltalk:) includes: selector)
	   and: [arguments first isConstant
	   and: [arguments first value isString
	   and: [arguments first value notEmpty]]]
]

{ #category : #testing }
RustTSendNode >> isPreprocessorDirective [
	^#(cPreprocessorDirective: cppIf:ifTrue:ifFalse: cppIf:ifTrue:) includes: selector
]

{ #category : #testing }
RustTSendNode >> isReturningIf [
	^(#(ifTrue:ifFalse: ifFalse:ifTrue: ifNil:ifNotNil: ifNotNil:ifNil:) includes: selector)
	   and: [arguments allSatisfy: [:arg| arg endsWithReturn]]
]

{ #category : #comparing }
RustTSendNode >> isSameAs: aTParseNode [
	(aTParseNode isSend
	 and: [selector == aTParseNode selector
	 and: [receiver isSameAs: aTParseNode receiver]]) ifFalse:
		[^false].
	arguments with: aTParseNode args do:
		[:a :b|
		(a isSameAs: b) ifFalse:
			[^false]].
	^true
]

{ #category : #'C code generation' }
RustTSendNode >> isSelfReference: varNode in: aCodeGen [
	^(varNode name beginsWith: 'self')
	  and: [varNode name = 'self' or: [varNode name beginsWith: 'self_in_']]
]

{ #category : #testing }
RustTSendNode >> isSend [

	^true
]

{ #category : #'C code generation' }
RustTSendNode >> isStructReference: varNode in: aCodeGen [
	^ false
]

{ #category : #testing }
RustTSendNode >> isValueExpansion [
	"Answer if the receiver is of the form literalBlock value[: arg]"
	^receiver isStmtList
	 and: [selector keywords allSatisfy: [:k| #('value' 'value:') includes: k]]
]

{ #category : #accessing }
RustTSendNode >> name [
	
	^ self printString
]

{ #category : #testing }
RustTSendNode >> needsTrailingSemicolon [
	"Answer if, when emitted as a statement (in particular in a TStmtList), the
	 receiver needs a trailing semicolon.  Preprocessor directives and special expansions do not."
	^(self isPreprocessorDirective
	   or: [self isValueExpansion
	   or: [selector == #expandDereferenceInterpreterProxyFunctionTable]]) not
]

{ #category : #enumerating }
RustTSendNode >> nodesDo: aBlock [
	"Apply aBlock to all nodes in the receiver.
	 N.B. This is assumed to be bottom-up, leaves first."
	receiver nodesDo: aBlock.
	arguments do: [ :arg | arg nodesDo: aBlock ].
	aBlock value: self
]

{ #category : #enumerating }
RustTSendNode >> nodesDo: aBlock parent: parent [
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	receiver nodesDo: aBlock parent: self.
	arguments do: [:arg| arg nodesDo: aBlock parent: self].
	aBlock value: self value: parent
]

{ #category : #enumerating }
RustTSendNode >> nodesDo: aBlock parent: parent unless: cautionaryBlock [

	(cautionaryBlock value: self value: parent) ifTrue: [^self].
	receiver nodesDo: aBlock parent: self unless: cautionaryBlock.
	arguments do: [ :arg | arg nodesDo: aBlock parent: self unless: cautionaryBlock].
	aBlock value: self value: parent
]

{ #category : #enumerating }
RustTSendNode >> nodesDo: aBlock unless: cautionaryBlock [

	(cautionaryBlock value: self) ifTrue: [^self].
	receiver nodesDo: aBlock unless: cautionaryBlock.
	arguments do: [ :arg | arg nodesDo: aBlock unless: cautionaryBlock].
	aBlock value: self.
]

{ #category : #accessing }
RustTSendNode >> numArgs [
	^arguments size
]

{ #category : #copying }
RustTSendNode >> postCopy [

	receiver := receiver copy.
	arguments := (arguments collect: [ :arg | arg copy ])
]

{ #category : #printing }
RustTSendNode >> printOn: aStream level: level [
	| possiblyParenthesize |
	possiblyParenthesize :=
		[:node :newLevel|
		node
			ifNil: [aStream print: node]
			ifNotNil: 
				[(node isSend
				  and: [node selector precedence >= 3]) ifTrue:
					[aStream nextPut: $(].
				node printOn: aStream level: newLevel.
				(node isSend
				 and: [node selector precedence >= 3]) ifTrue:
					[aStream nextPut: $)]]].

	possiblyParenthesize value: receiver value: level.
	arguments size = 0 ifTrue:
		[aStream space; nextPutAll: selector.
		^self].
	selector keywords with: (arguments first: selector numArgs) do:
		[:keyword :arg |
		aStream space; nextPutAll: keyword; space.
		possiblyParenthesize value: arg value: level + 1]
]

{ #category : #accessing }
RustTSendNode >> receiver [

	^receiver
]

{ #category : #private }
RustTSendNode >> receiver: aNode [

	receiver := aNode.
]

{ #category : #transformations }
RustTSendNode >> removeAssertions [
	receiver removeAssertions.
	arguments do: [:arg | arg removeAssertions].
]

{ #category : #transformations }
RustTSendNode >> replaceNodesIn: aDictionary [

	^aDictionary at: self ifAbsent: [
		receiver := receiver replaceNodesIn: aDictionary.
		arguments := arguments collect: [ :a | a replaceNodesIn: aDictionary ].
		self]
]

{ #category : #accessing }
RustTSendNode >> selector [

	^selector
]

{ #category : #accessing }
RustTSendNode >> selector: aSymbol [
	selector := aSymbol
]

{ #category : #accessing }
RustTSendNode >> setSelector: aSymbol receiver: rcvrNode arguments: argList [

	selector := aSymbol.
	receiver := rcvrNode.
	arguments := argList asArray.
	isBuiltinOperator := false.
]

{ #category : #accessing }
RustTSendNode >> setSelector: aSymbol receiver: rcvrNode arguments: argList isBuiltInOp: builtinFlag [

	selector := aSymbol.
	receiver := rcvrNode.
	arguments := argList asArray.
	isBuiltinOperator := builtinFlag.
]

{ #category : #'C code generation' }
RustTSendNode >> shouldExcludeReceiverAsFirstArgument: aCodeGen [
	"Only include the receiver as the first argument in certain cases.
	 The receiver is always included if it is an expression.
	 If it is a variable:
		 If the vmClass says it is an implicit variable, don't include it.
		 If the method's definingClass says it is an implicit variable, don't include it.
		 If the variable is 'self' and the method being called is not in
		 the method set (i.e. it is some external code), don't include it.
		 If it is a struct send of something the vm says is an implicit variable, don't include it."
	| m |
	(aCodeGen isAssertSelector: selector) ifTrue:
		[^true].

	(receiver isSend
	 and: [(receiver shouldExcludeReceiverAsFirstArgument: aCodeGen)
		or: [receiver receiver isVariable
			 and: [(self isSelfReference: receiver receiver in: aCodeGen)
				or: [self isStructReference: receiver receiver in: aCodeGen]]]]) ifTrue:
		[^aCodeGen isNonArgumentImplicitReceiverVariableName: receiver selector].

	^receiver isVariable
	    and: [(aCodeGen isNonArgumentImplicitReceiverVariableName: receiver name)
		    or: [(self isSelfReference: receiver in: aCodeGen)
			    and: [(m := aCodeGen methodNamed: selector) isNil
					or: [#(implicit nil) includes: m typeForSelf]]]]
]

{ #category : #'C code generation' }
RustTSendNode >> shouldIncludeReceiverAsFirstArgument: aCodeGen [
	"Only include the receiver as the first argument in certain cases.
	 The receiver is always included if it is an expression.
	 If it is a variable:
		 If the vmClass says it is an implicit variable, don't include it.
		 If the variable is 'self' and the method being called is not in
		 the method set (i.e. it is some external code), don't include it."
	^(self shouldExcludeReceiverAsFirstArgument: aCodeGen) not
]

{ #category : #'type inference' }
RustTSendNode >> typeOrNilFrom: aCodeGenerator in: aTMethod [
	^aCodeGenerator returnTypeForSend: self in: aTMethod ifNil: nil
]
