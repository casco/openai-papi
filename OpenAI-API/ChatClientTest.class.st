Class {
	#name : #ChatClientTest,
	#superclass : #TestCase,
	#instVars : [
		'client'
	],
	#category : #'OpenAI-API-Chat'
}

{ #category : #setup }
ChatClientTest >> setUp [

	client := ChatClient new.
	client apiKey: 'open-ai/apikey.secret' asFileReference contents
]

{ #category : #tests }
ChatClientTest >> testObtainNextAssistantMessage [

	self should: [ client obtainNextAssistantMessage ] raise: KeyNotFound.
	client acceptMessageFromUser: 'Hola'.
	client obtainNextAssistantMessage.
	self assert: client conversation size = 2
]
