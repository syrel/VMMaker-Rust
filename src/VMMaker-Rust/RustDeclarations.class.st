Class {
	#name : #RustDeclarations,
	#superclass : #Object,
	#instVars : [
		'declarations'
	],
	#category : #'VMMaker-Rust-Declarations'
}

{ #category : #'api - accessing' }
RustDeclarations >> addDeclaration: aDeclaration [
	self
		declarationAt: aDeclaration variableName
		put: aDeclaration
]

{ #category : #'api - copying' }
RustDeclarations >> asArray [
	<return: #Array of: #RustDeclaration>

	self assertDeclarations.

	^ declarations values asArray
]

{ #category : #asserting }
RustDeclarations >> assertDeclarations [

	self 
		assert: [ (declarations keys allSatisfy: #isSymbol) ]
		description: [ 'All variable names must be symbols' ].
		
	self 
		assert: [ (declarations values allSatisfy: [ :eachDeclaration | eachDeclaration isKindOf: RustDeclaration ]) ]
		description: [ 'All declarations must be reified' ].
]

{ #category : #'api - copying' }
RustDeclarations >> copyWithoutAllNamed: aCollectionOfNames [
	"Return declarations that are not named like given ones"
	<return: #RustDeclarations>

	| aCopy aSetOfNames |
	self
		assert: [ aCollectionOfNames allSatisfy: #isSymbol ]
		description: [ 'All must be symbols' ].
		
	aCopy := self class new.
	aSetOfNames := aCollectionOfNames asSet.
	
	self declarationsDo: [ :eachDeclaration |
		(aSetOfNames includes: eachDeclaration variableName)
			ifFalse: [ aCopy addDeclaration: eachDeclaration ] ].

	^ aCopy
]

{ #category : #'api - accessing' }
RustDeclarations >> declarationAt: aVariableName [
	<return: #RustDeclaration>
	
	self
		assert: [ aVariableName isSymbol ]
		description: [ 'Variable name must be a symbol' ].
		
	self assertDeclarations.

	^ declarations at: aVariableName
		ifAbsent: [ RustDeclaration new
			variableName: aVariableName;
			variableType: RustUnknownType new ]
]

{ #category : #'api - accessing' }
RustDeclarations >> declarationAt: aVariableName ifAbsent: absentBlock [
	<return: #RustDeclaration>
	
	self
		assert: [ aVariableName isSymbol ]
		description: [ 'Variable name must be a symbol' ].

	self assertDeclarations.

	^ declarations at: aVariableName ifAbsent: absentBlock
]

{ #category : #'api - accessing' }
RustDeclarations >> declarationAt: aVariableName ifPresent: presentBlock [
	<return: #RustDeclaration>
	
	self
		assert: [ aVariableName isSymbol ]
		description: [ 'Variable name must be a symbol' ].
	
	self assertDeclarations.

	^ declarations at: aVariableName ifPresent: presentBlock
]

{ #category : #'api - accessing' }
RustDeclarations >> declarationAt: aVariableName ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	<return: #Object>

	self
		assert: [ aVariableName isSymbol ]
		description: [ 'Variable name must be a symbol' ].

	self assertDeclarations.

	^ declarations
		at: aVariableName
		ifPresent: aPresentBlock
		ifAbsent: anAbsentBlock
]

{ #category : #'api - accessing' }
RustDeclarations >> declarationAt: aVariableName put: aDeclaration [
	<return: #RustDeclaration>

	self
		assert: [ aVariableName isSymbol ]
		description: [ 'Variable name must be a symbol' ].

	self
		assert: [ aDeclaration isKindOf: RustDeclaration ]
		description: [ 'Must be a declaration' ].

	self assertDeclarations.

	^ declarations at: aVariableName put: aDeclaration
]

{ #category : #'api - accessing' }
RustDeclarations >> declarationNames [
	<return: #Set of: #Symbol>
	
	self assertDeclarations.
	
	^ declarations keys asSet
]

{ #category : #'api - enumerating' }
RustDeclarations >> declarationsDo: aBlock [
	declarations do: aBlock
]

{ #category : #'api - enumerating' }
RustDeclarations >> do: elementBlock separatedBy: separatorBlock [
	declarations do: elementBlock separatedBy: separatorBlock
]

{ #category : #'api - testing' }
RustDeclarations >> hasDeclarationAt: aVariableName [
	<return: #Boolean>

	self
		assert: [ aVariableName isSymbol ]
		description: [ 'Variable name must be a symbol' ].

	self assertDeclarations.

	^ declarations includesKey: aVariableName
]

{ #category : #'api - testing' }
RustDeclarations >> ifNotEmpty: aBlock [
	^ self asArray ifNotEmpty: aBlock
]

{ #category : #initialization }
RustDeclarations >> initialize [
	super initialize.
	
	declarations := Dictionary new
]

{ #category : #'api - testing' }
RustDeclarations >> isEmpty [
	<return: #Boolean>

	^ declarations isEmpty
]

{ #category : #'api - accessing' }
RustDeclarations >> removeDeclarationAt: aVariableName [
	self
		assert: [ aVariableName isSymbol ]
		description: [ 'Variable name must be a symbol' ].

	self assertDeclarations.

	declarations
		removeKey: aVariableName
		ifAbsent: [ ]
]
