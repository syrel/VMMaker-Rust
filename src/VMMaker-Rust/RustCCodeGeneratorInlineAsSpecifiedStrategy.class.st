Class {
	#name : #RustCCodeGeneratorInlineAsSpecifiedStrategy,
	#superclass : #RustCCodeGeneratorInlineStrategy,
	#instVars : [
		'selectorsOfMethodsNotToInline'
	],
	#category : #'VMMaker-Rust'
}

{ #category : #'as yet unclassified' }
RustCCodeGeneratorInlineAsSpecifiedStrategy >> initialize [

	super initialize.
	selectorsOfMethodsNotToInline := Set new.
]

{ #category : #asserting }
RustCCodeGeneratorInlineAsSpecifiedStrategy >> isSelectiveInlineStrategy [

	^ true
]

{ #category : #'as yet unclassified' }
RustCCodeGeneratorInlineAsSpecifiedStrategy >> noteSelectorNotToInline: aSelector [
	
	selectorsOfMethodsNotToInline add: aSelector
]

{ #category : #'as yet unclassified' }
RustCCodeGeneratorInlineAsSpecifiedStrategy >> noteSelectorsNotToInline: selectors [
	
	selectorsOfMethodsNotToInline addAll: selectors
]

{ #category : #asserting }
RustCCodeGeneratorInlineAsSpecifiedStrategy >> shouldInlineMethod: aMethod [

	^ (super shouldInlineMethod: aMethod) and: [ self wantsInline: aMethod ]
]

{ #category : #'as yet unclassified' }
RustCCodeGeneratorInlineAsSpecifiedStrategy >> shouldNotInlineSelector: aSelector [
	
	^ selectorsOfMethodsNotToInline includesKey: aSelector
]
