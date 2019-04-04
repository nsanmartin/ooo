!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'EB 4/4/2019 19:59:13'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	self assert: [customerBook addCustomerNamed: 'John Lennon'.] doesNotTakeMoreTimeThan: 50 * millisecond.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'EB 4/4/2019 19:59:13'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney  := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	self assert: [customerBook removeCustomerNamed: paulMcCartney] doesNotTakeMoreTimeThan: 100 * millisecond.
		  
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'EB 4/4/2019 19:37:33'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	self assert: [ customerBook addCustomerNamed: ''.] 
		raises: Error 
		andThen: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'EB 4/4/2019 19:41:14'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self assert: [ customerBook removeCustomerNamed: 'Paul McCartney'.]
		raises: NotFound
		andThen: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ].
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'EB 4/4/2019 20:27:42'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	paulMcCartney := 'Paul McCartney'.
	customerBook := self newCustomerBookWithSuspendedCustomer: paulMcCartney.
	
	self assert: customerBook  hasActiveCustomers: 0 hasSuspendedCustomers: 1 hasTotalCustomers: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'EB 4/4/2019 20:28:14'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self newCustomerBookWithSuspendedCustomer: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.

	self assert: customerBook  hasActiveCustomers: 0 hasSuspendedCustomers: 0 hasTotalCustomers: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'EB 4/4/2019 20:18:29'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	self assert: customerBook cantSuspendCustomerNamed: 'Paul McCartney' andStillHasCustomerNamed: johnLennon.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'EB 4/4/2019 20:20:09'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
	johnLennon := 'John Lennon'.
	customerBook := self newCustomerBookWithSuspendedCustomer: johnLennon. 
	self assert: customerBook cantSuspendCustomerNamed: johnLennon andStillHasCustomerNamed: johnLennon.	! !


!CustomerBookTest methodsFor: 'helpers' stamp: 'EB 4/4/2019 20:23:03'!
assert: customerBook 
	"comment stating purpose of message"

	| |
! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'EB 4/4/2019 20:17:31'!
assert: customerBook cantSuspendCustomerNamed: suspendedCustomerName andStillHasCustomerNamed: maintainedCustomerName
	|numberOfCustomers|
	numberOfCustomers := customerBook numberOfCustomers.
	self assert: [customerBook suspendCustomerNamed: suspendedCustomerName]
		raises: CantSuspend
		andThen: [ :anError | 
			self assert: customerBook numberOfCustomers = numberOfCustomers.
			self assert: (customerBook includesCustomerNamed: maintainedCustomerName).]
! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'EB 4/4/2019 19:59:13'!
assert: closure doesNotTakeMoreTimeThan: milliseconds
	self assert: (Time millisecondsToRun: closure) < milliseconds.! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'EB 4/4/2019 20:26:24'!
assert: customerBook hasActiveCustomers: activeCustomers hasSuspendedCustomers: suspendedCustomers hasTotalCustomers: totalCustomers
	self assert: activeCustomers equals: customerBook numberOfActiveCustomers.
	self assert: suspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: totalCustomers equals: customerBook numberOfCustomers.
	! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'EB 4/4/2019 19:42:32'!
assert: testedCollaborations raises: errorClass andThen: closureAfter   
	[ testedCollaborations value.
	self fail ]
		on: errorClass 
		do: closureAfter! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'EB 4/4/2019 19:51:25'!
newCustomerBookWithSuspendedCustomer: customerName
	|customerBook|
	customerBook := CustomerBook new.
	
	customerBook addCustomerNamed: customerName.
	customerBook suspendCustomerNamed: customerName.
	^customerBook! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'EB 4/4/2019 20:53:05'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'EB 4/4/2019 20:54:17'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'EB 4/4/2019 21:02:13'!
removeCustomerNamed: aName 
	 active remove: aName ifAbsent: [
		 suspended remove: aName ifAbsent: [^NotFound signal]
	].
	^ aName.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/3/2019 10:16:22'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/3/2019 10:16:31'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
