Class {
	#name : #Participant,
	#superclass : #Object,
	#instVars : [
		'name',
		'email'
	],
	#category : #'OpenAI-Assistants'
}

{ #category : #'instance creation' }
Participant class >> name: aName email: anEmail [

	^ self new
		  name: aName;
		  email: anEmail;
		  yourself
]

{ #category : #accessing }
Participant >> email [

	^ email
]

{ #category : #accessing }
Participant >> email: anObject [

	email := anObject
]

{ #category : #accessing }
Participant >> name [

	^ name
]

{ #category : #accessing }
Participant >> name: anObject [

	name := anObject
]
