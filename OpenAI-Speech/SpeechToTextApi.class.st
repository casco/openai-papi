Class {
	#name : #SpeechToTextApi,
	#superclass : #Object,
	#category : #'OpenAI-Speech'
}

{ #category : #private }
SpeechToTextApi >> apiKey [

	(OSEnvironment current at: 'OPENAI_APIKEY' ifAbsent: nil) ifNotNil: [ :it | ^ it ].
	'open-ai/apikey.secret' asFileReference exists ifTrue: [
		^ 'open-ai/apikey.secret' asFileReference contents ].
	^ nil
]

{ #category : #private }
SpeechToTextApi >> entdpointUrl [

	^ 'https://api.openai.com/v1/audio/transcriptions'
]

{ #category : #api }
SpeechToTextApi >> isProperlyConfigured [

	^ self apiKey notNil
]

{ #category : #api }
SpeechToTextApi >> transcribeAudioFile: anAudioFieReference [

	^ self transcribeByteArray: anAudioFieReference binaryReadStream contents
]

{ #category : #api }
SpeechToTextApi >> transcribeByteArray: aByteArray [

	| response entity |
	self apiKey ifNil: [
		^ self error:
			  'OpenAI API is not properly configured. Keck your API key' ].

	entity := ZnStreamingEntity
		          readFrom: aByteArray readStream
		          usingType: (ZnMimeType forFilenameExtension: 'mp3')
		          andLength: aByteArray size.
	response := ZnClient new
		            url: self entdpointUrl;
		            headerAt: 'Authorization' put: 'Bearer ' , self apiKey;
		            accept: ZnMimeType applicationJson;
		            addPart:
			            (ZnMimePart
				             fieldName: 'file'
				             fileName: 'audio.mp3'
				             entity: entity);
		            addPart:
			            (ZnMimePart
				             fieldName: 'model'
				             entity: (ZnEntity text: 'whisper-1'));
		            post.
	^ (STON fromString: response) at: 'text'
]
