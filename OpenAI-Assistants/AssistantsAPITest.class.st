Class {
	#name : #AssistantsAPITest,
	#superclass : #TestCase,
	#instVars : [
		'api'
	],
	#category : #'OpenAI-Assistants'
}

{ #category : #setup }
AssistantsAPITest >> setUp [ 	

	api := AssistantsAPI new.
]

{ #category : #testing }
AssistantsAPITest >> testNewAssistantNamedModelInstructionsDescription [

	| assistant name description model instructions |
	name := 'A test assistant - remove it'.
	description := 'This is a test model to test the api'.
	instructions := 'Sorry. You will be deleted. No instructions for you.'.

	model := AssistantsAPI gpt35turbo1106.

	assistant := api
		             newAssistantNamed: name
		             model: model
		             instructions: instructions
		             description: description.
	self assert: assistant id notNil.
	self assert: assistant name equals: name.
	self assert: assistant model equals: model.
	self assert: assistant instructions equals: instructions.
	self assert: assistant description equals: description
]
