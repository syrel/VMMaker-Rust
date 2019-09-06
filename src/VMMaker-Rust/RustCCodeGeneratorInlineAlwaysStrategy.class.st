Class {
	#name : #RustCCodeGeneratorInlineAlwaysStrategy,
	#superclass : #RustCCodeGeneratorAbsoluteInlineStrategy,
	#category : #'VMMaker-Rust'
}

{ #category : #accessing }
RustCCodeGeneratorInlineAlwaysStrategy >> inlineFlagOrSymbol [

	^ true
]

{ #category : #accessing }
RustCCodeGeneratorInlineAlwaysStrategy >> nodeCountOfMethod: aTMethod [

	| nodeCount |
	nodeCount := 0.
	aTMethod parseTree nodesDo: [ :node | nodeCount := nodeCount + 1 ].
	^ nodeCount
]

{ #category : #asserting }
RustCCodeGeneratorInlineAlwaysStrategy >> shouldInlineMethod: aTMethod [ 

	^ (super shouldInlineMethod: aTMethod) and: [
			(self wantsInline: aTMethod)
				or: [ (self nodeCountOfMethod: aTMethod) < 40 ]]
]
