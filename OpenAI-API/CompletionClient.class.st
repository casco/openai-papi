Class {
	#name : #CompletionClient,
	#superclass : #GPTClient,
	#category : #'OpenAI-API'
}

{ #category : #api }
CompletionClient >> buildPromptWith: aString [
		self subclassResponsibility 
]

{ #category : #api }
CompletionClient >> complete: aString [

	| response requestConfig |
	requestConfig := self baseConfig.
	requestConfig at: 'prompt' put: (self buildPromptWith: aString).
	response := STON fromString: (ZnClient new
			             url: self entdpointUrl;
			             headerAt: 'Authorization'
			             put: 'Bearer ' , self apiKey;
			             entity:
				             (ZnEntity text: (STON toJsonString: requestConfig));
			             contentType: ZnMimeType applicationJson;
			             post).

	^ ((response at: 'choices') first at: 'text') trimBoth
]

{ #category : #api }
CompletionClient >> entdpointUrl [

	^ 'https://api.openai.com/v1/completions'
]

{ #category : #'initialize-release' }
CompletionClient >> initialize [

	model := 'text-davinci-003'.
	temperature := 0.9.
	maxTokens := 1000.
	topP := 1.
	frequencyPenalty := 0.0.
	presencePenalty := 0.6
]
