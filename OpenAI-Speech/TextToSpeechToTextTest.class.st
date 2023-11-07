Class {
	#name : #TextToSpeechToTextTest,
	#superclass : #TestCase,
	#instVars : [
		'tempFileReference'
	],
	#category : #'OpenAI-Speech'
}

{ #category : #testing }
TextToSpeechToTextTest >> setUp [

	tempFileReference := 'testRoundTript-test-audio.mp3' asFileReference
]

{ #category : #testing }
TextToSpeechToTextTest >> tearDown [

	tempFileReference ifExists: [:it | tempFileReference delete  ] .

]

{ #category : #testing }
TextToSpeechToTextTest >> testRoundTrip [

	| text responseStream transcribedText |
	text := 'yellow banana'.
	responseStream := TextToSpeechApi new
		                  toSpeechStream: text
		                  voice: TextToSpeechApi nova.
	tempFileReference binaryWriteStream
		nextPutAll: responseStream contents;
		close.
	transcribedText := SpeechToTextApi new toText: tempFileReference.
	self
		assert: (text asLowercase select: #isLetter)
		equals: (transcribedText asLowercase select: #isLetter)
]
