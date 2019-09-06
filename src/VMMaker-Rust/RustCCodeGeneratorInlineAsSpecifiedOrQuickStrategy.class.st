Class {
	#name : #RustCCodeGeneratorInlineAsSpecifiedOrQuickStrategy,
	#superclass : #RustCCodeGeneratorInlineAsSpecifiedStrategy,
	#category : #'VMMaker-Rust'
}

{ #category : #accessing }
RustCCodeGeneratorInlineAsSpecifiedOrQuickStrategy >> inlineFlagOrSymbol [
	
	^ #asSpecifiedOrQuick
]

{ #category : #testing }
RustCCodeGeneratorInlineAsSpecifiedOrQuickStrategy >> isQuickCompiledMethod: aCompiledMethod [

	^aCompiledMethod isQuick
	 or: [(#(pushConstant: pushLiteralVariable:) includes: (aCompiledMethod abstractBytecodeMessageAt: aCompiledMethod initialPC) selector)
		and: [(aCompiledMethod abstractBytecodeMessageAt: (InstructionStream on: aCompiledMethod) followingPc) selector == #methodReturnTop]]
]

{ #category : #asserting }
RustCCodeGeneratorInlineAsSpecifiedOrQuickStrategy >> shouldInlineMethod: aMethod [

	^ (super shouldInlineMethod: aMethod)
		or: [ self isQuickCompiledMethod: aMethod compiledMethod ]
]
