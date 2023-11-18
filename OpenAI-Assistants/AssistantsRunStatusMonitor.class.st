Class {
	#name : #AssistantsRunStatusMonitor,
	#superclass : #Object,
	#instVars : [
		'monitoringProcess',
		'run',
		'lastObservedStatus',
		'completedBlock',
		'expiredBlock',
		'failedBlock',
		'canceledBlock'
	],
	#category : #'OpenAI-Assistants'
}

{ #category : #accessing }
AssistantsRunStatusMonitor >> canceledBlock [

	^ canceledBlock
]

{ #category : #accessing }
AssistantsRunStatusMonitor >> canceledBlock: anObject [

	canceledBlock := anObject
]

{ #category : #monitoring }
AssistantsRunStatusMonitor >> checkForStatusChange [

	| newStatus |
	run update.
	newStatus := run status.
	lastObservedStatus ~= newStatus ifTrue: [ self runStatusChangedBlocks ]. 
	self stopIfNeeded. 



]

{ #category : #accessing }
AssistantsRunStatusMonitor >> completedBlock [

	^ completedBlock
]

{ #category : #accessing }
AssistantsRunStatusMonitor >> completedBlock: anObject [

	completedBlock := anObject
]

{ #category : #accessing }
AssistantsRunStatusMonitor >> expiredBlock [

	^ expiredBlock
]

{ #category : #accessing }
AssistantsRunStatusMonitor >> expiredBlock: anObject [

	expiredBlock := anObject
]

{ #category : #accessing }
AssistantsRunStatusMonitor >> failedBlock [

	^ failedBlock
]

{ #category : #accessing }
AssistantsRunStatusMonitor >> failedBlock: anObject [

	failedBlock := anObject
]

{ #category : #initialize }
AssistantsRunStatusMonitor >> initialize [

 	completedBlock := [ :theRun |  ].
	expiredBlock := [ :theRun |  ].
	failedBlock := [ :theRun |  ].
	canceledBlock := [ :theRun |  ]
]

{ #category : #accessing }
AssistantsRunStatusMonitor >> lastObservedStatus [

	^ lastObservedStatus
]

{ #category : #accessing }
AssistantsRunStatusMonitor >> lastObservedStatus: anObject [

	lastObservedStatus := anObject
]

{ #category : #accessing }
AssistantsRunStatusMonitor >> monitoringProcess [

	^ monitoringProcess
]

{ #category : #accessing }
AssistantsRunStatusMonitor >> monitoringProcess: anObject [

	monitoringProcess := anObject
]

{ #category : #accessing }
AssistantsRunStatusMonitor >> run: anObject [

	run := anObject
]

{ #category : #monitoring }
AssistantsRunStatusMonitor >> runStatusChangedBlocks [

	run
		ifCompleted: completedBlock;
		ifCanceled: canceledBlock;
		ifExpired: expiredBlock;
		ifFailed: failedBlock
]

{ #category : #monitoring }
AssistantsRunStatusMonitor >> startMonitoringEvery: seconds [

	monitoringProcess := [ 
	                     [ 
	                     self checkForStatusChange.
	                     (Delay forDuration: seconds) wait ] repeat ]
		                     fork
]

{ #category : #monitoring }
AssistantsRunStatusMonitor >> stopIfNeeded [

	run isQueued | run isInProgress ifFalse: [ self stopMonitoring  ] 



]

{ #category : #monitoring }
AssistantsRunStatusMonitor >> stopMonitoring [

	monitoringProcess ifNotNil: [ :it | 
		it terminate.
		monitoringProcess := nil ]
]
