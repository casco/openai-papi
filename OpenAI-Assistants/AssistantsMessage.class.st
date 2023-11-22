Class {
	#name : #AssistantsMessage,
	#superclass : #Object,
	#instVars : [
		'id',
		'threadId',
		'role',
		'text',
		'api',
		'createdAt',
		'author',
		'metadata',
		'runId'
	],
	#category : #'OpenAI-Assistants'
}

{ #category : #'instance creation' }
AssistantsMessage class >> from: aDictionary in: anAssistantsAPI [

	| authorId metadata |
	metadata := aDictionary at: 'metadata' ifAbsent: [ Dictionary new ].

	authorId := (aDictionary at: 'assistant_id') ifNil: [
		            metadata at: 'participant_id' ifAbsent: [ nil ] ].

	^ self new
		  createdAt: (aDictionary at: 'created_at');
		  metadata: metadata;
		  author: (anAssistantsAPI participantWithId: authorId);
		  role: (aDictionary at: 'role');
		  runId: (aDictionary at: 'run_id' ifAbsent: [nil]);
		  api: anAssistantsAPI;
		  threadId: (aDictionary at: 'thread_id');
		  text: ((aDictionary at: 'content') first at: 'text' at: 'value');
		  id: (aDictionary at: 'id');
		  yourself
]

{ #category : #'instance creation' }
AssistantsMessage class >> fromAll: aDictionary in: anAssistantsAPI [

	^ (aDictionary at: 'data') collect: [ :each |
		  self from: each in: anAssistantsAPI ]
]

{ #category : #accessing }
AssistantsMessage >> api [

	^ api
]

{ #category : #accessing }
AssistantsMessage >> api: anObject [

	api := anObject
]

{ #category : #accessing }
AssistantsMessage >> author [

	^ author
]

{ #category : #accessing }
AssistantsMessage >> author: aParticipant [ 
	author := aParticipant
]

{ #category : #accessing }
AssistantsMessage >> createdAt [

	^ createdAt
]

{ #category : #accessing }
AssistantsMessage >> createdAt: anObject [

	createdAt := anObject
]

{ #category : #accessing }
AssistantsMessage >> id [

	^ id
]

{ #category : #accessing }
AssistantsMessage >> id: anObject [

	id := anObject
]

{ #category : #accessing }
AssistantsMessage >> metadata [

	^ metadata
]

{ #category : #accessing }
AssistantsMessage >> metadata: anObject [

	metadata := anObject
]

{ #category : #accessing }
AssistantsMessage >> role [

	^ role
]

{ #category : #accessing }
AssistantsMessage >> role: anObject [

	role := anObject
]

{ #category : #accessing }
AssistantsMessage >> runId [

	^ runId
]

{ #category : #accessing }
AssistantsMessage >> runId: anObject [

	runId := anObject
]

{ #category : #accessing }
AssistantsMessage >> text [

	^ text
]

{ #category : #accessing }
AssistantsMessage >> text: anObject [

	text := anObject
]

{ #category : #accessing }
AssistantsMessage >> threadId [

	^ threadId
]

{ #category : #accessing }
AssistantsMessage >> threadId: anObject [

	threadId := anObject
]
