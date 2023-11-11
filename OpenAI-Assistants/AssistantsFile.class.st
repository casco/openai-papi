Class {
	#name : #AssistantsFile,
	#superclass : #Object,
	#instVars : [
		'id',
		'sizeInBytes',
		'createdAt',
		'name',
		'purpose'
	],
	#category : #'OpenAI-Assistants'
}

{ #category : #'instance creation' }
AssistantsFile class >> from: aDictionary [

	^ self new
		  name: (aDictionary at: 'filename');
		  purpose: (aDictionary at: 'purpose');
		  sizeInBytes: (aDictionary at: 'bytes');
		  createdAt: (aDictionary at: 'created_at');
		  id: (aDictionary at: 'id');
		  yourself
]

{ #category : #'instance creation' }
AssistantsFile class >> fromAll: aFilesResponseDictionary [

	^ aFilesResponseDictionary
		  at: 'data'
		  ifPresent: [ :aCollectionOfDictionaries |
			  aCollectionOfDictionaries collect: [ :aDictionary |
				  self from: aDictionary ] ]
		  ifAbsent: [ Set new ]
]

{ #category : #accessing }
AssistantsFile >> createdAt [

	^ createdAt
]

{ #category : #accessing }
AssistantsFile >> createdAt: anObject [

	createdAt := anObject
]

{ #category : #accessing }
AssistantsFile >> id [

	^ id
]

{ #category : #accessing }
AssistantsFile >> id: anObject [

	id := anObject
]

{ #category : #accessing }
AssistantsFile >> name [

	^ name
]

{ #category : #accessing }
AssistantsFile >> name: anObject [

	name := anObject
]

{ #category : #accessing }
AssistantsFile >> purpose [

	^ purpose
]

{ #category : #accessing }
AssistantsFile >> purpose: anObject [

	purpose := anObject
]

{ #category : #accessing }
AssistantsFile >> sizeInBytes [

	^ sizeInBytes
]

{ #category : #accessing }
AssistantsFile >> sizeInBytes: anObject [

	sizeInBytes := anObject
]
