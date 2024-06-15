Class {
	#name : 'TextToSpeechToTextTest',
	#superclass : 'TestCase',
	#instVars : [
		'tempFileReference',
		'textToSpeechApi',
		'speechToTextApi'
	],
	#category : 'OpenAI-Speech',
	#package : 'OpenAI-Speech'
}

{ #category : 'testing' }
TextToSpeechToTextTest >> setUp [

   textToSpeechApi := TextToSpeechApi new.
	speechToTextApi := SpeechToTextApi new.
	tempFileReference := 'testRoundTript-test-audio.mp3' asFileReference
]

{ #category : 'testing' }
TextToSpeechToTextTest >> tearDown [

	tempFileReference ifExists: [ :it | tempFileReference delete ]
]

{ #category : 'testing' }
TextToSpeechToTextTest >> testRoundTrip [

	| text responseStream transcribedText |
	text := 'yellow banana'.
	responseStream := textToSpeechApi 
		                  vocalize: text
		                  withVoice: TextToSpeechApi nova.
	transcribedText := speechToTextApi transcribeByteArray: responseStream contents.
	self
		assert: (text asLowercase select: #isLetter)
		equals: (transcribedText asLowercase select: #isLetter)
]

{ #category : 'testing' }
TextToSpeechToTextTest >> testRoundTripOverFile [

	| text responseStream transcribedText |
	text := 'yellow banana'.
	responseStream := textToSpeechApi
		                  vocalize: text
		                  withVoice: TextToSpeechApi nova
		                  toAudioFile: tempFileReference.
	transcribedText := speechToTextApi transcribeAudioFile:
		                   tempFileReference.
	self
		assert: (text asLowercase select: #isLetter)
		equals: (transcribedText asLowercase select: #isLetter)
]
