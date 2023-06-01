Class {
	#name : #WritingStyleCritic,
	#superclass : #CompletionClient,
	#category : #'OpenAI-API'
}

{ #category : #api }
WritingStyleCritic >> buildPromptWith: aString [

	| strm |
	strm := String new writeStream.
	strm
		nextPutAll:
			'You are a scientific editor and writing style corrector. When you are asked to criticise a paragraph you respond a comprehensive critique using plain language, and you offer an improved version. Now, criticise this paragraph "';
		nextPutAll: aString;
		nextPutAll: '"'.
	^ strm contents
]
