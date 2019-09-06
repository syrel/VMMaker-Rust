Extension { #name : #RBVariableNode }

{ #category : #'*VMMaker-Rust' }
RBVariableNode >> asRustTranslatorNodeIn: aTMethod [
	"Answer a TParseNode subclass equivalent of me"
	name = 'true' ifTrue: [^ RustTConstantNode new setValue: true].
	name = 'false' ifTrue: [^ RustTConstantNode new setValue: false].
	^ RustTVariableNode new setName: name
]
