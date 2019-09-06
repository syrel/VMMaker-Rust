Class {
	#name : #RustCodeGeneratorInlineAsSpecifiedStrategy,
	#superclass : #RustCodeGeneratorInlineStrategy,
	#instVars : [
		'selectorsOfMethodsNotToInline'
	],
	#category : #'VMMaker-Rust'
}

{ #category : #'as yet unclassified' }
RustCodeGeneratorInlineAsSpecifiedStrategy >> initialize [

	super initialize.
	selectorsOfMethodsNotToInline := Set new.
]

{ #category : #asserting }
RustCodeGeneratorInlineAsSpecifiedStrategy >> isSelectiveInlineStrategy [

	^ true
]

{ #category : #'as yet unclassified' }
RustCodeGeneratorInlineAsSpecifiedStrategy >> noteSelectorNotToInline: aSelector [
	
	selectorsOfMethodsNotToInline add: aSelector
]

{ #category : #'as yet unclassified' }
RustCodeGeneratorInlineAsSpecifiedStrategy >> noteSelectorsNotToInline: selectors [
	
	selectorsOfMethodsNotToInline addAll: selectors
]

{ #category : #asserting }
RustCodeGeneratorInlineAsSpecifiedStrategy >> shouldInlineMethod: aMethod [

	^ (super shouldInlineMethod: aMethod) and: [ self wantsInline: aMethod ]
]

{ #category : #'as yet unclassified' }
RustCodeGeneratorInlineAsSpecifiedStrategy >> shouldNotInlineSelector: aSelector [
	
	^ selectorsOfMethodsNotToInline includesKey: aSelector
]
