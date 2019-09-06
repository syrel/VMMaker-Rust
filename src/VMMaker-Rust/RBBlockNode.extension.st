Extension { #name : #RBBlockNode }

{ #category : #'*VMMaker-Rust' }
RBBlockNode >> asRustTranslatorNodeIn: aTMethod [
	"Answer a TParseNode subclass equivalent of me"
	| statementList |
	statementList := OrderedCollection new.
	body statements do:
		[:s | | newS |
		 newS := s asRustTranslatorNodeIn: aTMethod.
		 "inline the statement list returned when a CascadeNode is translated and/or when ifNotNil: is transformed"
		 newS isStmtList
			ifTrue:  [statementList addAll: newS statements]
			ifFalse: [statementList add: newS]].
	statementList ifEmpty: [ 
		statementList add: (RustTVariableNode new setName: 'nil').
	].
	^RustTStmtListNode new
		setArguments: (arguments asArray collect: [:arg | arg name])
		statements: statementList;
		comment: self commentOrNil
]
