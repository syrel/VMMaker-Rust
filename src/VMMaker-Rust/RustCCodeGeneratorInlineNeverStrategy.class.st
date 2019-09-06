Class {
	#name : #RustCCodeGeneratorInlineNeverStrategy,
	#superclass : #RustCCodeGeneratorAbsoluteInlineStrategy,
	#category : #'VMMaker-Rust'
}

{ #category : #asserting }
RustCCodeGeneratorInlineNeverStrategy >> shouldInlineMethod: aMethod [

	^ false
]
