Class {
	#name : #RustCodeGeneratorInlineAlwaysStrategy,
	#superclass : #RustCodeGeneratorAbsoluteInlineStrategy,
	#category : #'VMMaker-Rust'
}

{ #category : #accessing }
RustCodeGeneratorInlineAlwaysStrategy >> inlineFlagOrSymbol [

	^ true
]

{ #category : #accessing }
RustCodeGeneratorInlineAlwaysStrategy >> nodeCountOfMethod: aTMethod [

	| nodeCount |
	nodeCount := 0.
	aTMethod parseTree nodesDo: [ :node | nodeCount := nodeCount + 1 ].
	^ nodeCount
]

{ #category : #asserting }
RustCodeGeneratorInlineAlwaysStrategy >> shouldInlineMethod: aTMethod [ 

	^ (super shouldInlineMethod: aTMethod) and: [
			(self wantsInline: aTMethod)
				or: [ (self nodeCountOfMethod: aTMethod) < 40 ]]
]
