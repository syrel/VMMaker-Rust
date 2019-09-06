Extension { #name : #RBProgramNode }

{ #category : #'*VMMaker-Rust' }
RBProgramNode >> asRustTranslatorNodeIn: aTMethod [
	"Answer a RustTParseNode subclass equivalent of me"

	self subclassResponsibility
]
