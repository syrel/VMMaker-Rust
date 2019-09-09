Class {
	#name : #RustTStmtListNode,
	#superclass : #RustTParseNode,
	#instVars : [
		'arguments',
		'statements'
	],
	#category : #'VMMaker-Rust-Nodes'
}

{ #category : #adding }
RustTStmtListNode >> addReadBeforeAssignedIn: variables to: readBeforeAssigned assignments: assigned in: aCodeGen [
	"Add any variables in variables that are read before written to readBeforeAssigned.
	 Add unconditional assignments to assigned.  For convenience answer assigned."
	self
		nodesWithParentsDo:
			[:node :parent|
			(node isAssignment
			 and: [variables includes: node variable name]) ifTrue:
				[assigned add: node variable name].
			(node isVariable
			 and: [(variables includes: node name)
			 and: [(assigned includes: node name) not
			 and: [(#(nil pointer) includes: (node structTargetKindIn: aCodeGen))
			 and: [(parent notNil and: [parent isAssignment and: [parent variable == node]]) not]]]]) ifTrue:
				[node name = 'theCalloutState' ifTrue:
					[self halt].
				 readBeforeAssigned add: node name]]
		unless:
			[:node :parent| | conditionalAssignments mayHaveSideEffects |
			node isSend
				ifTrue:
					["First deal with implicit assignments..."
					node isValueExpansion ifTrue:
						[assigned addAll: node receiver args].
					(#(#'memcpy:_:_:' #'memmove:_:_:') includes: node selector) ifTrue:
						[assigned add: (node args first detect: [:subnode| subnode isVariable]) name].
					(#(to:do: to:by:do:) includes: node selector) ifTrue:
						[assigned addAll: (node args at: node selector numArgs) args.
						 mayHaveSideEffects := node args size = 4. "See TMethod>>prepareMethodIn:"
						 mayHaveSideEffects ifTrue:
							[assigned add: node args last name]].
					"Then deal with read-before-written in the arms of conditionals..."
					(#(ifTrue: ifFalse: ifNil: ifNotNil:) intersection: node selector keywords) notEmpty
						ifTrue:
							["First find assignments in the expression..."
							 (RustTStmtListNode new setStatements: {node receiver}; yourself)
								addReadBeforeAssignedIn: variables
								to: readBeforeAssigned
								assignments: assigned
								in: aCodeGen.
							 "Now find read-before-written in each arm, and collect the assignments to spot those assigned in both arms"
							 conditionalAssignments :=
								node args
									collect:
										[:block|
										block isStmtList ifTrue:
											[block
												addReadBeforeAssignedIn: variables
												to: readBeforeAssigned
												assignments: assigned copy
												in: aCodeGen]]
									thenSelect: [:each| each notNil].
							 "add to assigned those variables written to in both arms"
							 conditionalAssignments size = 2 ifTrue:
								[conditionalAssignments := conditionalAssignments collect: [:set| set difference: assigned].
								 assigned addAll: (conditionalAssignments first intersection: conditionalAssignments last)].
							 true]
						ifFalse:
							[false]]
				ifFalse:
					[false]].
	^assigned
]

{ #category : #accessing }
RustTStmtListNode >> args [

	^arguments
]

{ #category : #transformations }
RustTStmtListNode >> asReturnNode [
	self endsWithReturn ifTrue:
		[^self].
	^self class new
		setArguments: arguments
			statements: statements allButLast, {statements last asReturnNode};
		yourself
]

{ #category : #transformations }
RustTStmtListNode >> assignLastExpressionTo: variableNode [
	"Destructively transform the receiver so that its last expression is assigned to the argument."
	| index |
	index := statements findLast: [:expr| (expr isGoTo or: [expr isLabel]) not].
	statements
		at: index
		put: (RustTAssignmentNode new
				setVariable: variableNode
				expression: (statements at: index))
]

{ #category : #transformations }
RustTStmtListNode >> bindVariableUsesIn: aDictionary [

	statements := statements collect: [ :s | s bindVariableUsesIn: aDictionary ].
]

{ #category : #transformations }
RustTStmtListNode >> bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen [
	"Answer either the receiver, if it contains no references to the given variables, or a new node with the given variables rebound."
	| newStatements |
	newStatements := statements collect: [:s| s bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen].
	^newStatements = statements
		ifTrue: [self]
		ifFalse:
			[self shallowCopy
				setStatements: newStatements;
				yourself]
]

{ #category : #transformations }
RustTStmtListNode >> bindVariablesIn: aDictionary [

	statements := statements collect: [ :s | s bindVariablesIn: aDictionary ].
]

{ #category : #transformations }
RustTStmtListNode >> copyWithoutReturn [
	self assert: self endsWithReturn.
	statements size = 1 ifTrue:
		[^statements last expression].
	^self class new
		setArguments: arguments
			statements: statements allButLast, {statements last copyWithoutReturn};
		yourself
]

{ #category : #'C code generation' }
RustTStmtListNode >> emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen [
	| size |
	(size := statements size) = 1 ifTrue:
		[^statements first emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen].
	"Get rid of the annoying newlines in ? : if-then-elses"
	(size = 2 and: [statements first isComment and: [statements last isLeaf]]) ifTrue:
		[statements first emitCCodeAsArgumentOn: aStream level: 0 generator: aCodeGen.
		 aStream space.
		 ^statements last emitCCodeAsArgumentOn: aStream level: 0 generator: aCodeGen].
	aStream nextPut: $(. "N.B.  Comma binds weakest of all C operators."
	statements withIndexDo:
		[:s :idx| | p1 p2 |
		p1 := aStream position.
		s emitCCommentOn: aStream level: level generator: aCodeGen.
		(s isLeaf and: [s isLabel not and: [idx < statements size]]) ifFalse:
			[s emitCCodeAsArgumentOn: aStream level: level + 1 generator: aCodeGen].
		p2 := aStream position.
		(idx < size and: [p2 > p1]) ifTrue:
			[((self endsWithCloseBracket: aStream)
			  or: [s isComment]) ifFalse: [aStream nextPut: $,].
			 aStream crtab: level]].
	aStream nextPut: $)
]

{ #category : #'C code generation' }
RustTStmtListNode >> emitCCodeAsExpressionOn: aStream level: level generator: aCodeGen [
	^self emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen
]

{ #category : #'C code generation' }
RustTStmtListNode >> emitCCodeOn: aStream level: level generator: aCodeGen [

	self emitCCodeOn: aStream prependToEnd: nil level: level generator: aCodeGen

]

{ #category : #'C code generation' }
RustTStmtListNode >> emitCCodeOn: aStream prependToEnd: aNodeOrNil level: level generator: aCodeGen [
	self emitCCommentOn: aStream level: level generator: aCodeGen.
	statements withIndexDo:
		[:s :idx| | position |
		s emitCCommentOn: aStream level: level generator: aCodeGen.
		(s isLeaf and: [s isLabel not and: [aNodeOrNil isNil or: [idx < statements size]]]) ifFalse:
			[aStream peekLast ~~ Character tab ifTrue:
				[aStream tab: level].
			position := aStream position.
			(aNodeOrNil notNil
			 and: [idx = statements size])
				ifTrue:
					[s emitCCodeOn: aStream prependToEnd: aNodeOrNil level: level generator: aCodeGen]
				ifFalse:
					[s emitCCodeOn: aStream level: level generator: aCodeGen].
			aStream position > position ifTrue:
				[(self stream: aStream endsWithAnyOf: '};') ifFalse:
					[s needsTrailingSemicolon ifTrue:
						[aStream nextPut: $;]].
					 aStream peekLast ~~ Character cr ifTrue:
						[aStream cr]]]]
]

{ #category : #testing }
RustTStmtListNode >> endsWithCloseBracket: aStream [
	"Answer true if the given stream ends in a $} character."

	| ch pos |
	ch := (pos := aStream position) > 0 ifTrue:
			[aStream class = WriteStream "i.e. nested in StreamContents"
				ifTrue: [aStream originalContents at: pos]
				ifFalse: [aStream position: pos - 1; next]].
	^ ch = $}

]

{ #category : #testing }
RustTStmtListNode >> endsWithReturn [
	"Answer true if the last statement of this lock is a return."

	^statements notEmpty
	  and: [statements last isReturn or: [statements last isReturningIf]]
]

{ #category : #testing }
RustTStmtListNode >> isNilStmtListNode [

	|stmt|
	statements size = 1 ifFalse: [^false].
	stmt := statements at: 1.
	^ stmt isVariable and: [stmt name = 'nil']
]

{ #category : #testing }
RustTStmtListNode >> isSameAs: aTParseNode [
	(aTParseNode isStmtList
	 and: [statements size = aTParseNode statements size]) ifFalse:
		[^false].
	statements with: aTParseNode statements do:
		[:mine :theirs|
		 (mine isSameAs: theirs) ifFalse:
			[^false]].
	^true
]

{ #category : #testing }
RustTStmtListNode >> isStmtList [

	^true
]

{ #category : #enumerating }
RustTStmtListNode >> nodesDo: aBlock [
	"Apply aBlock to all nodes in the receiver.
	 N.B. This is assumed to be bottom-up, leaves first."
	statements do: [ :s | s nodesDo: aBlock ].	
	aBlock value: self
]

{ #category : #enumerating }
RustTStmtListNode >> nodesDo: aBlock parent: parent [
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	statements do: [:s| s nodesDo: aBlock parent: self].
	aBlock value: self value: parent
]

{ #category : #enumerating }
RustTStmtListNode >> nodesDo: aBlock parent: parent unless: cautionaryBlock [

	(cautionaryBlock value: self value: parent) ifTrue: [^self].
	statements do: [ :s | s nodesDo: aBlock parent: self unless: cautionaryBlock].
	aBlock value: self value: parent
]

{ #category : #enumerating }
RustTStmtListNode >> nodesDo: aBlock unless: cautionaryBlock [

	(cautionaryBlock value: self) ifTrue: [^self].
	statements do: [ :s | s nodesDo: aBlock unless: cautionaryBlock ].	
	aBlock value: self
]

{ #category : #enumerating }
RustTStmtListNode >> nodesDo: aBlock value: parent [
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	statements do: [:s| s nodesDo: aBlock parent: self.].	
	aBlock value: self value: parent
]

{ #category : #copying }
RustTStmtListNode >> postCopy [

	arguments := arguments copy.
	statements := statements collect: [ :s | s copy ]
]

{ #category : #printing }
RustTStmtListNode >> printOn: aStream level: level [

	statements size > 1 ifTrue: [ aStream crtab: level + 1 ].
	aStream nextPut: $[.
	(arguments notNil and: [arguments notEmpty]) ifTrue:
		[arguments do: [ :arg | aStream nextPutAll: ' :'; nextPutAll: arg].
		 aStream nextPutAll: ' | '].
	self printStatementsOn: aStream level: level.
	aStream nextPut: $]
]

{ #category : #printing }
RustTStmtListNode >> printStatementsOn: aStream level: level [

	statements
		do: [:s| s printOn: aStream level: level]
		separatedBy: [aStream nextPut: $.; crtab: level + 1]
]

{ #category : #transformations }
RustTStmtListNode >> removeAssertions [
	| newStatements |
	newStatements := OrderedCollection new: statements size.
	statements do: [ :stmt |
		stmt isAssertion ifFalse: [
			newStatements add: (stmt removeAssertions; yourself).
		]
	].
	self setStatements: newStatements asArray
]

{ #category : #'inlining support' }
RustTStmtListNode >> renameLabelsForInliningInto: aTMethod [
	"TMethod already has a method for this; hijack it..."
	| labels |
	labels := OrderedCollection new.
	self nodesDo:
		[:node| node isLabel ifTrue: [labels add: node label]].
	RustMethod new
		parseTree: self;
		labels: labels;
		renameLabelsForInliningInto: aTMethod
]

{ #category : #transformations }
RustTStmtListNode >> replaceChild: aNode with: bNode [ 
	statements := Array streamContents:
					[:s|
					statements do:
						[:node|
						node == aNode
							ifTrue:
								[bNode isStmtList
									ifTrue: [s nextPutAll: bNode statements]
									ifFalse: [s nextPut: bNode]]
							ifFalse: [s nextPut: node]]]
]

{ #category : #transformations }
RustTStmtListNode >> replaceNodesIn: aDictionary [

	^aDictionary at: self ifAbsent: [
		statements := statements collect: [ :s | s replaceNodesIn: aDictionary ].
		self]
]

{ #category : #testing }
RustTStmtListNode >> returnsExpression [
	"Answer true if the last statement of this block is a return of some expression, not merely self or nil."

	statements isEmpty ifTrue:
		[^false].
	statements last isReturn ifFalse:
		[^false].
	statements last isVariable ifFalse:
		[^true].
	^statements last variable ~= 'self'
	  and: [statements last variable ~= 'nil']
]

{ #category : #accessing }
RustTStmtListNode >> setArguments: argList [

	arguments := argList.
]

{ #category : #accessing }
RustTStmtListNode >> setArguments: argList statements: statementList [
	"Initialize this method using the given information."

	arguments := argList.
	statements := statementList.
]

{ #category : #accessing }
RustTStmtListNode >> setStatements: stmtList [

	statements := stmtList asOrderedCollection.
]

{ #category : #inlining }
RustTStmtListNode >> shouldExpand [
	^(statements detect: [:stmt| stmt isInline]) shouldExpand
]

{ #category : #accessing }
RustTStmtListNode >> statements [

	^statements
]

{ #category : #'type inference' }
RustTStmtListNode >> typeOrNilFrom: aCodeGenerator in: aTMethod [
	^statements isEmpty ifFalse:
		[statements last typeOrNilFrom: aCodeGenerator in: aTMethod]
]
