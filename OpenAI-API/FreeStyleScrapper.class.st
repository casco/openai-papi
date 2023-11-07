Class {
	#name : #FreeStyleScrapper,
	#superclass : #CompletionClient,
	#category : #'OpenAI-API-Completion'
}

{ #category : #api }
FreeStyleScrapper >> buildPromptWith: aString [

	| strm |
	strm := String new writeStream.
	strm
		nextPutAll:
			'Using semantic tags from Schema.org, build a JSON object with data obtained from the following text: "';
		nextPutAll: aString;
		nextPutAll: '"'.
	^ strm contents
]
