!classDefinition: #IntegerReportTest category: #'Ingsoft-IntegerReports-ConFork'!
TestCase subclass: #IntegerReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConFork'!

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


!classDefinition: #IntegerReport category: #'Ingsoft-IntegerReports-ConFork'!
Object subclass: #IntegerReport
	instanceVariableNames: 'integerToAnalize'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConFork'!

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

!classDefinition: 'IntegerReport class' category: #'Ingsoft-IntegerReports-ConFork'!
IntegerReport class
	instanceVariableNames: ''!

!IntegerReport class methodsFor: 'instance creation' stamp: 'HAW 5/12/2019 19:11:34'!
for: anIntegerToAnalize

	^self new initializeFor: anIntegerToAnalize ! !


!classDefinition: #CombinedIntegerPropertiesReport category: #'Ingsoft-IntegerReports-ConFork'!
IntegerReport subclass: #CombinedIntegerPropertiesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConFork'!

!CombinedIntegerPropertiesReport methodsFor: 'reporting' stamp: 'EB 5/16/2019 19:25:00'!
value

	| basicPropertiesLines complexPropertiesLines lines semaphore |
	
	lines := OrderedCollection new.
	semaphore := Semaphore new.
	[
		basicPropertiesLines := (BasicIntegerPropertiesReport for: integerToAnalize) value.
		semaphore signal
	] fork.
	[
		complexPropertiesLines := (ComplexIntegerPropertiesReport for: integerToAnalize) value.
		semaphore signal
	] fork.

	semaphore wait; wait.

	lines 
		addAll: basicPropertiesLines;
		addAll: complexPropertiesLines.
		
	^lines! !


!classDefinition: #CompleteIntegerReport category: #'Ingsoft-IntegerReports-ConFork'!
IntegerReport subclass: #CompleteIntegerReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConFork'!

!CompleteIntegerReport methodsFor: 'reporting' stamp: 'EB 5/16/2019 19:27:03'!
value

	| combinedPropertiesLines differentBasesLines lines semaphore |
	
	lines := OrderedCollection new.	
	semaphore := Semaphore new.
	[
		combinedPropertiesLines := (CombinedIntegerPropertiesReport for: integerToAnalize) value.
		semaphore signal.
	] fork.
	[
		differentBasesLines := (IntegerOnDifferentBasesReport for: integerToAnalize) value.
		semaphore signal.
	] fork.

	semaphore wait; wait.
		
	lines
		addAll: combinedPropertiesLines;
		addAll: differentBasesLines.
		
	^lines! !


!classDefinition: #IntegerOnDifferentBasesReport category: #'Ingsoft-IntegerReports-ConFork'!
IntegerReport subclass: #IntegerOnDifferentBasesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConFork'!

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


!classDefinition: #IntegerPropertiesReport category: #'Ingsoft-IntegerReports-ConFork'!
IntegerReport subclass: #IntegerPropertiesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConFork'!

!IntegerPropertiesReport methodsFor: 'reporting - private' stamp: 'HAW 5/12/2019 20:02:54'!
addLineTo: lines title: aTitle with: anIntegerClosure

	lines add: aTitle, ': ', anIntegerClosure value printString
! !


!classDefinition: #BasicIntegerPropertiesReport category: #'Ingsoft-IntegerReports-ConFork'!
IntegerPropertiesReport subclass: #BasicIntegerPropertiesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConFork'!

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


!classDefinition: #ComplexIntegerPropertiesReport category: #'Ingsoft-IntegerReports-ConFork'!
IntegerPropertiesReport subclass: #ComplexIntegerPropertiesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConFork'!

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


!classDefinition: #TestDePrimalidad category: #'Ingsoft-IntegerReports-ConFork'!
Object subclass: #TestDePrimalidad
	instanceVariableNames: 'integerToAnalize primosEncontrados'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports-ConFork'!

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
