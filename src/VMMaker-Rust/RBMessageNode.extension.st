Extension { #name : #RBMessageNode }

{ #category : #'*VMMaker-Rust' }
RBMessageNode >> asRustTranslatorNodeIn: aTMethod [
	"Answer a TParseNode subclass equivalent of me"
	"selector is sometimes a Symbol, sometimes a SelectorNode!
	 On top of this, numArgs is needed due to the (truly grody) use of
	 arguments as a place to store the extra expressions needed to generate
	 code for in-line to:by:do:, etc.  see below, where it is used.

	 Expand super nodes in place. Elide sends of halt so that halts can be
	 sprinkled through the simulator but will be eliminated from the generated C."
	| usedSelector rcvrOrNil args |
	usedSelector := selector.
	rcvrOrNil := receiver ifNotNil: [receiver asRustTranslatorNodeIn: aTMethod].
	(rcvrOrNil notNil
	and: [rcvrOrNil isVariable
	and: [rcvrOrNil name = 'super']]) ifTrue:
		[^aTMethod superExpansionNodeFor: usedSelector args: arguments].
	usedSelector == #halt ifTrue: [^rcvrOrNil].
	(usedSelector == #cCode:inSmalltalk: "extracting here rather than in translation allows inlining in the block."
	  or: [usedSelector == #cCode:]) ifTrue:
		[arguments first isBlockNode ifTrue:
			[| block |
			 ^(block := arguments first asRustTranslatorNodeIn: aTMethod) statements size = 1
				ifTrue: [block statements first]
				ifFalse: [block]].
		 (arguments first isLiteralNode
		 and: [arguments first value isString
		 and: [arguments first value isEmpty]]) ifTrue:
			[^arguments first asRustTranslatorNodeIn: aTMethod]].
	args := arguments collect: [:arg| arg asRustTranslatorNodeIn: aTMethod].
	
	(usedSelector == #to:do:) ifTrue: [ | block |
		usedSelector := #to:by:do:.
		block := args second.
		arguments first isLiteralNode ifTrue: [
			args := OrderedCollection
				with: args first
				with: (RustTConstantNode new setValue: 1)
				with: args second
				with: (RustTAssignmentNode new
							setVariable: (arguments first asRustTranslatorNodeIn: aTMethod)
							expression: (RustTConstantNode new setValue: 1);
							yourself)
				with: (RustTSendNode new
					setSelector: #<=
					receiver: (RustTVariableNode new setName: block args first)
					arguments: { receiver asRustTranslatorNodeIn: aTMethod })
				with: (RustTAssignmentNode new
							setVariable: (RustTVariableNode new setName: block args first)
							expression: (RustTSendNode new
								setSelector: #+
								receiver: (RustTVariableNode new setName: block args first)
								arguments: { RustTConstantNode new setValue: 1 });
								yourself)
		] ifFalse: [
			args := OrderedCollection
				with: args first
				with: (RustTConstantNode new setValue: 1)
				with: args second
				with: (RustTVariableNode new setName: 'iLimiT')
		]
	].
	
	"If in the form of ifNil: [ :obj | ], replace that by an assignment and an ifFalse"
	((usedSelector == #ifNotNil:) and: [ args first args notEmpty ]) ifTrue: [
		^ RustTStmtListNode new
			setArguments: #();
			setStatements: {
				RustTAssignmentNode new
					setVariable: (RustTVariableNode new setName: args first args first)
					expression: rcvrOrNil.
	
				RustTSendNode new
					setSelector: #ifFalse:
					receiver: (RustTSendNode new
						setSelector: #==
						receiver: (RustTVariableNode new setName: args first args first)
						arguments: {(RustTVariableNode new setName: 'nil')};
						yourself)
					arguments: {args first}
			};
			yourself ].
	
	(#(#ifNotNil:ifNil: #ifNil:ifNotNil:) includes: usedSelector) ifTrue: [ | comparand expression blockWithPossibleArgument |
		"We turn it always to an ifTrueIfFalse"
		usedSelector = #ifNotNil:ifNil:
			ifTrue: [ args := args reversed ].
		blockWithPossibleArgument := args second.
		expression := rcvrOrNil.
		comparand := blockWithPossibleArgument args
			ifEmpty: [ expression ]
			ifNotEmpty: [ (RustTVariableNode new setName: blockWithPossibleArgument args first) ].
		
		usedSelector := #ifTrue:ifFalse:.
		rcvrOrNil := RustTSendNode new
			setSelector: #==
			receiver: comparand
			arguments: { RustTVariableNode new setName: 'nil' }.

		"If there is a variable we should epand the message as a statement"
		blockWithPossibleArgument args notEmpty ifTrue: [ 
			^ RustTStmtListNode new
				setArguments: #();
				setStatements: {
					RustTAssignmentNode new
						setVariable: (RustTVariableNode new setName: blockWithPossibleArgument args first)
						expression: expression.
		
					RustTSendNode new
						setSelector: usedSelector
						receiver: rcvrOrNil
						arguments: args
				};
				yourself
		 ] ].
	
	(usedSelector == #ifNil:ifNotNil:) ifTrue: [
		usedSelector := #ifTrue:ifFalse:.
		rcvrOrNil := RustTSendNode new
			setSelector: #==
			receiver: rcvrOrNil
			arguments: { RustTVariableNode new setName: 'nil' } ].
	
	(usedSelector == #ifTrue:ifFalse: and: [arguments first statements isEmpty]) ifTrue:
		[usedSelector := #ifFalse:. args := {args last}].
	(usedSelector == #ifTrue:ifFalse: and: [arguments last statements isEmpty]) ifTrue:
		[usedSelector := #ifTrue:. args := {args first}].
	(usedSelector == #ifFalse:ifTrue: and: [arguments first statements isEmpty]) ifTrue:
		[usedSelector := #ifTrue:. args := {args last}].
	(usedSelector == #ifFalse:ifTrue: and: [arguments last statements isEmpty]) ifTrue:
		[usedSelector := #ifTrue:. args := {args first}].
	
	((usedSelector == #ifFalse: or: [usedSelector == #or:])
	 and: [arguments size = 2 and: [(arguments at: 2) notNil]]) ifTrue:
		["Restore argument block that got moved by transformOr: or transformIfFalse:"
		 args := {(arguments at: 2) asRustTranslatorNodeIn: aTMethod}].
	(args size > usedSelector numArgs and: [usedSelector ~~ #to:by:do:]) ifTrue: "to:by:do: has iLimiT hidden in last arg"
		["prune the extra blocks left by ifTrue:, ifFalse:, and: & or:"
		 self assert: args size - usedSelector numArgs = 1.
		 self assert: (args last isStmtList
					  and: [args last statements size = 1
					  and: [(args last statements first isVariable
							or: [args last statements first isConstant])
					  and: [#('nil' true false) includes: args last statements first nameOrValue]]]).
		 args := args first: usedSelector numArgs].
	
	((RustCodeGenerator isVarargsSelector: usedSelector)
	 and: [args last isCollection
	 and: [args last isSequenceable]]) ifTrue:
		[args := args allButLast, args last].
	^RustTSendNode new
		setSelector: usedSelector
		receiver: rcvrOrNil
		arguments: args
]
