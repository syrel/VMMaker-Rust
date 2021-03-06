Class {
	#name : #RustTPrintfFormatStringNode,
	#superclass : #RustTConstantNode,
	#category : #'VMMaker-Rust-Nodes'
}

{ #category : #'C code generation' }
RustTPrintfFormatStringNode >> emitCCodeOn: aStream level: level generator: aCodeGen [
	"Transform the printf string according to the LP64/LLP64 convention in sqMemoryAccess.h."
	aStream nextPutAll: (aCodeGen cLiteralForPrintfString: value).
	comment ifNotNil:
		[aStream
			nextPutAll: ' /* ';
			nextPutAll: comment;
			nextPutAll: ' */']
]
