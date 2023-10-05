Class {
	#name : #SlrAssistant,
	#superclass : #CompletionClient,
	#instVars : [
		'slr'
	],
	#category : #'OpenAI-API'
}

{ #category : #api }
SlrAssistant >> buildPromptWith: aString [

	| strm |
	strm := String new writeStream.
	strm
		nextPutAll:
			'You are an expert in systematic literature reviews in computers science. You''ve been asked to help a student working on a review characterized as follows:';
		crlf;
		nextPutAll: slr printString;
		crlf;
		nextPutAll: aString.

	^ strm contents
]

{ #category : #api }
SlrAssistant >> criticizeResearchQuestions [

	^ self complete:
		  'Critizise the research questions and suggest improvements with arguments supporting your suggestions.'
]

{ #category : #initialize }
SlrAssistant >> initialize [

	super initialize.
	maxTokens := 6000.
	model := 'babbage-002'
]

{ #category : #accessing }
SlrAssistant >> slr [

	^ slr
]

{ #category : #accessing }
SlrAssistant >> slr: anObject [

	slr := anObject
]
