!classDefinition: #IntegerReportTest category: #'Ingsoft-IntegerReports-ConMultipleIntegerReport'!
TestCase subclass: #IntegerReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConMultipleIntegerReport'!

!IntegerReportTest methodsFor: 'tests' stamp: 'HAW 5/12/2019 20:03:16'!
test01

	| lines report  integerToAnalize |
	
	integerToAnalize := 100.
	report := BasicIntegerPropertiesReport for: integerToAnalize.
	lines := ReadStream on: report value.
	
	self assert: 'Factorial: ', integerToAnalize factorial printString equals: lines next.
	self assert: 'Roman: ''', integerToAnalize printStringRoman, '''' equals: lines next.
	self assert: 'Ln: ', integerToAnalize ln printString equals: lines next.
	self assert: lines atEnd.
	
 ! !

!IntegerReportTest methodsFor: 'tests' stamp: 'HAW 5/12/2019 20:03:37'!
test02

	| lines report integerToAnalize |
	
	integerToAnalize := 200.
	report := IntegerOnDifferentBasesReport for: integerToAnalize.
	lines := ReadStream on: report value.
	
	self assert: 'Binary: ', (integerToAnalize storeStringBase: 2) equals: lines next.
	self assert: 'Octal: ', (integerToAnalize storeStringBase: 8) equals: lines next.
	self assert: 'Hexadecimal: ', (integerToAnalize storeStringBase: 16) equals: lines next.
	self assert: lines atEnd.
	
! !

!IntegerReportTest methodsFor: 'tests' stamp: 'HAW 5/12/2019 20:05:09'!
test03

	| lines report  integerToAnalize |
	
	integerToAnalize := 300.
	report := ComplexIntegerPropertiesReport for: integerToAnalize.
	lines := ReadStream on: report value.
	
	self assert: 'Prime?: ', integerToAnalize isPrime printString equals: lines next.
	self assert: 'Next Prime: ', integerToAnalize nextPrime printString equals: lines next.
	self assert: 'Sqrt: ', integerToAnalize sqrt printString equals: lines next.
	self assert: lines atEnd.
	
 ! !

!IntegerReportTest methodsFor: 'tests' stamp: 'EB 5/16/2019 19:09:21'!
test04

	| lines report  integerToAnalize |
	
	integerToAnalize := 300.
	report := CombinedIntegerPropertiesReport for: integerToAnalize.
	self 
		shouldnt: [ lines := ReadStream on: report value ]
		takeMoreThan: 1.5*second.
		
	self assert: 'Factorial: ', integerToAnalize factorial printString equals: lines next.
	self assert: 'Roman: ''', integerToAnalize printStringRoman, '''' equals: lines next.
	self assert: 'Ln: ', integerToAnalize ln printString equals: lines next.
	self assert: 'Prime?: ', integerToAnalize isPrime printString equals: lines next.
	self assert: 'Next Prime: ', integerToAnalize nextPrime printString equals: lines next.
	self assert: 'Sqrt: ', integerToAnalize sqrt printString equals: lines next.
	self assert: lines atEnd.
	
 ! !

!IntegerReportTest methodsFor: 'tests' stamp: 'HAW 5/12/2019 20:08:26'!
test05

	| lines report  integerToAnalize |
	
	integerToAnalize := 300.
	report := CompleteIntegerReport for: integerToAnalize.
	self 
		shouldnt: [ lines := ReadStream on: report value ]
		takeMoreThan: 1.5*second.

	self assert: 'Factorial: ', integerToAnalize factorial printString equals: lines next.
	self assert: 'Roman: ''', integerToAnalize printStringRoman, '''' equals: lines next.
	self assert: 'Ln: ', integerToAnalize ln printString equals: lines next.
	self assert: 'Prime?: ', integerToAnalize isPrime printString equals: lines next.
	self assert: 'Next Prime: ', integerToAnalize nextPrime printString equals: lines next.
	self assert: 'Sqrt: ', integerToAnalize sqrt printString equals: lines next.
	self assert: 'Binary: ', (integerToAnalize storeStringBase: 2) equals: lines next.
	self assert: 'Octal: ', (integerToAnalize storeStringBase: 8) equals: lines next.
	self assert: 'Hexadecimal: ', (integerToAnalize storeStringBase: 16) equals: lines next.
	self assert: lines atEnd.
	
 ! !


!IntegerReportTest methodsFor: 'assertions' stamp: 'HAW 5/12/2019 19:20:40'!
shouldnt: aClosureToMeasure takeMoreThan: aTimeLimit

	| elapsedTime |
	
	elapsedTime :=  aClosureToMeasure timeToRun * millisecond.
	
	self assert: elapsedTime <= aTimeLimit 
	
! !


!classDefinition: #IntegerReport category: #'Ingsoft-IntegerReports-ConMultipleIntegerReport'!
Object subclass: #IntegerReport
	instanceVariableNames: 'integerToAnalize'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConMultipleIntegerReport'!

!IntegerReport methodsFor: 'initialization' stamp: 'HAW 5/12/2019 19:11:29'!
initializeFor: anIntegerToAnalize

	integerToAnalize := anIntegerToAnalize ! !


!IntegerReport methodsFor: 'reporting' stamp: 'HAW 5/12/2019 19:12:35'!
value

	self subclassResponsibility ! !


!IntegerReport methodsFor: 'time consuption simulation' stamp: 'HAW 5/12/2019 19:14:02'!
wait

	(Delay forSeconds: 1) wait.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IntegerReport class' category: #'Ingsoft-IntegerReports-ConMultipleIntegerReport'!
IntegerReport class
	instanceVariableNames: ''!

!IntegerReport class methodsFor: 'instance creation' stamp: 'HAW 5/12/2019 19:11:34'!
for: anIntegerToAnalize

	^self new initializeFor: anIntegerToAnalize ! !


!classDefinition: #CombinedIntegerPropertiesReport category: #'Ingsoft-IntegerReports-ConMultipleIntegerReport'!
IntegerReport subclass: #CombinedIntegerPropertiesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConMultipleIntegerReport'!

!CombinedIntegerPropertiesReport methodsFor: 'reporting' stamp: 'EB 5/18/2019 16:08:12'!
value
	^MultipleIntegerPropertiesReport combiningReportsFrom: {
		BasicIntegerPropertiesReport. ComplexIntegerPropertiesReport. 
	} for: integerToAnalize :: value.! !


!classDefinition: #CompleteIntegerReport category: #'Ingsoft-IntegerReports-ConMultipleIntegerReport'!
IntegerReport subclass: #CompleteIntegerReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConMultipleIntegerReport'!

!CompleteIntegerReport methodsFor: 'reporting' stamp: 'EB 5/18/2019 16:16:17'!
value
	^MultipleIntegerPropertiesReport combiningReportsFrom: {
		CombinedIntegerPropertiesReport. IntegerOnDifferentBasesReport. 
	} for: integerToAnalize :: value.! !


!classDefinition: #IntegerOnDifferentBasesReport category: #'Ingsoft-IntegerReports-ConMultipleIntegerReport'!
IntegerReport subclass: #IntegerOnDifferentBasesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConMultipleIntegerReport'!

!IntegerOnDifferentBasesReport methodsFor: 'reporting - private' stamp: 'HAW 5/12/2019 20:04:56'!
addNumberInBase: aBase to: lines title: aTitle

	lines add: aTitle, ': ', (integerToAnalize storeStringBase: aBase).
	
	! !


!IntegerOnDifferentBasesReport methodsFor: 'reporting' stamp: 'HAW 5/12/2019 20:04:08'!
value

	| lines |
	
	self wait.
	lines := OrderedCollection new.
	self 
		addNumberInBase: 2 to: lines title: 'Binary';
		addNumberInBase: 8 to: lines title: 'Octal';
		addNumberInBase: 16 to: lines title: 'Hexadecimal'.
		
	^lines! !


!classDefinition: #IntegerPropertiesReport category: #'Ingsoft-IntegerReports-ConMultipleIntegerReport'!
IntegerReport subclass: #IntegerPropertiesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConMultipleIntegerReport'!

!IntegerPropertiesReport methodsFor: 'reporting - private' stamp: 'HAW 5/12/2019 20:02:54'!
addLineTo: lines title: aTitle with: anIntegerClosure

	lines add: aTitle, ': ', anIntegerClosure value printString
! !


!classDefinition: #BasicIntegerPropertiesReport category: #'Ingsoft-IntegerReports-ConMultipleIntegerReport'!
IntegerPropertiesReport subclass: #BasicIntegerPropertiesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConMultipleIntegerReport'!

!BasicIntegerPropertiesReport methodsFor: 'reporting' stamp: 'EB 5/16/2019 19:25:17'!
value

	| lines |
	
	self wait.
	lines := OrderedCollection new.
	self 
		addLineTo: lines title: 'Factorial' with: [ integerToAnalize factorial ];
		addLineTo: lines title: 'Roman' with: [ integerToAnalize printStringRoman ];
		addLineTo: lines title: 'Ln' with: [ integerToAnalize ln ].
		
	^lines! !


!classDefinition: #ComplexIntegerPropertiesReport category: #'Ingsoft-IntegerReports-ConMultipleIntegerReport'!
IntegerPropertiesReport subclass: #ComplexIntegerPropertiesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConMultipleIntegerReport'!

!ComplexIntegerPropertiesReport methodsFor: 'reporting' stamp: 'EB 5/16/2019 19:25:22'!
value

	| lines primalityTester |
	
	self wait.
	lines := OrderedCollection new.
	
	primalityTester _ TestDePrimalidad new.
	
	self 
		addLineTo: lines title: 'Prime?' with: [ primalityTester isPrime: integerToAnalize ];
		addLineTo: lines title: 'Next Prime' with: [ primalityTester nextPrime: integerToAnalize ];
		addLineTo: lines title: 'Sqrt' with: [ integerToAnalize sqrt ].
		
	^lines! !


!classDefinition: #MultipleIntegerPropertiesReport category: #'Ingsoft-IntegerReports-ConMultipleIntegerReport'!
Object subclass: #MultipleIntegerPropertiesReport
	instanceVariableNames: 'classesToCombine integerToAnalize'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConMultipleIntegerReport'!

!MultipleIntegerPropertiesReport methodsFor: 'initializing' stamp: 'EB 5/18/2019 16:12:36'!
initializeWithReportClasses: integerReportClasses andIntegerToAnalize: anInteger
	classesToCombine _ integerReportClasses.
	integerToAnalize _ anInteger.! !


!MultipleIntegerPropertiesReport methodsFor: 'as yet unclassified' stamp: 'EB 5/18/2019 16:15:05'!
value
	| blocksToExecute lines linesToAdd |
	linesToAdd _ OrderedCollection new.
	classesToCombine size timesRepeat: [
		linesToAdd add: [].
	].
	
	blocksToExecute _ classesToCombine withIndexCollect: [ :reportClass :index |
		[linesToAdd at: index put: (reportClass for: integerToAnalize) value.]
	].
	Parallelizer withBlocks: blocksToExecute :: execute.

	
	lines := OrderedCollection new.
	linesToAdd do: [ :someLinesToAdd |
		lines addAll: someLinesToAdd.
	].
		
	^lines! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MultipleIntegerPropertiesReport class' category: #'Ingsoft-IntegerReports-ConMultipleIntegerReport'!
MultipleIntegerPropertiesReport class
	instanceVariableNames: ''!

!MultipleIntegerPropertiesReport class methodsFor: 'instance creation' stamp: 'EB 5/18/2019 16:08:38'!
combiningReportsFrom: integerReportsClasses for: anInteger
	^self new initializeWithReportClasses: integerReportsClasses andIntegerToAnalize: anInteger.! !


!classDefinition: #Parallelizer category: #'Ingsoft-IntegerReports-ConMultipleIntegerReport'!
Object subclass: #Parallelizer
	instanceVariableNames: 'blocks blocksToExecute'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConMultipleIntegerReport'!

!Parallelizer methodsFor: 'as yet unclassified' stamp: 'EB 5/18/2019 15:46:03'!
execute
	| semaphore |
	semaphore _ Semaphore new.
	blocksToExecute do: [ :block |
		[
			block value.
			semaphore signal.
		] fork.
	].
	
	blocksToExecute size timesRepeat: [
		semaphore wait.
	].! !

!Parallelizer methodsFor: 'as yet unclassified' stamp: 'EB 5/18/2019 15:43:25'!
initializeWithBlocks: someBlocksToExecute
	blocksToExecute _ someBlocksToExecute.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Parallelizer class' category: #'Ingsoft-IntegerReports-ConMultipleIntegerReport'!
Parallelizer class
	instanceVariableNames: ''!

!Parallelizer class methodsFor: 'as yet unclassified' stamp: 'EB 5/18/2019 15:42:03'!
withBlocks: blocksToExecute
	^self new initializeWithBlocks: blocksToExecute! !


!classDefinition: #TestDePrimalidad category: #'Ingsoft-IntegerReports-ConMultipleIntegerReport'!
Object subclass: #TestDePrimalidad
	instanceVariableNames: 'integerToAnalize primosEncontrados'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConMultipleIntegerReport'!

!TestDePrimalidad methodsFor: 'as yet unclassified' stamp: 'EB 5/16/2019 18:56:39'!
fillWithNextPrime
	| lastPrime |
	lastPrime _ primosEncontrados last.
	primosEncontrados add: (self nextPrime: lastPrime).
	"newPrime _ lastPrime + 2.
	[self isPrime: newPrime :: not] whileTrue: [
		newPrime _ newPrime + 2.
	].
	primosEncontrados add: newPrime."! !

!TestDePrimalidad methodsFor: 'as yet unclassified' stamp: 'EB 5/16/2019 18:58:23'!
initialize
	primosEncontrados _ OrderedCollection with: 2.! !

!TestDePrimalidad methodsFor: 'as yet unclassified' stamp: 'EB 5/16/2019 18:43:01'!
isPrime: anInteger
	"Answer true if the receiver is a prime number. See isProbablyPrime for a probabilistic
	implementation that is much faster for large integers, and that is correct to an extremely
	high statistical level of confidence (effectively deterministic)."
	
	primosEncontrados do: [ :primo |
		anInteger \\ primo = 0 ifTrue: [^false].
		primo * primo > anInteger ifTrue: [^true].
	].
	
	
	[true] whileTrue: [ | nuevoPrimo |
		self fillWithNextPrime.
		nuevoPrimo _ primosEncontrados last.
		anInteger \\ nuevoPrimo = 0 ifTrue: [^false].
		nuevoPrimo * nuevoPrimo > anInteger ifTrue: [^true].
	].! !

!TestDePrimalidad methodsFor: 'as yet unclassified' stamp: 'EB 5/16/2019 18:58:59'!
nextPrime: anInteger
	| pivot |
	anInteger < 2 ifTrue: [^2].
	pivot := anInteger + 1 bitOr: 1.
	[self isPrime: pivot] whileFalse: [pivot := pivot + 2].
	^pivot! !
