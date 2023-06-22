Class {
	#name : #GPTClient,
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
GPTClient >> apiKey [

	apiKey ifNotNil: [ :it | ^ it ].
	(OSEnvironment current at: 'OPENAI_APIKEY' ifAbsent: nil) ifNotNil: [ :it | ^ it ].
	'open-ai/apikey.secret' asFileReference exists ifTrue: [
		^ 'open-ai/apikey.secret' asFileReference contents ].
	^ nil
]

{ #category : #'api-configuration' }
GPTClient >> apiKey: anObject [

	apiKey := anObject
]

{ #category : #'api-configuration' }
GPTClient >> baseConfig [

	^ Dictionary new
		  at: 'model' put: model;
		  at: 'temperature' put: temperature;
		  at: 'max_tokens' put: maxTokens;
		  at: 'top_p' put: topP;
		  at: 'frequency_penalty' put: frequencyPenalty;
		  at: 'presence_penalty' put: presencePenalty;
		  yourself
]
