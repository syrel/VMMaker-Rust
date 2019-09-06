Class {
	#name : #RustCodeGeneratorInlineStrategy,
	#superclass : #Object,
	#instVars : [
		'codeGenerator'
	],
	#category : #'VMMaker-Rust'
}

{ #category : #'instance-cre' }
RustCodeGeneratorInlineStrategy class >> always [
	
	^ RustCodeGeneratorInlineAlwaysStrategy new
]

{ #category : #converting }
RustCodeGeneratorInlineStrategy class >> asSpecified [

	^ RustCodeGeneratorInlineAsSpecifiedStrategy new
]

{ #category : #converting }
RustCodeGeneratorInlineStrategy class >> asSpecifiedOrQuick [

	^ RustCodeGeneratorInlineAsSpecifiedOrQuickStrategy new
]

{ #category : #'instance creation' }
RustCodeGeneratorInlineStrategy class >> from: anObject [
	
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
RustCodeGeneratorInlineStrategy class >> never [

	^ RustCodeGeneratorInlineNeverStrategy new
]

{ #category : #testing }
RustCodeGeneratorInlineStrategy >> canInline: aTMethod [
	
	^ (self hasUnrenamableCCode: aTMethod) not
		and: [ aTMethod extractInlineDirective ~= false ]
]

{ #category : #accessing }
RustCodeGeneratorInlineStrategy >> codeGenerator [
	^ codeGenerator
]

{ #category : #accessing }
RustCodeGeneratorInlineStrategy >> codeGenerator: anObject [
	codeGenerator := anObject
]

{ #category : #testing }
RustCodeGeneratorInlineStrategy >> hasUnrenamableCCode: aTMethod [

	^ (codeGenerator isSpecialSelector: aTMethod selector)
		or: [ aTMethod hasUnrenamableCCode ]
]

{ #category : #testing }
RustCodeGeneratorInlineStrategy >> isSelectiveInlineStrategy [
	
	^ false
]

{ #category : #asserting }
RustCodeGeneratorInlineStrategy >> shouldInlineMethod: aMethod [

	^ self canInline: aMethod
]

{ #category : #asserting }
RustCodeGeneratorInlineStrategy >> validateCanInline: aMethod [

	((self canInline: aMethod) not
		and: [ self wantsInline: aMethod ]) ifTrue: [
			"don't inline if method has C code or contains negative inline directive"
			codeGenerator cannotInline: aMethod selector ]
]

{ #category : #testing }
RustCodeGeneratorInlineStrategy >> wantsInline: aTMethod [ 
	
	^ (codeGenerator isSpecialSelector: aTMethod selector) not
		and: [ aTMethod extractInlineDirective == true ]
]
