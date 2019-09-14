Extension { #name : #RBVariableNode }

{ #category : #'*VMMaker-Rust' }
RBVariableNode >> asRustTranslatorNodeIn: aTMethod [
	"Answer a TParseNode subclass equivalent of me"
	name = 'true'
		ifTrue: [ ^ RustTConstantNode new setValue: true ].
	name = 'false'
		ifTrue: [ ^ RustTConstantNode new setValue: false ].
		
	(aTMethod hasInstanceVariableNamed: name asSymbol)
		ifTrue: [ ^ RustInstanceVariableReferenceNode new setName: name asSymbol ].
		
	(aTMethod hasConstantNamed: name asSymbol)
		ifTrue: [ ^ RustConstantReferenceNode new
			definingClass: aTMethod definingClass;
			setName: name asSymbol ].
		
	(Smalltalk environment
		at: name asSymbol
		ifPresent: [ :anObject |
			anObject isClass
				ifTrue: [
					^ RustClassReferenceNode new
						referencedClass: anObject;
						setName: name asSymbol ] ]).

	^ RustTVariableNode new setName: name
]
