Extension { #name : #RBArrayNode }

{ #category : #'*VMMaker-Rust' }
RBArrayNode >> asRustTranslatorNodeIn: aTMethod [
	"Answer a TParseNode subclass equivalent of me."

	"This is for case statements"
	(statements allSatisfy: [:elem| elem isMessage and: [elem selector = #->]]) ifTrue:
		[self assert: (statements allSatisfy:
			[:elem|
			elem receiver isBlockNode
			and: [elem arguments first isBlockNode
			and: [elem receiver isPotentialCCaseLabelIn: aTMethod]]]).
		^ RustTBraceCaseNode new
			caseLabels: (statements collect: [:elem| elem receiver asRustTranslatorNodeIn: aTMethod]);
			cases: (statements collect: [:elem| elem arguments first asRustTranslatorNodeIn: aTMethod]);
			comment: statements].

	"This is for varargs selectors (variants of printf:)"
	^ statements collect: [:elem| elem asRustTranslatorNodeIn: aTMethod]
]
