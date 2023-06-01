Class {
	#name : #CompletionClient,
	#superclass : #Object,
	#instVars : [
		'apiKey',
		'model',
		'temperature',
		'maxTokens',
		'topP',
		'frequencyPenalty',
		'presencePenalty'
	],
	#category : #'OpenAI-API'
}

{ #category : #'api-configuration' }
CompletionClient >> apiKey [

	apiKey ifNotNil: [ :it | ^ it ].
	(OSEnvironment current at: 'OPENAI_APIKEY' ifAbsent: nil) ifNotNil: [ :it | ^ it ].
	'open-ai/apikey.secret' asFileReference exists ifTrue: [
		^ 'open-ai/apikey.secret' asFileReference contents ].
	^ nil
]

{ #category : #'api-configuration' }
CompletionClient >> apiKey: anObject [

	apiKey := anObject
]

{ #category : #'api-configuration' }
CompletionClient >> baseConfig [

	^ Dictionary new
		  at: 'model' put: model;
		  at: 'temperature' put: temperature;
		  at: 'max_tokens' put: maxTokens;
		  at: 'top_p' put: topP;
		  at: 'frequency_penalty' put: frequencyPenalty;
		  at: 'presence_penalty' put: presencePenalty;
		  yourself
]

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
			             url: 'https://api.openai.com/v1/completions';
			             headerAt: 'Authorization'
			             put:
				             'Bearer '
				             , self apiKey;
			             entity:
				             (ZnEntity text: (STON toJsonString: requestConfig));
			             contentType: ZnMimeType applicationJson;
			             post).

	^((response at: 'choices') first at: 'text') trimBoth
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
