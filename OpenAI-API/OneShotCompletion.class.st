"
```language=Pharo
OneShotCompletion new complete: 'Hola Manola ...'.
```
"
Class {
	#name : #OneShotCompletion,
	#superclass : #CompletionClient,
	#category : #'OpenAI-API-Completion'
}

{ #category : #api }
OneShotCompletion >> buildPromptWith: aString [

	^ aString
]
