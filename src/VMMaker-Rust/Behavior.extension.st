Extension { #name : #Behavior }

{ #category : #'*VMMaker-Rust' }
Behavior >> asRustType [
	^ RustClassType new typeClass: self
]

{ #category : #'*VMMaker-Rust' }
Behavior >> rustInstanceVariableDeclariation [
	^#()
]

{ #category : #'*VMMaker-Rust' }
Behavior >> rustInstanceVariableTypeOf: aVariableName [
	<return: #RustTypedValue>

	^ self rustInstanceVariableDeclariation
		detect: [ :anAssociation | anAssociation key = aVariableName ]
		ifFound: [ :anAssociation | anAssociation value asRustType ]
		ifNone: [ RustUnknownType new ]
]
