!classDefinition: #GoLight category: #Semaforo!
DenotativeObjectMorph subclass: #GoLight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GoLight class' category: #Semaforo!
GoLight class
	instanceVariableNames: ''!

!GoLight class methodsFor: 'morph' stamp: 'EB 3/25/2019 21:02:53'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!GoLight class methodsFor: 'as yet unclassified' stamp: 'EB 3/25/2019 21:02:53'!
apagar
	self color: Color black! !

!GoLight class methodsFor: 'as yet unclassified' stamp: 'EB 3/25/2019 21:05:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !

!GoLight class methodsFor: 'as yet unclassified' stamp: 'EB 3/25/2019 21:05:03'!
prender
	self color: Color green! !


!classDefinition: #PrepareLight category: #Semaforo!
DenotativeObjectMorph subclass: #PrepareLight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PrepareLight class' category: #Semaforo!
PrepareLight class
	instanceVariableNames: ''!

!PrepareLight class methodsFor: 'morph' stamp: 'EB 3/25/2019 21:02:47'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!PrepareLight class methodsFor: 'as yet unclassified' stamp: 'EB 3/25/2019 21:02:47'!
apagar
	self color: Color black! !

!PrepareLight class methodsFor: 'as yet unclassified' stamp: 'EB 3/25/2019 21:05:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !

!PrepareLight class methodsFor: 'as yet unclassified' stamp: 'EB 3/25/2019 21:05:09'!
prender
	self color: Color yellow! !


!classDefinition: #Semaforo category: #Semaforo!
DenotativeObjectMorph subclass: #Semaforo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Semaforo class' category: #Semaforo!
Semaforo class
	instanceVariableNames: ''!

!Semaforo class methodsFor: 'morph' stamp: 'EB 3/25/2019 21:01:58'!
createMorph

	^LayoutMorph newColumn
		morphExtent: 60 @ 130;
		yourself
! !


!Semaforo class methodsFor: 'as yet unclassified' stamp: 'EB 3/25/2019 21:04:46'!
apagar
	GoLight apagar.
	PrepareLight apagar.
	StopLight apagar.! !

!Semaforo class methodsFor: 'as yet unclassified' stamp: 'EB 3/25/2019 21:05:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !

!Semaforo class methodsFor: 'as yet unclassified' stamp: 'EB 3/25/2019 21:04:39'!
prender
	self titilar5Veces.
! !

!Semaforo class methodsFor: 'as yet unclassified' stamp: 'EB 3/25/2019 21:04:32'!
titilar5Veces
	5 timesRepeat: [PrepareLight prender.
	(Delay forSeconds: 0.5) wait.
	PrepareLight apagar.
	(Delay forSeconds: 0.5) wait.].
! !


!classDefinition: #StopLight category: #Semaforo!
DenotativeObjectMorph subclass: #StopLight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StopLight class' category: #Semaforo!
StopLight class
	instanceVariableNames: ''!

!StopLight class methodsFor: 'morph' stamp: 'EB 3/25/2019 20:58:59'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!StopLight class methodsFor: 'as yet unclassified' stamp: 'EB 3/25/2019 21:02:39'!
apagar
	self color: Color black! !

!StopLight class methodsFor: 'as yet unclassified' stamp: 'EB 3/25/2019 21:05:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !

!StopLight class methodsFor: 'as yet unclassified' stamp: 'EB 3/25/2019 21:02:18'!
prender
	self color: Color red! !

GoLight initializeAfterFileIn!
PrepareLight initializeAfterFileIn!
Semaforo initializeAfterFileIn!
StopLight initializeAfterFileIn!