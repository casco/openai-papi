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
			'You are a scientific editor and writing style corrector. When you are asked to criticise a paragraph, you respond with a comprehensive critique using plain language, and you offer an improved version. To separate the critic from the improved version, use the ASCII character 124. Now, criticise this paragraph "';
		nextPutAll: aString;
		nextPutAll: '"'.
	^ strm contents
]

{ #category : #api }
WritingStyleCritic >> complete: aString [

	| response |
	response := (super complete: aString) splitOn: $|.
	^ Dictionary new
		  at: 'critic' put: response first;
		  at: 'inproved' put: response second;
		  yourself
]
