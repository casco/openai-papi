Class {
	#name : #SlrAssistant,
	#superclass : #GPTClient,
	#instVars : [
		'slr',
		'latestCriticToResearchQuestions'
	],
	#category : #'OpenAI-API'
}

{ #category : #api }
SlrAssistant >> criticizeResearchQuestions [

	| response requestConfig conversation |
	requestConfig := self baseConfig.

	conversation := OrderedCollection new.
	conversation add: self systemMessage.
	conversation add: (self userMessageWith:
			 'Critizise the research questions and suggest improvements with arguments supporting your suggestions.').

	requestConfig at: 'messages' put:  conversation asArray.
	response := STON fromString: (ZnClient new
			             url: self entdpointUrl;
			             headerAt: 'Authorization'
			             put: 'Bearer ' , self apiKey;
			             entity:
				             (ZnEntity text: (STON toJsonString: requestConfig));
			             contentType: ZnMimeType applicationJson;
			             post).
	latestCriticToResearchQuestions := (response at: 'choices') first
		                                   at: 'message'
]

{ #category : #private }
SlrAssistant >> entdpointUrl [

	^ 'https://api.openai.com/v1/chat/completions'
]

{ #category : #initialize }
SlrAssistant >> initialize [ 	
	super initialize .
	latestCriticToResearchQuestions := ''.
	model := 'gpt-3.5-turbo'.
	presencePenalty := 0.
]

{ #category : #accessing }
SlrAssistant >> latestCriticToResearchQuestions [

	^ latestCriticToResearchQuestions
]

{ #category : #accessing }
SlrAssistant >> slr [

	^ slr
]

{ #category : #accessing }
SlrAssistant >> slr: anObject [

	slr := anObject
]

{ #category : #messages }
SlrAssistant >> systemMessage [

	^ Dictionary new
		  at: 'role' put: 'system';
		  at: 'content'
		  put:
			  ('You are an expert in systematic literature reviews in computers science. You''ve been asked to help a student working on a review characterized as follows: \n'
			   , slr printString) withCRs;
		  yourself
]

{ #category : #messages }
SlrAssistant >> userMessageWith: aString [

	^ Dictionary new
		  at: 'role' put: 'system';
		  at: 'content' put: aString;
		  yourself
]
