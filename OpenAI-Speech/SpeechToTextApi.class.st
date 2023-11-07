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

{ #category : #private }
SpeechToTextApi >> toText: anAudioFieReference [

	| response |

	response := ZnClient new
		            url: self entdpointUrl;
		            headerAt: 'Authorization' put: 'Bearer ' , self apiKey;
						accept: ZnMimeType applicationJson;
						addPart: (ZnMimePart fieldName: 'file' fileNamed: anAudioFieReference fullName );
						addPart: (ZnMimePart fieldName: 'model' entity: (ZnEntity text: 'whisper-1'));
		            post.
	^ (STON fromString: response) at: 'text'
]
