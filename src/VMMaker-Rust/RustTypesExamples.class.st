Class {
	#name : #RustTypesExamples,
	#superclass : #Object,
	#category : #'VMMaker-Rust-Examples'
}

{ #category : #types }
RustTypesExamples >> false [
	<gtExample>
	| aType |
	
	aType := false asRustType.
	self assert: aType equals: (RustBoolean value: false).

	^ aType
]

{ #category : #types }
RustTypesExamples >> negative1 [
	<gtExample>
	| aType |
	
	aType := -1 asRustType.
	self assert: aType equals: (RustInt8 value: -1).

	^ aType
]

{ #category : #types }
RustTypesExamples >> negative128 [
	<gtExample>
	| aType |
	
	aType := -128 asRustType.
	self assert: aType equals: (RustInt8 value: -128).

	^ aType
]

{ #category : #types }
RustTypesExamples >> negative129 [
	<gtExample>
	| aType |
	
	aType := -129 asRustType.
	self assert: aType equals: (RustInt16 value: -129).

	^ aType
]

{ #category : #types }
RustTypesExamples >> negative2147483648 [
	<gtExample>
	| aType |
	
	aType := -2147483648 asRustType.
	self assert: aType equals: (RustInt32 value: -2147483648).

	^ aType
]

{ #category : #types }
RustTypesExamples >> negative2147483649 [
	<gtExample>
	| aType |
	
	aType := -2147483649 asRustType.
	self assert: aType equals: (RustInt64 value: -2147483649).

	^ aType
]

{ #category : #types }
RustTypesExamples >> negative32768 [
	<gtExample>
	| aType |
	
	aType := -32768 asRustType.
	self assert: aType equals: (RustInt16 value: -32768).

	^ aType
]

{ #category : #types }
RustTypesExamples >> negative32769 [
	<gtExample>
	| aType |
	
	aType := -32769 asRustType.
	self assert: aType equals: (RustInt32 value: -32769).

	^ aType
]

{ #category : #types }
RustTypesExamples >> negative9223372036854775808 [
	<gtExample>
	| aType |

	aType := -9223372036854775808 asRustType.
	self assert: aType equals: (RustInt64 value: -9223372036854775808).

	^ aType
]

{ #category : #types }
RustTypesExamples >> negative9223372036854775809 [
	<gtExample>
	| aType |

	"exceeds 64 bit range"
	aType := -9223372036854775809 asRustType.
	self assert: aType equals: (RustUnknownType value: -9223372036854775809).

	^ aType
]

{ #category : #types }
RustTypesExamples >> positive1 [
	<gtExample>
	| aType |

	aType := 1 asRustType.
	self assert: aType equals: (RustInt8 value: 1).

	^ aType
]

{ #category : #types }
RustTypesExamples >> positive127 [
	<gtExample>
	| aType |

	aType := 127 asRustType.
	self assert: aType equals: (RustInt8 value: 127).

	^ aType
]

{ #category : #types }
RustTypesExamples >> positive128 [
	<gtExample>
	| aType |

	aType := 128 asRustType.
	self assert: aType equals: (RustInt16 value: 128).

	^ aType
]

{ #category : #types }
RustTypesExamples >> positive2147483647 [
	<gtExample>
	| aType |

	aType := 2147483647 asRustType.
	self assert: aType equals: (RustInt32 value: 2147483647).

	^ aType
]

{ #category : #types }
RustTypesExamples >> positive2147483648 [
	<gtExample>
	| aType |

	aType := 2147483648 asRustType.
	self assert: aType equals: (RustInt64 value: 2147483648).

	^ aType
]

{ #category : #types }
RustTypesExamples >> positive255 [
	<gtExample>
	| aType |

	aType := 255 asRustType.
	self assert: aType equals: (RustInt16 value: 255).

	^ aType
]

{ #category : #types }
RustTypesExamples >> positive32767 [
	<gtExample>
	| aType |

	aType := 32767 asRustType.
	self assert: aType equals: (RustInt16 value: 32767).

	^ aType
]

{ #category : #types }
RustTypesExamples >> positive32768 [
	<gtExample>
	| aType |

	aType := 32768 asRustType.
	self assert: aType equals: (RustInt32 value: 32768).

	^ aType
]

{ #category : #types }
RustTypesExamples >> positive9223372036854775807 [
	<gtExample>
	| aType |

	aType := 9223372036854775807 asRustType.
	self assert: aType equals: (RustInt64 value: 9223372036854775807).

	^ aType
]

{ #category : #types }
RustTypesExamples >> positive9223372036854775808 [
	<gtExample>
	| aType |

	aType := 9223372036854775808 asRustType.
	self assert: aType equals: (RustUnknownType value: 9223372036854775808).

	^ aType
]

{ #category : #types }
RustTypesExamples >> string [
	<gtExample>
	| aType |
	
	aType := 'Hello' asRustType.
	self assert: aType equals: (RustString value: 'Hello').

	^ aType
]

{ #category : #types }
RustTypesExamples >> symbol [
	<gtExample>
	| aType |
	
	aType := #Hello asRustType.
	self assert: aType equals: (RustUnknownType value: #Hello).

	^ aType
]

{ #category : #types }
RustTypesExamples >> true [
	<gtExample>
	| aType |
	
	aType := true asRustType.
	self assert: aType equals: (RustBoolean value: true).

	^ aType
]

{ #category : #types }
RustTypesExamples >> zero [
	<gtExample>
	| aType |
	
	aType := 0 asRustType.
	self assert: aType equals: (RustInt8 value: 0).

	^ aType
]
