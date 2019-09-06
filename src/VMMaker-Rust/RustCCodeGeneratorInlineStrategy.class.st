Class {
	#name : #RustCCodeGeneratorInlineStrategy,
	#superclass : #Object,
	#instVars : [
		'codeGenerator'
	],
	#category : #'VMMaker-Rust'
}

{ #category : #'instance-cre' }
RustCCodeGeneratorInlineStrategy class >> always [
	
	^ RustCCodeGeneratorInlineAlwaysStrategy new
]

{ #category : #converting }
RustCCodeGeneratorInlineStrategy class >> asSpecified [

	^ RustCCodeGeneratorInlineAsSpecifiedStrategy new
]

{ #category : #converting }
RustCCodeGeneratorInlineStrategy class >> asSpecifiedOrQuick [

	^ RustCCodeGeneratorInlineAsSpecifiedOrQuickStrategy new
]

{ #category : #'instance creation' }
RustCCodeGeneratorInlineStrategy class >> from: anObject [
	
	"The argument is either a boolean or a sumbol.
	If a boolean, it indicates if we need to inline or not.
	If == #asSpecified only inline methods marked with <inline: true>.
	If == #asSpecifiedOrQuick only inline methods marked with <inline: true> or methods that are quick (^constant, ^inst var)."
	
	(#(true false) includes: anObject) ifTrue: [ 
		^ anObject
			ifTrue: [ self always ]
			ifFalse: [ self never ].
	].

	"If the object is a selector use a perform to instantiate it."
	^ self perform: anObject
]

{ #category : #'instance-crea' }
RustCCodeGeneratorInlineStrategy class >> never [

	^ RustCCodeGeneratorInlineNeverStrategy new
]

{ #category : #testing }
RustCCodeGeneratorInlineStrategy >> canInline: aTMethod [
	
	^ (self hasUnrenamableCCode: aTMethod) not
		and: [ aTMethod extractInlineDirective ~= false ]
]

{ #category : #accessing }
RustCCodeGeneratorInlineStrategy >> codeGenerator [
	^ codeGenerator
]

{ #category : #accessing }
RustCCodeGeneratorInlineStrategy >> codeGenerator: anObject [
	codeGenerator := anObject
]

{ #category : #testing }
RustCCodeGeneratorInlineStrategy >> hasUnrenamableCCode: aTMethod [

	^ (codeGenerator isSpecialSelector: aTMethod selector)
		or: [ aTMethod hasUnrenamableCCode ]
]

{ #category : #testing }
RustCCodeGeneratorInlineStrategy >> isSelectiveInlineStrategy [
	
	^ false
]

{ #category : #asserting }
RustCCodeGeneratorInlineStrategy >> shouldInlineMethod: aMethod [

	^ self canInline: aMethod
]

{ #category : #asserting }
RustCCodeGeneratorInlineStrategy >> validateCanInline: aMethod [

	((self canInline: aMethod) not
		and: [ self wantsInline: aMethod ]) ifTrue: [
			"don't inline if method has C code or contains negative inline directive"
			codeGenerator cannotInline: aMethod selector ]
]

{ #category : #testing }
RustCCodeGeneratorInlineStrategy >> wantsInline: aTMethod [ 
	
	^ (codeGenerator isSpecialSelector: aTMethod selector) not
		and: [ aTMethod extractInlineDirective == true ]
]
