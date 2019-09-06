Class {
	#name : #RustTLabeledCommentNode,
	#superclass : #RustTParseNode,
	#instVars : [
		'label',
		'asmLabel'
	],
	#category : #'VMMaker-Rust'
}

{ #category : #accessing }
RustTLabeledCommentNode >> asmLabel [

	^asmLabel
]

{ #category : #accessing }
RustTLabeledCommentNode >> asmLabel: labelString [

	asmLabel := labelString
]

{ #category : #'C code generation' }
RustTLabeledCommentNode >> emitCCodeOn: aStream level: level generator: aCodeGen [
	"Emit a C comment with optional label."

	self printOptionalLabelOn: aStream.
	comment ifNotNil:
		[(aCodeGen previousCommentMarksInlining: (label isNil and: [asmLabel isNil and: [comment beginsWith: 'begin ']])) ifTrue:
			[^true].
		 aStream nextPutAll: '/* '; nextPutAll: comment; nextPutAll: ' */'.
		 aCodeGen previousCommenter: self].
	(asmLabel notNil "only output labels in the interpret function."
	 and: [aCodeGen currentMethod selector == #interpret]) ifTrue:
		[aStream crtab: level.
		 aCodeGen outputAsmLabel: asmLabel on: aStream]
]

{ #category : #'C code generation' }
RustTLabeledCommentNode >> emitCCommentOn: aStream level: level generator: aCodeGen [
	"Override to avoid outputting comments since this is done explicitly in statement lists."
]

{ #category : #testing }
RustTLabeledCommentNode >> isComment [
	"Answer true if the receiver is just a comment (i.e., it has no label)."

	^label = nil
]

{ #category : #testing }
RustTLabeledCommentNode >> isLabel [

	^true
]

{ #category : #testing }
RustTLabeledCommentNode >> isLeaf [

	^true
]

{ #category : #accessing }
RustTLabeledCommentNode >> label [

	^label
]

{ #category : #testing }
RustTLabeledCommentNode >> needsTrailingSemicolon [
	"Answer if, when emitted as a statement (in particular in a TStmtList), the
	 receiver needs a trailing semicolon.  Comments do not.  You'd think that
	 labels do not, but we put them at the end of blocks where there needs
	 to be a null statement following the label and before the end of block."
	^self isComment not
]

{ #category : #enumerating }
RustTLabeledCommentNode >> nodesDo: aBlock parent: parent [
	aBlock value: self value: parent
]

{ #category : #printing }
RustTLabeledCommentNode >> printOn: aStream level: level [

	self printOptionalLabelOn: aStream.
	comment ifNotNil:
		[aStream nextPut: $".
		 aStream nextPutAll: comment.
		 aStream nextPut: $"]
]

{ #category : #printing }
RustTLabeledCommentNode >> printOptionalLabelOn: aStream [

	label ifNotNil:
		[self unindentTabs: aStream.
		 aStream
			nextPutAll: label;
			nextPut: $:;
			tab]
]

{ #category : #accessing }
RustTLabeledCommentNode >> setComment: commentString [

	label := nil.
	comment := commentString.
]

{ #category : #accessing }
RustTLabeledCommentNode >> setLabel: labelString [

	label := labelString.
]

{ #category : #accessing }
RustTLabeledCommentNode >> setLabel: labelString comment: commentString [

	label := labelString.
	comment := commentString.
]

{ #category : #'C code generation' }
RustTLabeledCommentNode >> unindentTabs: aStream [
	"Remove all but one tab up to the beginning of line from the given stream if possible."

	(aStream isKindOf: ReadWriteStream) ifFalse: [ ^self ].
	[aStream position > 0] whileTrue:
		[aStream position: aStream position - 1.
		 "restore stream position if previous char was not a tab"
		 aStream peek == Character tab ifFalse:
			[^aStream next; tab]]
]
