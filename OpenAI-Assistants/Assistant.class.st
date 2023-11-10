Class {
	#name : #Assistant,
	#superclass : #Object,
	#instVars : [
		'name',
		'id'
	],
	#category : #'OpenAI-Assistants'
}

{ #category : #'instance cation' }
Assistant class >> name: aName id: anId [

	^ self new
		  name: aName;
		  id: anId;
		  yourself
]

{ #category : #accessing }
Assistant >> id [

	^ id
]

{ #category : #accessing }
Assistant >> id: anObject [

	id := anObject
]

{ #category : #accessing }
Assistant >> name [

	^ name
]

{ #category : #accessing }
Assistant >> name: anObject [

	name := anObject
]
