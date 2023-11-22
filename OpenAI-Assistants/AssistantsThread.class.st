Class {
	#name : #AssistantsThread,
	#superclass : #Object,
	#instVars : [
		'id',
		'api',
		'messages',
		'metadata',
		'createdAt',
		'runs',
		'latestRun'
	],
	#category : #'OpenAI-Assistants'
}

{ #category : #'instance creation' }
AssistantsThread class >> from: aDictionary for: anAPI [

	^ self new
		  createdAt: (aDictionary at: 'created_at');
		  id: (aDictionary at: 'id');
		  metadata: (aDictionary at: 'metadata');
		  api: anAPI;
		  yourself
]

{ #category : #'instance creation' }
AssistantsThread class >> fromAll: aDictionary for: anAPI [

	^ (aDictionary at: 'data') collect: [ :each |
		  self from: each for: anAPI ]
]

{ #category : #accessing }
AssistantsThread >> api [

	^ api
]

{ #category : #accessing }
AssistantsThread >> api: anAPI [

	api := anAPI
]

{ #category : #accessing }
AssistantsThread >> createdAt [

	^ createdAt
]

{ #category : #accessing }
AssistantsThread >> createdAt: anObject [

	createdAt := anObject
]

{ #category : #accessing }
AssistantsThread >> id [

	^ id
]

{ #category : #accessing }
AssistantsThread >> id: aString [ 
	id := aString
]

{ #category : #runs }
AssistantsThread >> latestRun [

	^ latestRun
]

{ #category : #runs }
AssistantsThread >> logAllRuns [
	runs := OrderedCollection new. 
]

{ #category : #accessing }
AssistantsThread >> messages [

	^ messages ifNil: Array new
]

{ #category : #accessing }
AssistantsThread >> messagesUrl [

	^ 'https://api.openai.com/v1/threads/' , id , '/messages'
]

{ #category : #accessing }
AssistantsThread >> metadata [

	^ metadata
]

{ #category : #accessing }
AssistantsThread >> metadata: anObject [

	metadata := anObject
]

{ #category : #accessing }
AssistantsThread >> playgroundUrl [

	^ 'https://platform.openai.com/playground?thread=' , id
]

{ #category : #runs }
AssistantsThread >> post: aString by: aParticipant [

	| payload |
	payload := Dictionary new
		           at: 'role' put: 'user';
		           at: 'content' put: aString;
		           at: 'metadata' put: (Dictionary new
				            at: 'participant_id' put: aParticipant id;
				            yourself);
		           yourself.

	^ AssistantsMessage
		  from: (api post: payload at: self messagesUrl)
		  in: api
]

{ #category : #runs }
AssistantsThread >> runs [

	^ runs
]

{ #category : #runs }
AssistantsThread >> startRunFor: anAssistant [

	runs ifNotNil: [ latestRun ifNotNil: [ :it | runs add: it ] ].
	latestRun := api startRunIn: self for: anAssistant.
	^latestRun 

]

{ #category : #accessing }
AssistantsThread >> updateMessages [

	^ messages := (AssistantsMessage
		              fromAll: (api getObjectAt: self messagesUrl)
		              in: api) reversed
]
