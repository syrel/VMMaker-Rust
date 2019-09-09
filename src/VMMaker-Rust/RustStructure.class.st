Class {
	#name : #RustStructure,
	#superclass : #Object,
	#instVars : [
		'variables',
		'methods',
		'constants',
		'name'
	],
	#category : #'VMMaker-Rust-Meta'
}

{ #category : #'api - accessing' }
RustStructure >> constantNamed: aName [
	<return: #RustConstant>
	
	self
		assert: [ aName isSymbol ]
		description: [ 'Must be a symbol' ].
	
	^ self constants detect: [ :eachVariable | eachVariable name = aName ]
]

{ #category : #accessing }
RustStructure >> constants [
	^ constants
]

{ #category : #accessing }
RustStructure >> constants: anObject [
	constants := anObject
]

{ #category : #'code generation' }
RustStructure >> emitCodeOn: aStream generator: aCodeGenerator [
	self emitDeclarationOn: aStream generator: aCodeGenerator.
	
	aStream cr; cr.
	
	self emitImplementationOn: aStream generator: aCodeGenerator
]

{ #category : #'code generation' }
RustStructure >> emitConstantsOn: aStream indent: aLevel generator: aCodeGenerator [
	(self constants select: [ :eachConstant | eachConstant value isNotNil ])
		do: [ :eachConstant |
		aStream tab: aLevel.
		aStream nextPutAll: 'const '.
		aStream nextPutAll: eachConstant name asUppercase.
		aStream nextPutAll: ' : '.
		aStream nextPutAll: eachConstant type asRustTypeName.
		aStream nextPutAll: ' = '.
		aStream nextPutAll: eachConstant type asRustLiteral.
		aStream nextPut: $;. ]
		separatedBy: [ aStream cr ]
]

{ #category : #'code generation' }
RustStructure >> emitDeclarationOn: aStream generator: aCodeGenerator [
	aStream nextPutAll: 'pub struct '.
	aStream nextPutAll: self name.
	aStream nextPutAll: ' {'; cr.

	self emitVariablesOn: aStream indent: 1 generator: aCodeGenerator.

	aStream cr; nextPutAll: '}'
]

{ #category : #'code generation' }
RustStructure >> emitImplementationOn: aStream generator: aCodeGenerator [
	aStream nextPutAll: 'impl '.
	aStream nextPutAll: self name.
	aStream nextPutAll: ' {'; cr.

	self emitConstantsOn: aStream indent: 1 generator: aCodeGenerator.
	aStream cr; cr.
	self emitMethodsOn: aStream indent: 1 generator: aCodeGenerator.

	aStream cr; nextPutAll: '}'
]

{ #category : #'code generation' }
RustStructure >> emitMethodsOn: aStream indent: aLevel generator: aCodeGenerator [
	self methods
		do: [ :eachMethod | eachMethod emitCodeOn: aStream level: aLevel generator: aCodeGenerator ]
		separatedBy: [ aStream cr; cr ]
]

{ #category : #'code generation' }
RustStructure >> emitVariablesOn: aStream indent: aLevel generator: aCodeGenerator [
	self variables do: [ :eachVariable |
		aStream tab: aLevel.
		aStream nextPutAll: 'pub '.
		aStream nextPutAll: eachVariable name.
		aStream nextPutAll: ' : '.
		aStream nextPutAll: eachVariable type asRustTypeName ]
		separatedBy: [ aStream nextPut: $,; cr ]
]

{ #category : #'api- testing' }
RustStructure >> hasConstantNamed: aName [
	<return: #Boolean>
	
	self
		assert: [ aName isSymbol ]
		description: [ 'Must be a symbol' ].
	
	^ self constants
		detect: [ :eachConstant | eachConstant name = aName ]
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : #'api- testing' }
RustStructure >> hasInstanceVariableNamed: aName [
	<return: #Boolean>
	
	self
		assert: [ aName isSymbol ]
		description: [ 'Must be a symbol' ].
	
	^ self variables
		detect: [ :eachVariable | eachVariable name = aName ]
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : #initialization }
RustStructure >> initialize [
	super initialize.
	
	name := 'Structure'.
	constants := #().
	variables := #().
	methods := #().
]

{ #category : #accessing }
RustStructure >> methods [
	^ methods
]

{ #category : #accessing }
RustStructure >> methods: anObject [
	methods := anObject
]

{ #category : #accessing }
RustStructure >> name [
	^ name
]

{ #category : #accessing }
RustStructure >> name: anObject [
	name := anObject
]

{ #category : #'api - accessing' }
RustStructure >> variableNamed: aName [
	<return: #RustInstanceVariable>
	
	self
		assert: [ aName isSymbol ]
		description: [ 'Must be a symbol' ].
	
	^ self variables detect: [ :eachVariable | eachVariable name = aName ]
]

{ #category : #accessing }
RustStructure >> variables [
	^ variables
]

{ #category : #accessing }
RustStructure >> variables: anObject [
	variables := anObject
]
