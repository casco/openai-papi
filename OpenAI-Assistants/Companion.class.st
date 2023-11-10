Class {
	#name : #Companion,
	#superclass : #Object,
	#instVars : [
		'name',
		'id'
	],
	#category : #'OpenAI-Assistants'
}

{ #category : #'instance cation' }
Companion class >> name: aName id: anId [

	^ self new
		  name: aName;
		  id: anId;
		  yourself
]

{ #category : #accessing }
Companion >> id [

	^ id
]

{ #category : #accessing }
Companion >> id: anObject [

	id := anObject
]

{ #category : #accessing }
Companion >> name [

	^ name
]

{ #category : #accessing }
Companion >> name: anObject [

	name := anObject
]
