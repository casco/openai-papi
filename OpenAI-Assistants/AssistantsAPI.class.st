Class {
	#name : #AssistantsAPI,
	#superclass : #Object,
	#category : #'OpenAI-Assistants'
}

{ #category : #private }
AssistantsAPI >> apiKey [

	(OSEnvironment current at: 'OPENAI_APIKEY' ifAbsent: nil) ifNotNil: [
		:it | ^ it ].
	'open-ai/apikey.secret' asFileReference exists ifTrue: [
		^ 'open-ai/apikey.secret' asFileReference contents ].
	^ nil
]

{ #category : #private }
AssistantsAPI >> getObjectAt: url [

	| client |
	client := ZnClient new.

	client
		url: url;
		headerAt: 'Authorization' put: 'Bearer ' , self apiKey;
		headerAt: 'OpenAI-Beta' put: 'assistants=v1';
		accept: ZnMimeType applicationJson;
		get.

	^ client isSuccess
		  ifTrue: [ STON fromString: client contents ]
		  ifFalse: [ nil ]
]

{ #category : #threads }
AssistantsAPI >> threadId: threadId [

	^ AssistantThread
		  from:
		  (self getObjectAt: 'https://api.openai.com/v1/threads/' , threadId)
		  for: self
]
