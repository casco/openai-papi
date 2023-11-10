Class {
	#name : #AssistantMessage,
	#superclass : #Object,
	#instVars : [
		'id',
		'threadId',
		'role',
		'text',
		'api',
		'createdAt',
		'author'
	],
	#category : #'OpenAI-Assistants'
}

{ #category : #'instance creation' }
AssistantMessage class >> from: aDictionary in: anAssistantsAPI [

	| author |
	author := (aDictionary at: 'role') = 'assistant'
		          ifTrue: [
		          Companion
			          name: 'unknown'
			          id: (aDictionary at: 'assistant_id') ]
		          ifFalse: [ Participant name: 'unknown' email: 'unknown' ].


	^ self new
		  createdAt: (aDictionary at: 'created_at');
		  author: author;
		  text: ((aDictionary at: 'content' at: 'text') at: 'value');
		  id: (aDictionary at: 'id');
		  yourself
]

{ #category : #'instance creation' }
AssistantMessage class >> fromAll: aDictionary in: anAssistantsAPI [

	^ (aDictionary at: 'data') collect: [ :each |
		  self from: each in: anAssistantsAPI ]
]

{ #category : #accessing }
AssistantMessage >> api: anObject [

	api := anObject
]

{ #category : #accessing }
AssistantMessage >> author: aParticipant [ 
	author := aParticipant
]

{ #category : #accessing }
AssistantMessage >> createdAt [

	^ createdAt
]

{ #category : #accessing }
AssistantMessage >> createdAt: anObject [

	createdAt := anObject
]

{ #category : #accessing }
AssistantMessage >> id [

	^ id
]

{ #category : #accessing }
AssistantMessage >> id: anObject [

	id := anObject
]

{ #category : #accessing }
AssistantMessage >> role [

	^ role
]

{ #category : #accessing }
AssistantMessage >> role: anObject [

	role := anObject
]

{ #category : #accessing }
AssistantMessage >> text [

	^ text
]

{ #category : #accessing }
AssistantMessage >> text: anObject [

	text := anObject
]

{ #category : #accessing }
AssistantMessage >> threadId [

	^ threadId
]

{ #category : #accessing }
AssistantMessage >> threadId: anObject [

	threadId := anObject
]
