"
Example of text to speech

```
| responseStream |
responseStream := TextToSpeechApi new toSpeechStream: 'Hola Manola, te traje una lola.' voice: TextToSpeechApi shimmer.
'response.mp3' asFileReference binaryWriteStream nextPutAll: responseStream contents; close. 
```

"
Class {
	#name : #TextToSpeechApi,
	#superclass : #GPTClient,
	#category : #'OpenAI-API-SountAndText'
}

{ #category : #voices }
TextToSpeechApi class >> alloy [

	^ 'alloy'
]

{ #category : #voices }
TextToSpeechApi class >> echo [

	^ 'echo'
]

{ #category : #voices }
TextToSpeechApi class >> fable [

	^ 'fable'
]

{ #category : #voices }
TextToSpeechApi class >> nova [

	^ 'nova'
]

{ #category : #voices }
TextToSpeechApi class >> onix [

	^ 'onix'
]

{ #category : #voices }
TextToSpeechApi class >> shimmer [

	^ 'shimmer'
]

{ #category : #private }
TextToSpeechApi >> entdpointUrl [

	^ 'https://api.openai.com/v1/audio/speech'
]

{ #category : #private }
TextToSpeechApi >> toSpeechStream: aString voice: voice [

	| response payload |
	payload := Dictionary new
		           at: 'input' put: aString;
		           at: 'model' put: 'tts-1';
		           at: 'voice' put: voice;
		           yourself.
	response := ZnClient new
		            url: self entdpointUrl;
		            headerAt: 'Authorization' put: 'Bearer ' , self apiKey;
		            entity: (ZnEntity text: (STON toJsonString: payload));
		            contentType: ZnMimeType applicationJson;
		            beBinary;
		            streaming: true;
		            post.

	^ response
]
