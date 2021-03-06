Extension { #name : #RBCascadeNode }

{ #category : #'*VMMaker-Rust' }
RBCascadeNode >> asRustTranslatorNodeIn: aTMethod [
	"Answer a TParseNode subclass equivalent of me."
	^RustTStmtListNode new
		setArguments: #()
		statements:
			(Array streamContents:
				[:s| | receiverNode |
				receiverNode := messages first receiver asRustTranslatorNodeIn: aTMethod.
				"don't expand the receiver if it is a send to get an implicit receiver,
				 e.g self interpreter printHex: oop => printHex(oop), /not/ printHex(cascade0,oop)."
				(receiverNode isSend and: [aTMethod definingClass isNonArgumentImplicitReceiverVariableName: receiverNode selector]) ifTrue:
					[receiverNode := RustTVariableNode new setName: receiverNode selector].
				receiverNode isLeaf ifFalse:
					[| varNode |
					 varNode := aTMethod newCascadeTempFor: receiverNode.
					 s nextPut: (RustTAssignmentNode new
								setVariable: varNode
								expression: receiverNode).
					receiverNode := varNode].
				messages do:
					[ :msg | s nextPut: ((msg asRustTranslatorNodeIn: aTMethod) receiver: receiverNode)]]);
		comment: self commentOrNil
]
