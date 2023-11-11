Class {
	#name : #AssistantsAPI,
	#superclass : #Object,
	#instVars : [
		'participantsRegister'
	],
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

{ #category : #threads }
AssistantsAPI >> files [

	^ AssistantsFile fromAll:
		  (self getObjectAt: 'https://api.openai.com/v1/files')
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
AssistantsAPI >> initialize [ 	
 super initialize.
 participantsRegister := ParticipantsRegister new. 
]

{ #category : #threads }
AssistantsAPI >> newThread [

	^ AssistantsThread from: (self post: nil at: self threadsUrl) for: self
]

{ #category : #threads }
AssistantsAPI >> participantWithId: anId [

	participantsRegister ifNil: [ ^ nil ].
	^ participantsRegister participantWithId: anId
]

{ #category : #accessing }
AssistantsAPI >> participantsRegister [

	^ participantsRegister
]

{ #category : #accessing }
AssistantsAPI >> participantsRegister: anObject [

	participantsRegister := anObject
]

{ #category : #private }
AssistantsAPI >> post: aPropertyValueDictionary at: url [

	| client |
	client := ZnClient new.

	client
		url: url;
		headerAt: 'Authorization' put: 'Bearer ' , self apiKey;
		headerAt: 'OpenAI-Beta' put: 'assistants=v1'.

	aPropertyValueDictionary ifNotNil: [
		client
			entity:
				(ZnEntity text: (STON toJsonString: aPropertyValueDictionary));
			contentType: ZnMimeType applicationJson ].

	client post.

	^ client isSuccess
		  ifTrue: [ STON fromString: client contents ]
		  ifFalse: [ nil ]
]

{ #category : #threads }
AssistantsAPI >> threadId: threadId [

	^ AssistantsThread
		  from:
		  (self getObjectAt: 'https://api.openai.com/v1/threads/' , threadId)
		  for: self
]

{ #category : #threads }
AssistantsAPI >> threads [

	^ self getObjectAt: 'https://api.openai.com/v1/threads'
]

{ #category : #threads }
AssistantsAPI >> threadsUrl [

	^ 'https://api.openai.com/v1/threads'
]
