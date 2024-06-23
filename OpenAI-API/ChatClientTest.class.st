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
ChatClientTest >> testAskAssistantToContribute [

	self should: [ client askAssistantToContribute ] raise: KeyNotFound.
	client acceptMessageFromUser: 'Hola'.
	self assert: client conversation size = 1.
	self
		assert:
		((client conversation flatCollect: #value) asBag occurrencesOf: 'assistant')
		equals: 0.
	self
		assert: ((client conversation flatCollect: #value) asBag occurrencesOf: 'user')
		equals: 1.
	client askAssistantToContribute.
	self assert: client conversation size = 2.
	self
		assert:
		((client conversation flatCollect: #value) asBag occurrencesOf: 'assistant')
		equals: 1.
	self
		assert: ((client conversation flatCollect: #value) asBag occurrencesOf: 'user')
		equals: 1
]

{ #category : #tests }
ChatClientTest >> testLastMessage [

	self should: [ client lastMessage ] raise: SubscriptOutOfBounds .
	client acceptMessageFromUser: 'What is the result of 1 + 1 (answer only the number)?'.
	self assert: (client lastMessage at: 'role') equals: 'user'.
	client askAssistantToContribute.
	self assert: (client lastMessage at: 'role') equals: 'assistant'.	
	self assert: (client lastMessage at: 'content') equals: '2'.	

]
