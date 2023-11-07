Class {
	#name : #SpeechToTextApi,
	#superclass : #GPTClient,
	#category : #'OpenAI-API-SountAndText'
}

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
