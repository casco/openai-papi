Class {
	#name : #AssistantThread,
	#superclass : #Object,
	#instVars : [
		'id',
		'api',
		'messages'
	],
	#category : #'OpenAI-Assistants'
}

{ #category : #'instance creation' }
AssistantThread class >> from: aDictionary [

	^ self new
		  id: (aDictionary at: 'id');
		  yourself
]

{ #category : #'instance creation' }
AssistantThread class >> from: aDictionary for: anAPI [

	^ self new
		  id: (aDictionary at: 'id');
		  api: anAPI;
		  yourself
]

{ #category : #accessing }
AssistantThread >> api: anAPI [

	api := anAPI
]

{ #category : #accessing }
AssistantThread >> id: aString [ 
	id := aString
]

{ #category : #accessing }
AssistantThread >> messages [

	^ messages ifNil: [
		  messages := AssistantMessage
			              fromAll: (api getObjectAt:
					               'https://api.openai.com/v1/threads/' , id
					               , '/messages')
			              in: api ]
]
