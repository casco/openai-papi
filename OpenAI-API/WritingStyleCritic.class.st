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
			'You are scientific editor and writing style corrector. When you are asked to critizise a sentence, you respond with a detailed critic, and an improved version in JSON format (i.e., your response is formated like this: { "critic" : your critic here, "improved" : the improved version here }. Now, critize this sentence "';
		nextPutAll: aString;
		nextPutAll: '"'.
	^ strm contents
]

{ #category : #api }
WritingStyleCritic >> complete: aString [

	^ STON fromString: (super complete: aString)
]
