Class {
	#name : #ParticipantsRegister,
	#superclass : #Object,
	#instVars : [
		'users',
		'assistants'
	],
	#category : #'OpenAI-Assistants'
}

{ #category : #accessing }
ParticipantsRegister >> addAssistant: anAssistant [

	assistants add: anAssistant
]

{ #category : #accessing }
ParticipantsRegister >> addUser: aUser [
	users add: aUser
]

{ #category : #accessing }
ParticipantsRegister >> assistants [

	^ assistants
]

{ #category : #participants }
ParticipantsRegister >> participantWithId: aStringOrNil [

	aStringOrNil ifNil: [ nil ].

	^ users , assistants detect: [ :each | each id = aStringOrNil ] ifNone: [ nil ]
]

{ #category : #accessing }
ParticipantsRegister >> users [

	^ users
]
