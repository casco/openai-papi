"
```language=Pharo
WritingStyleCritic  new complete: 'The web browser has evolved beyond being a mere client for displaying web pages. It has transformed into a robust platform capable of running feature-rich applications known as web browser extensions (referred to interchangeably as browser extensions or simply extensions). These extensions serve to enhance websites and augment the web browser with additional functionalities.'
```
"
Class {
	#name : #WritingStyleCritic,
	#superclass : #CompletionClient,
	#category : #'OpenAI-API-Completion'
}

{ #category : #api }
WritingStyleCritic >> buildPromptWith: aString [

	| strm |
	strm := String new writeStream.
	strm
		nextPutAll:
			'As a scientific editor and writing style corrector, when asked to critique a paragraph, you provide a thorough analysis using clear, straightforward language, followed by an amended version. Now, criticise this paragraph "';
		nextPutAll: aString;
		nextPutAll: '"'.
	^ strm contents
]
