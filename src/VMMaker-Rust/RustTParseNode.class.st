Class {
	#name : #RustTParseNode,
	#superclass : #Object,
	#instVars : [
		'comment'
	],
	#category : #'VMMaker-Rust-Nodes'
}

{ #category : #utilities }
RustTParseNode >> allCalls [
	"Answer a collection of selectors for the messages sent in this parse tree."

	| calls |
	calls := Set new: 32.
	self nodesDo:
		[:node|
		node isSend ifTrue:
			[calls add: node selector].
		(node isConstant and: [node value isSymbol]) ifTrue:
			[calls add: node value]].
	^calls
]

{ #category : #enumerating }
RustTParseNode >> allSatisfy: aBlock [
	self nodesDo: [:n| (aBlock value: n) ifFalse: [^false]].
	^true
]

{ #category : #enumerating }
RustTParseNode >> allSatisfy: aBlock unless: cautionaryBlock [
	self
		nodesDo: [:n| (aBlock value: n) ifFalse: [^false]]
		unless: cautionaryBlock.
	^true
]

{ #category : #enumerating }
RustTParseNode >> anySatisfy: aBlock [
	self nodesDo: [:n| (aBlock value: n) ifTrue: [^true]].
	^false
]

{ #category : #enumerating }
RustTParseNode >> anySatisfy: aBlock unless: cautionaryBlock [
	self
		nodesDo: [:n| (aBlock value: n) ifTrue: [^true]]
		unless: cautionaryBlock.
	^false
]

{ #category : #converting }
RustTParseNode >> asReturnNode [
	^RustTReturnNode new 
		setExpression: self;
		yourself
]

{ #category : #transformations }
RustTParseNode >> bindVariableUsesIn: aDictionary [
	"Bind uses of all variables in the given dictionary, but do not change variables that appear on the left-hand-side of an assignment statement."

	^ self

]

{ #category : #transformations }
RustTParseNode >> bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen [
	"Answer either the receiver, if it contains no references to the given variables, or a new node with the given variables rebound.
	 But do not change variables that appear on the left-hand-side of an assignment statement."
	^self

]

{ #category : #transformations }
RustTParseNode >> bindVariablesIn: aDictionary [

	^self
]

{ #category : #enumerating }
RustTParseNode >> collect: aBlock [
	| nodes |
	self halt. "This is a misnomer; should be deleted"
	nodes := OrderedCollection new.
	self nodesDo: [:n| (aBlock value: n) ifTrue: [nodes add: n]].
	^nodes
]

{ #category : #accessing }
RustTParseNode >> comment [
	^comment
]

{ #category : #accessing }
RustTParseNode >> comment: aComment [

	comment := aComment 
]

{ #category : #accessing }
RustTParseNode >> constantNumbericValueIfAtAllPossibleOrNilIn: aCCodeGen [
	"This is a version of constantNumbericValueOrNil for type checking rather than code generation.
	 It aims to yield a value if at all possible."
	^self constantNumbericValueOrNil
]

{ #category : #accessing }
RustTParseNode >> constantNumbericValueOrNil [

	^nil
]

{ #category : #enumerating }
RustTParseNode >> detect: aBlock [
	^self detect: aBlock ifNone: [self error: 'Node is not in the tree']
]

{ #category : #enumerating }
RustTParseNode >> detect: aBlock ifNone: defaultBlock [
	self nodesDo: [:n| (aBlock value: n) ifTrue: [^n]].
	^defaultBlock value
]

{ #category : #'C code generation' }
RustTParseNode >> emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen [
	^self emitCCodeOn: aStream level: level generator: aCodeGen
]

{ #category : #'C code generation' }
RustTParseNode >> emitCCodeAsExpressionOn: aStream level: level generator: aCodeGen [
	^self emitCCodeOn: aStream level: level generator: aCodeGen
]

{ #category : #'C code generation' }
RustTParseNode >> emitCCodeOn: aStream level: lev generator: gen [
	self subclassResponsibility.
]

{ #category : #'C code generation' }
RustTParseNode >> emitCCodeOn: aStream prependToEnd: aNodeOrNil level: lev generator: gen [
	aNodeOrNil ifNotNil:
		[aNodeOrNil prependCCodeOn: aStream level: lev generator: gen].
	self emitCCodeAsExpressionOn: aStream
		level: ((aNodeOrNil notNil and: [self isLeaf]) ifTrue: [0] ifFalse: [lev])
		generator: gen
]

{ #category : #'C code generation' }
RustTParseNode >> emitCCommentOn: aStream level: level generator: aCodeGen [
	"Emit the transferred Smalltalk comments as C comments."

	((aCodeGen previousCommenter: self) == self or: [comment isNil]) ifTrue:
		[aCodeGen previousCommentMarksInlining: false.
		 ^self].
	(comment isString ifTrue: [{comment}] ifFalse: [comment]) withIndexDo:
		[:commentString :index |
		(index = 1 and: [commentString beginsWith: 'begin ']) ifTrue:
			[(aCodeGen previousCommentMarksInlining: true) ifTrue: [^true]].
		aStream crtab: level; nextPutAll: '/* '.
		(commentString findTokens: Character cr)
			do: [:line| aStream nextPutAll: line withBlanksTrimmed]
			separatedBy: [aStream crtab: level; next: 3 put: Character space].
		aStream nextPutAll: ' */'].
	 aStream cr
]

{ #category : #testing }
RustTParseNode >> endsWithReturn [

	^false
]

{ #category : #testing }
RustTParseNode >> hasExplicitReturn [

	self nodesDo: [ :node |
		node isReturn ifTrue: [ ^true ].
	].
	^false
]

{ #category : #testing }
RustTParseNode >> hasSideEffect [
	"Answer if the parse tree rooted at this node has a side-effect or not.  By default assume it has.  Nodes that don't override."
	^true
]

{ #category : #testing }
RustTParseNode >> isAssertion [
	^false
]

{ #category : #testing }
RustTParseNode >> isAssignment [

	^false
]

{ #category : #testing }
RustTParseNode >> isCaseStmt [

	^false
]

{ #category : #testing }
RustTParseNode >> isComment [

	^false
]

{ #category : #testing }
RustTParseNode >> isConditionalSend [
	"Answer if the receiver is a send of any of the conditionals, ifTrue: ifTrue:ifFalse: et al"
	^false
]

{ #category : #testing }
RustTParseNode >> isConstant [

	^false
]

{ #category : #testing }
RustTParseNode >> isDefine [

	^false
]

{ #category : #testing }
RustTParseNode >> isGoTo [

	^false
]

{ #category : #testing }
RustTParseNode >> isInline [
	^false
]

{ #category : #testing }
RustTParseNode >> isLabel [

	^false
]

{ #category : #testing }
RustTParseNode >> isLeaf [
	"Answer true if the receiver is a variable or a constant node."

	^false
]

{ #category : #testing }
RustTParseNode >> isLiteralArrayDeclaration [
	^false
]

{ #category : #testing }
RustTParseNode >> isNonNullCCode [
	"overridden in TSendNode"
	^false
]

{ #category : #testing }
RustTParseNode >> isReturn [

	^false
]

{ #category : #testing }
RustTParseNode >> isReturningIf [
	^false
]

{ #category : #comparing }
RustTParseNode >> isSameAs: aTParseNode [
	"Answer if the ParseTree rooted at this node is the same as aTParseNode.
	 By default answer false and have subclasses override as appropriate."
	^false
]

{ #category : #testing }
RustTParseNode >> isSend [

	^false
]

{ #category : #testing }
RustTParseNode >> isStmtList [

	^false
]

{ #category : #testing }
RustTParseNode >> isSwitch [
	^false
]

{ #category : #testing }
RustTParseNode >> isTMethod [
	^false
]

{ #category : #testing }
RustTParseNode >> isTParseNode [
	^true
]

{ #category : #testing }
RustTParseNode >> isVariable [

	^false
]

{ #category : #accessing }
RustTParseNode >> nameOrValue [

	self error: 'object is neither variable nor constant'
]

{ #category : #testing }
RustTParseNode >> needsTrailingSemicolon [
	"Answer if, when emitted as a statement (in particular in a TStmtList), the
	 receiver needs a trailing semicolon.  Subclasses redefine as appropriate."
	^true
]

{ #category : #utilities }
RustTParseNode >> nodeCount [
	"Answer the number of nodes in this parseTree (a rough measure of its size)."

	| cnt |
	cnt := 0.
	self nodesDo: [ :n | cnt := cnt + 1 ].
	^cnt
]

{ #category : #enumerating }
RustTParseNode >> nodesDo: aBlock [
	"Apply aBlock to all nodes in the receiver.
	 N.B. This is assumed to be bottom-up, leaves first."
	aBlock value: self
]

{ #category : #enumerating }
RustTParseNode >> nodesDo: aBlock parent: parent [
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	self subclassResponsibility
]

{ #category : #enumerating }
RustTParseNode >> nodesDo: aBlock parent: parent unless: cautionaryBlock [
	"Evaluate aBlock for all nodes in  the tree except those for which cautionaryBlock
	 answers true or are children of those for which cautionaryBlock answers true."
	(cautionaryBlock value: self value: parent) ifFalse:
		[aBlock value: self value: parent]
]

{ #category : #enumerating }
RustTParseNode >> nodesDo: aBlock unless: cautionaryBlock [
	"Evaluate aBlock for all nodes in  the tree except those for which cautionaryBlock
	 answers true or are children of those for which cautionaryBlock answers true."
	(cautionaryBlock value: self) ifFalse:
		[aBlock value: self]
]

{ #category : #enumerating }
RustTParseNode >> nodesSelect: selectBlock thenCollect: collectBlock [
	| result |
	result := OrderedCollection new.
	self nodesDo:
		[:node|
		(selectBlock value: node) ifTrue:
			[result addLast: (collectBlock value: node)]].
	^result
]

{ #category : #enumerating }
RustTParseNode >> nodesWithParentsDo: aBlock [
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	self nodesDo: aBlock parent: nil
]

{ #category : #enumerating }
RustTParseNode >> nodesWithParentsDo: aBlock unless: cautionaryBlock [
	"Evaluate aBlock for all nodes in the tree and their parent except those for which
	 cautionaryBlock answers true or are children of those for which cautionaryBlock
	 answers true. Cautionary block is invoked with node and parent.  parent may be nil."
	self nodesDo: aBlock parent: nil unless: cautionaryBlock
]

{ #category : #enumerating }
RustTParseNode >> noneSatisfy: aBlock [
	self nodesDo: [:n| (aBlock value: n) ifTrue: [^false]].
	^true
]

{ #category : #enumerating }
RustTParseNode >> noneSatisfy: aBlock unless: cautionaryBlock [
	self
		nodesDo: [:n| (aBlock value: n) ifTrue: [^false]]
		unless: cautionaryBlock.
	^true
]

{ #category : #enumerating }
RustTParseNode >> occurrencesOf: aNode [
	| count |
	count := 0.
	self nodesDo:
		[:node|
		node = aNode ifTrue: [count := count + 1]].
	^count
]

{ #category : #printing }
RustTParseNode >> printOn: aStream [ 
	"Append a description of the receiver onto the given stream."

	self printOn: aStream level: 0.
]

{ #category : #printing }
RustTParseNode >> printOn: aStream level: anInteger [ 
	"Typically overridden. If control actually gets here, avoid recursion loop by sending to super."

	super printOn: aStream.
]

{ #category : #transformations }
RustTParseNode >> removeAssertions [
	"default: do nothing"
]

{ #category : #transformations }
RustTParseNode >> replaceNodesIn: aDictionary [

	^aDictionary at: self ifAbsent: [self]
]

{ #category : #enumerating }
RustTParseNode >> select: aBlock [
	| nodes |
	nodes := OrderedCollection new.
	self nodesDo: [:n| (aBlock value: n) ifTrue: [nodes add: n]].
	^nodes
]

{ #category : #testing }
RustTParseNode >> stream: aStream endsWithAnyOf: characters [
	"Answer if the given stream ends in any of the characters, ignoring whitespace."
	| pos ch popped |
	pos := aStream position.
	aStream class = WriteStream ifTrue: "i.e. nested in StreamContents"
		[[pos > 0] whileTrue:
			[ch := aStream originalContents at: pos.
			 ch isSeparator ifFalse:
				[^characters includes: ch].
			 pos := pos - 1].
		 ^false].

	popped := OrderedCollection new.
	[pos > 0] whileTrue:
		[ch := popped addFirst: (aStream position: pos - 1; peek).
		 ch isSeparator ifFalse:
			[popped notEmpty ifTrue: "it almost always is"
				["*don't* use nextPutAll: to work around a bug in UTF8TextConverter
				  >>nextPut:toStream: which avoids line-end conversion; sigh."
				 popped do:
					[:c| aStream nextPut: c]].
			 ^characters includes: ch].
		 pos := pos - 1].
	"*don't* use nextPutAll: to work around a bug in UTF8TextConverter>>
	 nextPut:toStream: which avoids line-end conversion; sigh."
	popped do:
		[:c| aStream nextPut: c].
	^false
]

{ #category : #'type inference' }
RustTParseNode >> typeFrom: aCodeGenerator in: aTMethod [
	"This is the default type in case of doubt"
	^(self typeOrNilFrom: aCodeGenerator in: aTMethod) ifNil: [ RustUnknownType new ]
]

{ #category : #'type inference' }
RustTParseNode >> typeOrNilFrom: aCodeGenerator in: aTMethod [
	<return: #RustTypedValue>

	^ RustUnknownType new
]

{ #category : #accessing }
RustTParseNode >> variableNameOrNil [
	"Overridden in TAssignmentNode & TVariableNode to answer their variable name."
	^nil
]
