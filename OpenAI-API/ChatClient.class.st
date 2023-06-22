Class {
	#name : #ChatClient,
	#superclass : #GPTClient,
	#instVars : [
		'conversation',
		'systemMessage'
	],
	#category : #'OpenAI-API'
}

{ #category : #chat }
ChatClient >> acceptMessageFromUser: aString [

	conversation add: (Dictionary new
			 at: 'role' put: 'user';
			 at: 'content' put: aString;
			 yourself).
	self obtainNextAssistantMessage. 
]

{ #category : #'initialize-release' }
ChatClient >> baseConfig [

	^ Dictionary new
		  at: 'model' put: model;
		  yourself
]

{ #category : #accessing }
ChatClient >> conversation [

	^ conversation
]

{ #category : #accessing }
ChatClient >> entdpointUrl [

	^ 'https://api.openai.com/v1/chat/completions'
]

{ #category : #'initialize-release' }
ChatClient >> initialize [ 	
	super initialize .
	model := 'gpt-3.5-turbo'.
	systemMessage := ''.
	conversation := OrderedCollection new. 
	
]

{ #category : #chat }
ChatClient >> obtainNextAssistantMessage [

	| response requestConfig |
	requestConfig := self baseConfig.
	requestConfig at: 'messages' put: conversation asArray.
	response := STON fromString: (ZnClient new
			             url: self entdpointUrl;
			             headerAt: 'Authorization'
			             put: 'Bearer ' , self apiKey;
			             entity:
				             (ZnEntity text: (STON toJsonString: requestConfig));
			             contentType: ZnMimeType applicationJson;
			             post).

	conversation add: ((response at: 'choices') first at: 'message')
]

{ #category : #accessing }
ChatClient >> systemMessage [

	^ systemMessage
]

{ #category : #accessing }
ChatClient >> systemMessage: anObject [

	systemMessage := anObject
]
