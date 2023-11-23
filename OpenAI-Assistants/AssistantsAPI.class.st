Class {
	#name : #AssistantsAPI,
	#superclass : #Object,
	#instVars : [
		'participantsRegister'
	],
	#category : #'OpenAI-Assistants'
}

{ #category : #models }
AssistantsAPI class >> gpt35turbo1106 [

	^ 'gpt-3.5-turbo-1106'
]

{ #category : #models }
AssistantsAPI class >> models [

	^ { self gpt35turbo1106 }
]

{ #category : #private }
AssistantsAPI >> apiKey [

	(OSEnvironment current at: 'OPENAI_APIKEY' ifAbsent: nil) ifNotNil: [
		:it | ^ it ].
	'open-ai/apikey.secret' asFileReference exists ifTrue: [
		^ 'open-ai/apikey.secret' asFileReference contents ].
	^ nil
]

{ #category : #assistants }
AssistantsAPI >> assistants [

	^ Assistant fromAll:
		  (self getObjectAt: 'https://api.openai.com/v1/assistants')
]

{ #category : #assistants }
AssistantsAPI >> assistantsUrl [

	^ 'https://api.openai.com/v1/assistants'
]

{ #category : #files }
AssistantsAPI >> deleteFile: anAssistantsFile [

	| client |
	client := ZnClient new.
	client
		url: self filesUrl , '/' , anAssistantsFile id;
		headerAt: 'Authorization' put: 'Bearer ' , self apiKey;
		headerAt: 'OpenAI-Beta' put: 'assistants=v1';
		delete.

	client response isSuccess ifFalse: [
		self error: 'Error while deleting a file in openai' ]
]

{ #category : #files }
AssistantsAPI >> files [

	| response |
	response := self getObjectAt: self filesUrl.
	response ifNil: [ ^ nil ].
	^ AssistantsFile fromAll: response
]

{ #category : #files }
AssistantsAPI >> filesUrl [

	^ 'https://api.openai.com/v1/files'
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

{ #category : #assistants }
AssistantsAPI >> newAssistantNamed: name model: model instructions: instructions description: descripcion [

	^ Assistant from: (self
			   post: (Dictionary new
					    at: 'name' put: name;
					    at: 'model' put: model;
					    at: 'instructions' put: instructions;
					    at: 'description' put: descripcion;
					    yourself)
			   at: self assistantsUrl)
]

{ #category : #threads }
AssistantsAPI >> newThread [

	| response |
	response := self post: nil at: self threadsUrl.
	response ifNil: [ nil ].
	^ AssistantsThread from: response for: self
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

{ #category : #assistants }
AssistantsAPI >> postAssistant: anAssistant [

	| response |
	response := self
		post: anAssistant asDictionary
		at: self assistantsUrl , '/' , anAssistant id
]

{ #category : #runs }
AssistantsAPI >> runUrlIn: aThread [

	^ 'https://api.openai.com/v1/threads/' , aThread id , '/runs'
]

{ #category : #runs }
AssistantsAPI >> startRunIn: aThread for: anAssistant [

	| run runSpec |
	run := AssistantsRun in: aThread for: anAssistant with: self.
	runSpec := self
		           post: (Dictionary new
				            at: 'assistant_id' put: anAssistant id;
				            at: 'model' put: anAssistant model;
				            at: 'instructions' put: anAssistant instructions;
				            at: 'tools' put: anAssistant tools;
				            yourself)
		           at: (self runUrlIn: aThread).
	run updateWith: runSpec.
	^ run
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

	self error: [ 'This api call seems to have been deprecated' ].
	^ AssistantsThread
		  fromAll: (self getObjectAt: 'https://api.openai.com/v1/threads')
		  for: self
]

{ #category : #threads }
AssistantsAPI >> threadsUrl [

	^ 'https://api.openai.com/v1/threads'
]

{ #category : #assistants }
AssistantsAPI >> updateAssistant: anAssistant [

	anAssistant updateWith:
		(self getObjectAt: self assistantsUrl , '/' , anAssistant id)
]

{ #category : #runs }
AssistantsAPI >> updateRun: aRun [

	| runSpec |
	runSpec := self getObjectAt: (self runUrlIn: aRun thread) , '/' , aRun id.
	aRun updateWith: runSpec
]

{ #category : #files }
AssistantsAPI >> uploadFile: aFilenameString [

	| client |
	client := ZnClient new.
	client
		          url: self filesUrl;
		          headerAt: 'Authorization' put: 'Bearer ' , self apiKey;
		          headerAt: 'OpenAI-Beta' put: 'assistants=v1';
		          addPart:
			          (ZnMimePart fieldName: 'file' fileNamed: aFilenameString);
		          addPart:
			          (ZnMimePart fieldName: 'purpose' value: 'assistants');
		          post.

	client response isSuccess  ifFalse: [
		self error: 'Error while uploading a file to openai' ]
]
