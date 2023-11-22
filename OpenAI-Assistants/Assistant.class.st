Class {
	#name : #Assistant,
	#superclass : #Object,
	#instVars : [
		'name',
		'id',
		'model',
		'description',
		'instructions',
		'tools',
		'fileIds',
		'metadata'
	],
	#category : #'OpenAI-Assistants'
}

{ #category : #'instance creation' }
Assistant class >> from: aDictionary [

	^ self new
		  description: (aDictionary at: 'description');
		  model:  (aDictionary at: 'model');
		  id:  (aDictionary at: 'id');
		  instructions: (aDictionary at: 'instructions');
		  name: (aDictionary at: 'name');
		  metadata: (aDictionary at: 'metadata');
		  fileIds: (aDictionary at: 'file_ids');
		  tools: (aDictionary at: 'tools');
		  yourself
]

{ #category : #'instance creation' }
Assistant class >> fromAll: aDictionary [

	^ (aDictionary at: 'data') collect: [ :each | self from: each ]
]

{ #category : #'instance cation' }
Assistant class >> name: aName id: anId [

	^ self new
		  name: aName;
		  id: anId;
		  yourself
]

{ #category : #comparing }
Assistant >> = anotheAssistant [
	^id = anotheAssistant id
]

{ #category : #converting }
Assistant >> asDictionary [

	^ Dictionary new
		  at: 'name' put: name;
		  at: 'model' put: model;
		  at: 'instructions' put: instructions;
		  at: 'description' put: description;
		  at: 'tools' put: tools;
		  at: 'file_ids' put: fileIds;
		  at: 'metadata' put: metadata;
		  yourself
]

{ #category : #accessing }
Assistant >> description [

	^ description
]

{ #category : #accessing }
Assistant >> description: anObject [

	description := anObject
]

{ #category : #accessing }
Assistant >> fileIds [

	^ fileIds
]

{ #category : #accessing }
Assistant >> fileIds: anObject [

	fileIds := anObject
]

{ #category : #comparing }
Assistant >> hash [

	^ id hash
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
Assistant >> instructions [

	^ instructions
]

{ #category : #accessing }
Assistant >> instructions: anObject [

	instructions := anObject
]

{ #category : #accessing }
Assistant >> metadata [

	^ metadata
]

{ #category : #accessing }
Assistant >> metadata: anObject [

	metadata := anObject
]

{ #category : #accessing }
Assistant >> model [

	^ model
]

{ #category : #accessing }
Assistant >> model: anObject [

	model := anObject
]

{ #category : #accessing }
Assistant >> name [

	^ name
]

{ #category : #accessing }
Assistant >> name: anObject [

	name := anObject
]

{ #category : #accessing }
Assistant >> tools [

	^ tools
]

{ #category : #accessing }
Assistant >> tools: anObject [

	tools := anObject
]

{ #category : #converting }
Assistant >> updateWith: aDictionary [

	(aDictionary at: 'id') = id ifFalse: [
		self error: 'This is not my data' ].

	name := aDictionary at: 'name'.
	model := aDictionary at: 'model'.
	instructions := aDictionary at: 'instructions'.
	description := aDictionary at: 'description'.
	tools := aDictionary at: 'tools'.
	fileIds := aDictionary at: 'file-ids'.
	metadata := aDictionary at: 'metadata'
]
