Class {
	#name : #RustVMMaker,
	#superclass : #VMMaker,
	#category : #'VMMaker-Rust'
}

{ #category : #initialize }
RustVMMaker >> createCodeGenerator [
	"Set up a CCodeGenerator for this VMMaker - A cross platform tree leaves it up to the makefiles to decide whether to use the global struct or not."
	^RustCodeGenerator new
		vmMaker: self;
		logger: logger;
		options: optionsDictionary;
		yourself
]

{ #category : #'target directories' }
RustVMMaker >> externalPluginListName [
	"Answer the filename for the list of external plugins. Since we're leaving it up to
	 platform makefiles to specify the actual named prims, just produce an example file."

	^'examplePlugins.ext'
]

{ #category : #'target directories' }
RustVMMaker >> internalPluginListName [
	"Answer the filename for the list of internal plugins. Since we're leaving it up to
	 platform makefiles to specify the actual named prims, just produce an example file."

	^'examplePlugins.int'
]

{ #category : #'target directories' }
RustVMMaker >> internalPluginsDirectory [
	"For the Cross-platfrorm all-in-one tree we simply use <root>/src/plugins, not <root>/src/intplugins"
	^self externalPluginsDirectory
]

{ #category : #'generate sources' }
RustVMMaker >> interpreterExportsFilePath [
	"Return the full path for the interpreter exports file.  Since we're leaving it up to
	 platform makefiles to specify the actual named prims, just produce an example file."
	^self coreVMHeadersDirectory fullNameFor: 'exampleSqNamedPrims.h'
]

{ #category : #'generate sources' }
RustVMMaker >> validatePlugin: plName in: listOfPlugins [
	"Check that the class for the plugin exists, and answer that class.
	 No longer check that if the plugin requires platform files that at least
	 one platform subdirectory exists, not producing the source is not helpful."
	| plugin |
	plName isString
		ifTrue: [(listOfPlugins includes: plName)
				ifTrue: [plugin := Smalltalk classNamed: plName]]
		ifFalse: [((plName isBehavior
						and: [plName inheritsFrom: InterpreterPlugin])
					and: [listOfPlugins includes: plName name])
				ifTrue: [plugin := plName]].
	plugin ifNil: [^ self couldNotFindPluginClass: plName].
	plugin shouldBeTranslated ifFalse:
		[self error: 'untranslateable plugin class ', plName].
	^plugin
]
