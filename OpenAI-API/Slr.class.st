"
slr := Slr new.
slr title: 'Adaptive gamification in Collaborative systems, a systematic mapping study'.
slr researchQuestions: 'RQ1: What are the approaches of personalization in gamified collaborative systems?
RQ2: What are the approaches of adaptation in gamified collaborative systems?
RQ3: What gamification elements have been used in the adaptation in gamified collaborative systems?
RQ4: Which research methods have been used in the evaluation of adaptation in gamified collaborative systems?
RQ5: Which user models have been used in adaptation of gamified collaborative systems?'.
slr inclusionCriteria: 'Papers that fulfill the search string.
Academic journal, conference, and workshop papers.
Discipline: Computer Science.
Abstract and keywords are available.
Publicated between 2009 and 2019.'.
slr exclusionCriteria: 'Papers written in other language different than English.
Papers out of scope (not collaborative projects). Editorial notes. Full books. Complete conference proceedings.'.
"
Class {
	#name : #Slr,
	#superclass : #Object,
	#instVars : [
		'title',
		'notes',
		'inclusionCriteria',
		'exclusionCriteria',
		'resultSets',
		'researchQuestions',
		'searchQueries'
	],
	#category : #'OpenAI-API'
}

{ #category : #examples }
Slr class >> marolios [

	| slr |
	slr := Slr new.
	slr title:
		'Adaptive gamification in Collaborative systems, a systematic mapping study'.
	slr researchQuestions:
		'RQ1: What are the approaches of personalization in gamified collaborative systems?
RQ2: What are the approaches of adaptation in gamified collaborative systems?
RQ3: What gamification elements have been used in the adaptation in gamified collaborative systems?
RQ4: Which research methods have been used in the evaluation of adaptation in gamified collaborative systems?
RQ5: Which user models have been used in adaptation of gamified collaborative systems?'.
	slr inclusionCriteria: 'Papers that fulfill the search string.
Academic journal, conference, and workshop papers.
Discipline: Computer Science.
Abstract and keywords are available.
Publicated between 2009 and 2019.'.
	slr exclusionCriteria:
		'Papers written in other language different than English.
Papers out of scope (not collaborative projects). Editorial notes. Full books. Complete conference proceedings.'.
	^ slr
]

{ #category : #accessing }
Slr >> exclusionCriteria [

	^ exclusionCriteria
]

{ #category : #accessing }
Slr >> exclusionCriteria: anObject [

	exclusionCriteria := anObject
]

{ #category : #accessing }
Slr >> inclusionCriteria [

	^ inclusionCriteria
]

{ #category : #accessing }
Slr >> inclusionCriteria: anObject [

	inclusionCriteria := anObject
]

{ #category : #initialize }
Slr >> initialize [

	resultSets := OrderedCollection new.
	title := ''.
	notes := ''.
	researchQuestions := ''.
	inclusionCriteria := ''.
	exclusionCriteria := ''.
	searchQueries := ''. 
	
]

{ #category : #accessing }
Slr >> notes [

	^ notes
]

{ #category : #accessing }
Slr >> notes: anObject [

	notes := anObject
]

{ #category : #printing }
Slr >> printOn: aStream [

	aStream
		nextPutAll: '#Title';
		crlf;
		nextPutAll: title;
		crlf;
		nextPutAll: '#Research questions';
		crlf;
		nextPutAll: researchQuestions;
		crlf;
		nextPutAll: '#Inclusion criteria';
		crlf;
		nextPutAll: inclusionCriteria;
		crlf;
		nextPutAll: '#Exclusion criteria';
		crlf;
		nextPutAll: exclusionCriteria;
		crlf
]

{ #category : #accessing }
Slr >> researchQuestions [

	^ researchQuestions
]

{ #category : #accessing }
Slr >> researchQuestions: anObject [

	researchQuestions := anObject
]

{ #category : #accessing }
Slr >> resultSets [

	^ resultSets
]

{ #category : #accessing }
Slr >> resultSets: anObject [

	resultSets := anObject
]

{ #category : #accessing }
Slr >> searchQueries [

	^ searchQueries
]

{ #category : #accessing }
Slr >> searchQueries: anObject [

	searchQueries := anObject
]

{ #category : #accessing }
Slr >> title [

	^ title
]

{ #category : #accessing }
Slr >> title: anObject [

	title := anObject
]
