"
```language=Pharo
client := STONFromText new.
client given: 'Alejandro reads a book' shouldObtain: (Dictionary new 
	at: 'subject' put: 'Alejandro';
	at: 'action' put: 'to read';
	at: 'object' put: 'a book';
	yourself).
client complete: 'Maria bakes cakes'.
```


"
Class {
	#name : #STONFromText,
	#superclass : #CompletionClient,
	#instVars : [
		'trainingExamples'
	],
	#category : #'OpenAI-API'
}

{ #category : #api }
STONFromText >> buildPromptWith: aString [

	| strm |
	strm := String new writeStream.
	trainingExamples keysAndValuesDo: [ :phrase :dictionary |
		strm
			nextPutAll: 'When I see "';
			nextPutAll: phrase;
			nextPutAll: '", I answer ';
			nextPutAll: (STON toString: dictionary);
			nextPutAll: '. When I see "';
			nextPutAll: aString;
			nextPutAll: '", I answer ' ].
	^ strm contents
]

{ #category : #api }
STONFromText >> complete: aString [

	^ STON fromString: (super complete: aString)
]

{ #category : #training }
STONFromText >> given: aString shouldObtain: aDictionary [
	trainingExamples at: aString put: aDictionary
]

{ #category : #initialization }
STONFromText >> initialize [ 	
	super initialize .
	trainingExamples := Dictionary new. 
]
