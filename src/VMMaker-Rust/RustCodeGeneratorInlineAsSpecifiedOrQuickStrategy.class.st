Class {
	#name : #RustCodeGeneratorInlineAsSpecifiedOrQuickStrategy,
	#superclass : #RustCodeGeneratorInlineAsSpecifiedStrategy,
	#category : #'VMMaker-Rust'
}

{ #category : #accessing }
RustCodeGeneratorInlineAsSpecifiedOrQuickStrategy >> inlineFlagOrSymbol [
	
	^ #asSpecifiedOrQuick
]

{ #category : #testing }
RustCodeGeneratorInlineAsSpecifiedOrQuickStrategy >> isQuickCompiledMethod: aCompiledMethod [

	^aCompiledMethod isQuick
	 or: [(#(pushConstant: pushLiteralVariable:) includes: (aCompiledMethod abstractBytecodeMessageAt: aCompiledMethod initialPC) selector)
		and: [(aCompiledMethod abstractBytecodeMessageAt: (InstructionStream on: aCompiledMethod) followingPc) selector == #methodReturnTop]]
]

{ #category : #asserting }
RustCodeGeneratorInlineAsSpecifiedOrQuickStrategy >> shouldInlineMethod: aMethod [

	^ (super shouldInlineMethod: aMethod)
		or: [ self isQuickCompiledMethod: aMethod compiledMethod ]
]
