Class {
	#name : #AssistantsThread,
	#superclass : #Object,
	#instVars : [
		'id',
		'api',
		'messages'
	],
	#category : #'OpenAI-Assistants'
}

{ #category : #'instance creation' }
AssistantsThread class >> from: aDictionary for: anAPI [

	^ self new
		  id: (aDictionary at: 'id');
		  api: anAPI;
		  yourself
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
AssistantsThread >> id [

	^ id
]

{ #category : #accessing }
AssistantsThread >> id: aString [ 
	id := aString
]

{ #category : #accessing }
AssistantsThread >> messages [

	^ messages
]

{ #category : #accessing }
AssistantsThread >> messagesUrl [

	^ 'https://api.openai.com/v1/threads/' , id , '/messages'
]

{ #category : #posting }
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

{ #category : #caching }
AssistantsThread >> reloadMessages [

	messages := AssistantsMessage
		  fromAll: (api getObjectAt: self messagesUrl)
		  in: api
]
