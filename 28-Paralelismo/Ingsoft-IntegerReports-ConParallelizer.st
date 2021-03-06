!classDefinition: #IntegerReportTest category: #'Ingsoft-IntegerReports-ConParallelizer'!
TestCase subclass: #IntegerReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConParallelizer'!

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


!classDefinition: #IntegerReport category: #'Ingsoft-IntegerReports-ConParallelizer'!
Object subclass: #IntegerReport
	instanceVariableNames: 'integerToAnalize'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConParallelizer'!

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

!classDefinition: 'IntegerReport class' category: #'Ingsoft-IntegerReports-ConParallelizer'!
IntegerReport class
	instanceVariableNames: ''!

!IntegerReport class methodsFor: 'instance creation' stamp: 'HAW 5/12/2019 19:11:34'!
for: anIntegerToAnalize

	^self new initializeFor: anIntegerToAnalize ! !


!classDefinition: #CombinedIntegerPropertiesReport category: #'Ingsoft-IntegerReports-ConParallelizer'!
IntegerReport subclass: #CombinedIntegerPropertiesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConParallelizer'!

!CombinedIntegerPropertiesReport methodsFor: 'reporting' stamp: 'EB 5/18/2019 15:50:34'!
value

	| basicPropertiesLines complexPropertiesLines lines |
	
	Parallelizer withBlocks: {
		[basicPropertiesLines := (BasicIntegerPropertiesReport for: integerToAnalize) value.].
		[complexPropertiesLines := (ComplexIntegerPropertiesReport for: integerToAnalize) value.].
	} :: execute.

	lines := OrderedCollection new.
	lines 
		addAll: basicPropertiesLines;
		addAll: complexPropertiesLines.
		
	^lines! !


!classDefinition: #CompleteIntegerReport category: #'Ingsoft-IntegerReports-ConParallelizer'!
IntegerReport subclass: #CompleteIntegerReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConParallelizer'!

!CompleteIntegerReport methodsFor: 'reporting' stamp: 'EB 5/18/2019 15:50:18'!
value

	| combinedPropertiesLines differentBasesLines lines |
	
	Parallelizer withBlocks: {
		[combinedPropertiesLines := (CombinedIntegerPropertiesReport for: integerToAnalize) value.].
		[differentBasesLines := (IntegerOnDifferentBasesReport for: integerToAnalize) value.].
	} :: execute.

	lines := OrderedCollection new.		
	lines
		addAll: combinedPropertiesLines;
		addAll: differentBasesLines.
		
	^lines! !


!classDefinition: #IntegerOnDifferentBasesReport category: #'Ingsoft-IntegerReports-ConParallelizer'!
IntegerReport subclass: #IntegerOnDifferentBasesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConParallelizer'!

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


!classDefinition: #IntegerPropertiesReport category: #'Ingsoft-IntegerReports-ConParallelizer'!
IntegerReport subclass: #IntegerPropertiesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConParallelizer'!

!IntegerPropertiesReport methodsFor: 'reporting - private' stamp: 'HAW 5/12/2019 20:02:54'!
addLineTo: lines title: aTitle with: anIntegerClosure

	lines add: aTitle, ': ', anIntegerClosure value printString
! !


!classDefinition: #BasicIntegerPropertiesReport category: #'Ingsoft-IntegerReports-ConParallelizer'!
IntegerPropertiesReport subclass: #BasicIntegerPropertiesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConParallelizer'!

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


!classDefinition: #ComplexIntegerPropertiesReport category: #'Ingsoft-IntegerReports-ConParallelizer'!
IntegerPropertiesReport subclass: #ComplexIntegerPropertiesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConParallelizer'!

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


!classDefinition: #Parallelizer category: #'Ingsoft-IntegerReports-ConParallelizer'!
Object subclass: #Parallelizer
	instanceVariableNames: 'blocks blocksToExecute'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConParallelizer'!

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

!classDefinition: 'Parallelizer class' category: #'Ingsoft-IntegerReports-ConParallelizer'!
Parallelizer class
	instanceVariableNames: ''!

!Parallelizer class methodsFor: 'as yet unclassified' stamp: 'EB 5/18/2019 15:42:03'!
withBlocks: blocksToExecute
	^self new initializeWithBlocks: blocksToExecute! !


!classDefinition: #TestDePrimalidad category: #'Ingsoft-IntegerReports-ConParallelizer'!
Object subclass: #TestDePrimalidad
	instanceVariableNames: 'integerToAnalize primosEncontrados'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConParallelizer'!

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
