Class {
	#name : #RustCodeGeneratorInlineNeverStrategy,
	#superclass : #RustCodeGeneratorAbsoluteInlineStrategy,
	#category : #'VMMaker-Rust'
}

{ #category : #asserting }
RustCodeGeneratorInlineNeverStrategy >> shouldInlineMethod: aMethod [

	^ false
]
