Extension { #name : #Behavior }

{ #category : #'*VMMaker-Rust' }
Behavior >> rustInstanceVariableTypeOf: aVariableName [
	<return: #RustTypedValue>

	^ RustUnknownType new
]
