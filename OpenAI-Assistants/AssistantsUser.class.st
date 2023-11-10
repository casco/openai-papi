Class {
	#name : #AssistantsUser,
	#superclass : #Object,
	#instVars : [
		'name',
		'email',
		'id'
	],
	#category : #'OpenAI-Assistants'
}

{ #category : #'instance creation' }
AssistantsUser class >> name: aName email: anEmail id: anId [

	^ self new
		  name: aName;
		  email: anEmail;
		  id:anId;
		  yourself
]

{ #category : #accessing }
AssistantsUser >> email [

	^ email
]

{ #category : #accessing }
AssistantsUser >> email: anObject [

	email := anObject
]

{ #category : #accessing }
AssistantsUser >> id [

	^ id
]

{ #category : #accessing }
AssistantsUser >> id: anObject [

	id := anObject
]

{ #category : #accessing }
AssistantsUser >> name [

	^ name
]

{ #category : #accessing }
AssistantsUser >> name: anObject [

	name := anObject
]
