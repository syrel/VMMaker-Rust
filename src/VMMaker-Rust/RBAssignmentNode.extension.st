Extension { #name : #RBAssignmentNode }

{ #category : #'*VMMaker-Rust' }
RBAssignmentNode >> asRustTranslatorNodeIn: aTMethod [
	"Answer a TParseNode subclass equivalent of me"
	| varNode valueNode |
	varNode := variable asRustTranslatorNodeIn: aTMethod.
	valueNode := value asRustTranslatorNodeIn: aTMethod.
	valueNode isStmtList ifFalse:
		[^RustTAssignmentNode new
			setVariable: varNode
			expression: valueNode;
			comment: self commentOrNil].
	 "This is a super expansion.  We are in trouble if any statement other than the last is a return."
	(self anyReturns: valueNode statements allButLast) ifTrue:
		[self error: 'haven''t implemented pushing down assignments into other than the last return'].
	"As of 6/25/2012 19:30 superExpansionNodeFor:args: elides the final return."
	self assert: valueNode statements last isReturn not.
	^RustTStmtListNode new
		setStatements: valueNode statements allButLast,
					{ RustTAssignmentNode new
						setVariable: varNode
						expression: valueNode statements last;
						comment: self commentOrNil };
		yourself
]
