Class {
	#name : #RustTConstantNode,
	#superclass : #RustTParseNode,
	#instVars : [
		'value'
	],
	#category : #'VMMaker-Rust'
}

{ #category : #transformations }
RustTConstantNode >> asPrintfFormatStringNode [
	^TPrintfFormatStringNode new
		setValue: value;
		comment: comment;
		yourself
]

{ #category : #accessing }
RustTConstantNode >> constantNumbericValueIfAtAllPossibleOrNilIn: aCCodeGen [
	"This is a version of constantNumbericValueOrNil for type checking rather than code generation.
	 It aims to yield a value if at all possible.  This should /not/ be overridden in TDefineNode."
	^value isNumber ifTrue: [value]
]

{ #category : #accessing }
RustTConstantNode >> constantNumbericValueOrNil [

	^value isNumber ifTrue: [value]
]

{ #category : #'C code generation' }
RustTConstantNode >> emitCCodeOn: aStream level: level generator: aCodeGen [
	"Emit a C literal."
	aStream nextPutAll: (aCodeGen cLiteralFor: value).
	comment ifNotNil:
		[aStream
			nextPutAll: ' /* ';
			nextPutAll: comment;
			nextPutAll: ' */']
]

{ #category : #testing }
RustTConstantNode >> hasSideEffect [
	"Answer if the parse tree rooted at this node has a side-effect or not."
	^false
]

{ #category : #testing }
RustTConstantNode >> isConstant [

	^true
]

{ #category : #testing }
RustTConstantNode >> isLeaf [

	^true
]

{ #category : #comparing }
RustTConstantNode >> isSameAs: aTParseNode [
	^aTParseNode isConstant
	 and: [value class == aTParseNode value class
	 and: [value = aTParseNode value]]
]

{ #category : #accessing }
RustTConstantNode >> name [
	^''
]

{ #category : #accessing }
RustTConstantNode >> nameOrValue [

	^value
]

{ #category : #enumerating }
RustTConstantNode >> nodesDo: aBlock parent: parent [
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	aBlock value: self value: parent
]

{ #category : #printing }
RustTConstantNode >> printOn: aStream level: level [
	value isSymbol
		ifTrue: [aStream nextPutAll: (value copyWithout: $:)]
		ifFalse: [value storeOn: aStream]
]

{ #category : #accessing }
RustTConstantNode >> setValue: anObject [

	value := anObject.
]

{ #category : #'type inference' }
RustTConstantNode >> typeOrNilFrom: aCodeGenerator in: aTMethod [
	"For integers, answer int unless the value does not fit into a 32bits signed int.
	In that case, answer the shortest architecture independant integer type that could hold the constant.
	This method must be consistent with CCodeGenerator>>cLiteralFor:"
	| hb |
	value isInteger
		ifTrue:
			[value positive
				ifTrue:
					[hb := value highBit.
					hb < 32 ifTrue: [^#int].
					hb = 32 ifTrue: [^#'unsigned int'].
					hb = 64 ifTrue: [^#'unsigned long long'].
					^#'long long']
				ifFalse:
					[hb := value bitInvert highBit.
					hb < 32 ifTrue: [^#int].
					^#'long long']].
	value isFloat ifTrue: [^#double].
	(#(nil true false) includes: value) ifTrue: [^#int].
	(value isString and: [value isSymbol not]) ifTrue: [^#'char *'].
	^nil
]

{ #category : #accessing }
RustTConstantNode >> value [

	^value
]
