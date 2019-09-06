Extension { #name : #RBLiteralNode }

{ #category : #'*VMMaker-Rust' }
RBLiteralNode >> asRustTranslatorNodeIn: aTMethod [
	"Answer a TParseNode subclass equivalent of me"

	^RustTConstantNode new setValue: self value
]
