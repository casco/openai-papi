Class {
	#name : #AssistantsRun,
	#superclass : #Object,
	#instVars : [
		'id',
		'api',
		'thread',
		'assistant',
		'status',
		'requiredAction',
		'lastError',
		'metadata',
		'createdAt',
		'startedAt',
		'expiresAt',
		'canceledAt',
		'failedAt',
		'completedAt'
	],
	#category : #'OpenAI-Assistants'
}

{ #category : #'instance creation' }
AssistantsRun class >> in: aThread for: anAssistant with: anApi [

	^ self new
		  in: aThread for: anAssistant with: anApi;
		  yourself
]

{ #category : #accessing }
AssistantsRun >> api [

	^ api
]

{ #category : #accessing }
AssistantsRun >> api: anObject [

	api := anObject
]

{ #category : #accessing }
AssistantsRun >> assistantId [

	^ assistant id
]

{ #category : #accessing }
AssistantsRun >> canceledAt [

	^ canceledAt
]

{ #category : #accessing }
AssistantsRun >> canceledAt: anObject [

	canceledAt := anObject
]

{ #category : #accessing }
AssistantsRun >> completedAt [

	^ completedAt
]

{ #category : #accessing }
AssistantsRun >> completedAt: anObject [

	completedAt := anObject
]

{ #category : #accessing }
AssistantsRun >> createdAt [

	^ createdAt
]

{ #category : #accessing }
AssistantsRun >> createdAt: anObject [

	createdAt := anObject
]

{ #category : #accessing }
AssistantsRun >> expiresAt [

	^ expiresAt
]

{ #category : #accessing }
AssistantsRun >> expiresAt: anObject [

	expiresAt := anObject
]

{ #category : #accessing }
AssistantsRun >> failedAt [

	^ failedAt
]

{ #category : #accessing }
AssistantsRun >> failedAt: anObject [

	failedAt := anObject
]

{ #category : #accessing }
AssistantsRun >> fileIds [

	^ assistant fileIds
]

{ #category : #testing }
AssistantsRun >> hasExpired [

	^ status = 'expired'
]

{ #category : #testing }
AssistantsRun >> hasFailed [

	^ status = 'failed'
]

{ #category : #accessing }
AssistantsRun >> id [

	^ id
]

{ #category : #accessing }
AssistantsRun >> id: anObject [

	id := anObject
]

{ #category : #testing }
AssistantsRun >> ifCanceled: aOneArgumentBlock [

	status = 'canceled' ifTrue: aOneArgumentBlock
]

{ #category : #testing }
AssistantsRun >> ifCompleted: aOneArgumentBlock [

	status = 'completed' ifTrue: aOneArgumentBlock 
]

{ #category : #testing }
AssistantsRun >> ifExpired: aOneArgumentBlock [

	status = 'expired' ifTrue: aOneArgumentBlock
]

{ #category : #testing }
AssistantsRun >> ifFailed: aOneArgumentBlock [

	status = 'failed' ifTrue: aOneArgumentBlock
]

{ #category : #initialization }
AssistantsRun >> in: aThread for: anAssistant with: anApi [

	thread := aThread.
	assistant := anAssistant.
	api := anApi
]

{ #category : #accessing }
AssistantsRun >> instructions [

	^ assistant instructions
]

{ #category : #testing }
AssistantsRun >> isCanceled [

	^ status = 'canceled'
]

{ #category : #testing }
AssistantsRun >> isCancelling [

	^ status = 'cancelling'
]

{ #category : #testing }
AssistantsRun >> isCompleted [

	^ status = 'completed'
]

{ #category : #testing }
AssistantsRun >> isInProgress [

	^ status = 'in_progress'
]

{ #category : #testing }
AssistantsRun >> isQueued [

	^ status = 'queued'
]

{ #category : #accessing }
AssistantsRun >> lastError [

	^ lastError
]

{ #category : #accessing }
AssistantsRun >> lastError: anObject [

	lastError := anObject
]

{ #category : #messages }
AssistantsRun >> messages [

	thread updateMessages.
	^ thread messages select: [ :each | each runId = id ]
]

{ #category : #accessing }
AssistantsRun >> metadata [

	^ metadata
]

{ #category : #accessing }
AssistantsRun >> metadata: anObject [

	metadata := anObject
]

{ #category : #accessing }
AssistantsRun >> model [

	^ assistant model
]

{ #category : #monitoring }
AssistantsRun >> monitorEvery: seconds onCompletedDo: completedBlock onCanceledFailerOrExpiredDo: abnormalTerminationBlock [

	| monitor |
	monitor := AssistantsRunStatusMonitor new
		           run: self;
		           completedBlock: completedBlock;
		           expiredBlock: abnormalTerminationBlock;
		           failedBlock: abnormalTerminationBlock;
		           canceledBlock: abnormalTerminationBlock;
		           yourself.
	monitor startMonitoringEvery: seconds.
	^ monitor
]

{ #category : #accessing }
AssistantsRun >> requiredAction [

	^ requiredAction
]

{ #category : #accessing }
AssistantsRun >> requiredAction: anObject [

	requiredAction := anObject
]

{ #category : #testing }
AssistantsRun >> requiresAction [

	^ status = 'requires_action'
]

{ #category : #accessing }
AssistantsRun >> startedAt [

	^ startedAt
]

{ #category : #accessing }
AssistantsRun >> startedAt: anObject [

	startedAt := anObject
]

{ #category : #accessing }
AssistantsRun >> status [

	^ status
]

{ #category : #accessing }
AssistantsRun >> status: theNewStatus [
	status := theNewStatus.
	
]

{ #category : #accessing }
AssistantsRun >> thread [
	^ thread
]

{ #category : #accessing }
AssistantsRun >> threadId [

	^ thread id
]

{ #category : #accessing }
AssistantsRun >> tools [

	^ assistant tools
]

{ #category : #running }
AssistantsRun >> update [

	api updateRun: self
]

{ #category : #running }
AssistantsRun >> updateWith: aDictionary [

	self
		id: (aDictionary at: 'id');
		status: (aDictionary at: 'status');
		requiredAction: (aDictionary at: 'required_action' ifAbsent: [nil]);
		lastError: (aDictionary at: 'last_error' ifAbsent: [nil]);
		metadata: (aDictionary at: 'metadata' ifAbsent: [nil]);
		createdAt: (aDictionary at: 'created_at' ifAbsent: [nil]);
		startedAt: (aDictionary at: 'started_at' ifAbsent: [nil]);
		expiresAt: (aDictionary at: 'expires_at' ifAbsent: [nil]);
		canceledAt: (aDictionary at: 'canceled_at' ifAbsent: [nil]);
		failedAt: (aDictionary at: 'failed_at' ifAbsent: [nil]);
		completedAt: (aDictionary at: 'completed_at' ifAbsent: [nil]).

]
