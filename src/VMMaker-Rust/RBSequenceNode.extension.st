Extension { #name : #RBSequenceNode }

{ #category : #'*VMMaker-Rust' }
RBSequenceNode >> asRustTranslatorNodeIn: aTMethod [ 
	"Answer a TParseNode subclass equivalent of me"
	| statementList |
	statementList := OrderedCollection new.
	statements do:
		[:s | | newS |
		 newS := s asRustTranslatorNodeIn: aTMethod.
		 "inline the statement list returned when a CascadeNode is translated and/or when ifNotNil: is transformed"
		 newS isStmtList
			ifTrue:  [statementList addAll: newS statements]
			ifFalse: [statementList add: newS]].
	^RustTStmtListNode new
		setArguments: (parent isMethod
							ifTrue: [#()]
							ifFalse: [parent arguments asArray collect: [:arg | arg name]])
		statements: statementList;
		comment: self commentOrNil
]
