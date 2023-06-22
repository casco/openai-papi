"
```Smalltalk
WAAdmin register: ChatGptCloneComponent asApplicationAt: 'chat'
```
"
Class {
	#name : #ChatGptCloneComponent,
	#superclass : #WAComponent,
	#instVars : [
		'client',
		'messageText',
		'conversationAnchor'
	],
	#category : #'OpenAI-ChatGptClone'
}

{ #category : #accessing }
ChatGptCloneComponent >> demoAnchor [
	^'We will maintain a conversation is about the following text: 

The US Coast Guard said Thursday a “debris field” was discovered by a remotely operated vehicle near the Titanic and within the search area for the missing submersible with five people aboard.

“Experts within the unified command are evaluating the information,” the Coast Guard said. It is unclear if this debris field is connected to the missing submersible. The Coast Guard said it plans to host a press briefing at 3 p.m. ET to “discuss findings from the Horizon Arctic’’s ROV on the sea floor near the Titanic.”

A spokesperson for Pelagic Research Services confirmed to CNN their remote-operated vehicle, which was the first to conduct a search for the submersible on the sea floor, found the debris field.

The news comes as the search for the vessel, known as the Titan, has reached a “critical” stage, the co-founder of the company operating the submersible said Thursday.

Follow live Titanic submersible updates

“Today will be a critical day in this search and rescue mission, as the sub’’s life support supplies are starting to run low,” Guillermo Sohnlein, the co-founder of OceanGate, the company operating the expedition, said in a statement Thursday.


Sohnlein said he is “certain” that pilot Stockton Rush and the crew “realized days ago that the best thing they can do to ensure their rescue is to extend the limits of those supplies by relaxing as much as possible. I firmly believe that the time window available for their rescue is longer than what most people think.”

The Titan began its descent Sunday to explore the wreckage of the Titanic, located about 13,000 feet below sea level in the North Atlantic Ocean, with an estimated 96 hours of life support. The cramped vessel lost contact with its mother ship about 1 hour and 45 minutes into its dive, did not surface as expected and has not been heard from since.

The expedition, which cost participants $250,000, was billed as “a chance to step outside of everyday life and discover something truly extraordinary,” an archived version of OceanGate’’s website shows.

Aboard the Titan are Rush, the OceanGate CEO and founder, along with British businessman Hamish Harding, Pakistani billionaire Shahzada Dawood and his son Suleman Dawood, and French diver Paul-Henri Nargeolet, according to relatives and social media posts. Officials have not publicly named those aboard.

A file photo shows the RMS Titanic shipwreck from a viewport of an OceanGate Expeditions submersible.
What it''s like inside the Titanic-touring submersible that went missing with 5 people on board
The expedition reflects the ongoing fascination with the Titanic’’s wreckage more than a century after it hit an iceberg and sank on its maiden voyage, killing more than 1,500 people. The journey is also part of the growing business of wealthy adventure tourism, along with the space flights of Blue Origin or the rise of guided tours to Mount Everest.

The focus on the vessel has also renewed criticisms of OceanGate’’s approach to safety from employees and other industry leaders.

Yet even as the Titan’’s estimated oxygen levels are depleting, hope for positive news remains.'
]

{ #category : #accessing }
ChatGptCloneComponent >> initialize [

	super initialize.
	client := ChatClient new.
	conversationAnchor := self demoAnchor.
	client systemMessage:
		'We will maintain a conversation about the following text: '
		, conversationAnchor.
	messageText := ''
]

{ #category : #accessing }
ChatGptCloneComponent >> messageText [

	^ messageText
]

{ #category : #accessing }
ChatGptCloneComponent >> messageText: anObject [

	messageText := anObject
]

{ #category : #rendering }
ChatGptCloneComponent >> renderContentOn: html [

	client conversation do: [ :each |
		html paragraph with: [
			html strong: (each at: 'role') , ': '.
			html text: (each at: 'content') ] ].
	html form: [
		html textArea
			columns: 80;
			on: #messageText of: self.
		html break.
		html submitButton callback: [ self submitMessage ] ]
]

{ #category : #rendering }
ChatGptCloneComponent >> submitMessage [

	client acceptMessageFromUser: messageText.
	messageText := ''
]
