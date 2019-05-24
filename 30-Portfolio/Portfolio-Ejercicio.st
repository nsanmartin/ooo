!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'nsm 5/23/2019 21:02:41'!
test01BalanceWithEmptyAccount
	| account portfolio |
	account _ ReceptiveAccount new. 
	portfolio _ Portfolio with: account.
	
	self assert: 0 equals: portfolio balance. ! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'nsm 5/23/2019 21:11:16'!
test02BalanceWithAccountAndPortfolio
	| account portfolio |
		
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	
	portfolio _ Portfolio with: account.
	
	self assert: 100 equals: portfolio balance. ! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'nsm 5/23/2019 21:12:46'!
test03AddingToPortfolio
	| account portfolio |
		
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	portfolio _ Portfolio with: account.
	
	account := ReceptiveAccount  new.
	Withdraw register: 50 on: account.
	portfolio add: account.
	
	self assert: 50 equals: portfolio balance. ! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'nsm 5/23/2019 21:18:12'!
test04CantAddTheSameAccountTwice
	| account portfolio |
		
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	portfolio _ Portfolio with: account.
	self
		should: [portfolio add: account.]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText equals: Portfolio cantAddTheSameAccountTwiceExceptionMessage].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'nsm 5/23/2019 21:28:45'!
test05CantAddAnAccountContainedInASubPortfolio
	| account portfolio portfolio2 |
		
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	portfolio _ Portfolio with: account.
	portfolio2 _ Portfolio with: portfolio.
	
	self
		should: [portfolio2 add: account]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText equals: Portfolio cantAddTheSameAccountTwiceExceptionMessage].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'nsm 5/23/2019 21:41:45'!
test06CantAddPortfoliosWithRepeatedAccounts
	| account portfolio portfolio2 superPortfolio |
		
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	portfolio _ Portfolio with: account.
	portfolio2 _ Portfolio with: account.
	superPortfolio _ Portfolio with: portfolio.
	
	self
		should: [superPortfolio add: portfolio2.]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText equals: Portfolio cantAddTheSameAccountTwiceExceptionMessage].! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'nsm 5/23/2019 20:19:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'nsm 5/23/2019 20:48:48'!
affectBalance: aBalance
	self subclassResponsibility. ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'nsm 5/23/2019 20:16:52'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'nsm 5/23/2019 20:47:29'!
affectBalance: aBalance
	^ aBalance + self value.! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'nsm 5/23/2019 20:49:22'!
affectBalance: aBalance
	^ aBalance - self value.! !

!Withdraw methodsFor: 'value' stamp: 'nsm 5/23/2019 20:30:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accountsAndPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'nsm 5/23/2019 21:39:02'!
balance
	^ accountsAndPortfolios sum: [ :account | account balance ].! !


!Portfolio methodsFor: 'initialization' stamp: 'nsm 5/23/2019 21:39:02'!
initializeWith: anAccount
	accountsAndPortfolios _ OrderedCollection with: anAccount.! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'nsm 5/23/2019 21:51:47'!
add: aReceptiveAccount 
	(accountsAndPortfolios anySatisfy: [ :account| account hasRepeatedAccountsWith: aReceptiveAccount])  ifTrue: [self error: self class cantAddTheSameAccountTwiceExceptionMessage ].
	accountsAndPortfolios add:aReceptiveAccount .! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'nsm 5/23/2019 21:51:47'!
hasRepeatedAccountsWith: anAccountable
	^ accountsAndPortfolios anySatisfy: [ :accountable| accountable hasRepeatedAccountsWith: anAccountable ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'nsm 5/23/2019 21:19:39'!
cantAddTheSameAccountTwiceExceptionMessage
	^ 'A Portfolio must not have the same acount twice'.! !

!Portfolio class methodsFor: 'instance creation' stamp: 'nsm 5/23/2019 21:06:20'!
with: aReceptiveAccount 
	^ self new initializeWith: aReceptiveAccount .! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'nsm 5/23/2019 21:37:48'!
hasAccount: anAccount
	^ self = anAccount .! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'nsm 5/23/2019 20:45:09'!
balance

	^transactions inject: 0 into: [ :balance :aTransaction |
		aTransaction affectBalance: balance 
	] ! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !
