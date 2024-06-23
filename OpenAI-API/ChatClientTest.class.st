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
	self assert: client conversation size = 1.
	self
		assert:
		((client conversation flatCollect: #value) asBag occurrencesOf: 'assistant')
		equals: 0.
	self
		assert: ((client conversation flatCollect: #value) asBag occurrencesOf: 'user')
		equals: 1.
	client obtainNextAssistantMessage.
	self assert: client conversation size = 2.
	self
		assert:
		((client conversation flatCollect: #value) asBag occurrencesOf: 'assistant')
		equals: 1.
	self
		assert: ((client conversation flatCollect: #value) asBag occurrencesOf: 'user')
		equals: 1
]
