!classDefinition: #AccountSummaryTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountSummaryTest methodsFor: 'testing' stamp: 'EB 5/29/2019 18:14:10'!
test01SummaryOfAnAccountWithoutTransactions
	| account expectedReport summary |
	account _ ReceptiveAccount new.
	summary _ AccountSummary of: account.
	expectedReport _ 'Balance = 0'.
	self assert: summary report equals: expectedReport.
	! !

!AccountSummaryTest methodsFor: 'testing' stamp: 'EB 5/29/2019 18:22:13'!
test02SummaryOfAnAccountWithDeposit
	| account expectedReport summary |
	account _ ReceptiveAccount new.
	Deposit register: 145 on: account.
	summary _ AccountSummary of: account.
	expectedReport _ 'Depósito por 145.', String newLineString, 'Balance = 145'.
	self assert: expectedReport equals: summary report.
	! !

!AccountSummaryTest methodsFor: 'testing' stamp: 'EB 5/29/2019 18:22:20'!
test03SummaryOfAnAccountWithWithdraw
	| account expectedReport summary |
	account _ ReceptiveAccount new.
	Withdraw register: 145 on: account.
	summary _ AccountSummary of: account.
	expectedReport _ 'Extracción por 145.', String newLineString, 'Balance = -145'.
	self assert: expectedReport equals: summary report.
	! !

!AccountSummaryTest methodsFor: 'testing' stamp: 'EB 5/29/2019 23:40:03'!
test04SummaryOfAnAccountWithTransferDeposit
	| expectedReport summary account1 account2 |
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	Transfer value: 23 from: account1 to: account2. 
	
	summary _ AccountSummary of: account1.
	expectedReport _ 'Salida por transferencia de 23.', String newLineString, 'Balance = -23'.
	
	self assert: expectedReport equals: summary report.
	! !

!AccountSummaryTest methodsFor: 'testing' stamp: 'EB 5/29/2019 23:51:44'!
test05SummaryOfAnAccountWithTransferWithdraw
	| expectedReport summary account1 account2 |
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	Transfer value: 23 from: account1 to: account2. 
	
	summary _ AccountSummary of: account2.
	expectedReport _ 'Entrada por transferencia de 23.', String newLineString, 'Balance = 23'.
	
	self assert: expectedReport equals: summary report.
	! !

!AccountSummaryTest methodsFor: 'testing' stamp: 'EB 5/30/2019 13:11:02'!
test06SummaryOfAnAccountWithMultipleTransactions
	| expectedReport summary account1 account2 |
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	Transfer value: 23 from: account1 to: account2. 
	Deposit register: 45 on: account1.
	
	summary _ AccountSummary of: account1.
	expectedReport _ 'Salida por transferencia de 23.', String newLineString,
	'Depósito por 45.', String newLineString, 'Balance = 22'.
	
	self assert: expectedReport equals: summary report.
	! !


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

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'nsm 5/25/2019 18:02:44'!
test07CantAddAnAccountContainedInASuperPortfolio
	| account subPortfolio superPortfolio account2 |
		
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	
	account2 := ReceptiveAccount  new.
	Withdraw register: 100 on: account.
	
	superPortfolio _ Portfolio with: account.
	subPortfolio _ Portfolio with: account2.
	
	superPortfolio add: subPortfolio.
	
	self
		should: [subPortfolio add: account]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText equals: Portfolio cantAddTheSameAccountTwiceExceptionMessage].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'nsm 5/25/2019 18:30:50'!
test08CantAddAnAccountContainedInFirstSuperPortfolioWhenAddingTwo
	| account subPortfolio firstSuperPortfolio account2 account3 secondSuperPortfolio |
		
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	
	account2 := ReceptiveAccount  new.
	Withdraw register: 100 on: account.
	
	account3 := ReceptiveAccount  new.
	
	firstSuperPortfolio _ Portfolio with: account.
	secondSuperPortfolio _ Portfolio with: account2.
	subPortfolio _ Portfolio with: account3.
	firstSuperPortfolio add: subPortfolio.
	secondSuperPortfolio add: subPortfolio.
	
	self
		should: [subPortfolio add: account]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText equals: Portfolio cantAddTheSameAccountTwiceExceptionMessage].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'EB 5/25/2019 21:50:33'!
test09PortfolioWithOneTransactionShouldHaveItRegistered
	| account portfolio transaction |
		
	account _ ReceptiveAccount  new.
	transaction _ Deposit register: 100 on: account.
	portfolio _ Portfolio with: account.
	
	self assert: (portfolio hasRegistered: transaction). ! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'EB 5/25/2019 21:52:51'!
test10PortfolioShouldNotHaveRegisteredOtherTransactions
	| portfolio |
	portfolio _ Portfolio with: ReceptiveAccount new.
	
	self deny: (portfolio hasRegistered: (Withdraw register: 42 on: ReceptiveAccount new)).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'EB 5/25/2019 22:00:53'!
test11PortfolioTransactionsDoesntHaveAnUnregisteredTransaction
	| portfolio account |
	account _ ReceptiveAccount new.
	portfolio _ Portfolio with: account.
	
	self deny: (portfolio transactions includes: (Withdraw register: 234 on: ReceptiveAccount new)).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'EB 5/25/2019 21:59:49'!
test12PortfolioTransactionsWithOneTransaction
	| portfolio account transaction |
	account _ ReceptiveAccount new.
	transaction _ Withdraw register: 234 on: account.
	portfolio _ Portfolio with: account.
	
	self assert: (portfolio transactions includes: transaction).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'EB 5/25/2019 22:05:05'!
test13PortfolioTransactionsWithTwoTransactionsInDifferentAccounts
	| portfolio account transaction account2 transaction2 transactions |
	account _ ReceptiveAccount new.
	transaction _ Withdraw register: 234 on: account.
	account2 _ ReceptiveAccount new.
	transaction2 _ Withdraw register: 235 on: account2.
	portfolio _ Portfolio with: account.
	portfolio add: account2.
	
	transactions _ portfolio transactions.
	
	self assert: (transactions includes: transaction).
	self assert: (transactions includes: transaction2).! !


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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'EB 5/29/2019 17:18:04'!
test08TransferBetweenTwoAccounts 

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer value: 100 from: account1 to: account2.
		
	self assert: -100 equals: account1 balance.
	self assert: 100 equals: account2 balance.! !


!classDefinition: #AccountSummary category: #'Portfolio-Ejercicio'!
Object subclass: #AccountSummary
	instanceVariableNames: 'accountable'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountSummary methodsFor: 'intialization' stamp: 'EB 5/29/2019 18:13:05'!
initializeWithAccountable: anAccountable 
	accountable _ anAccountable.! !


!AccountSummary methodsFor: 'reporting' stamp: 'EB 5/29/2019 23:21:02'!
report
	| visitor |
	visitor _ AccountSummaryVisitor new.
	accountable transactions do: [ :transaction | transaction accept: visitor ].
	^visitor report, 'Balance = ', accountable balance asString.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: #'Portfolio-Ejercicio'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'EB 5/29/2019 18:12:32'!
of: anAccountable 
	^self new initializeWithAccountable: anAccountable.! !


!classDefinition: #AccountSummaryVisitor category: #'Portfolio-Ejercicio'!
Object subclass: #AccountSummaryVisitor
	instanceVariableNames: 'report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountSummaryVisitor methodsFor: 'visiting' stamp: 'EB 5/29/2019 23:15:23'!
visitDeposit: aDeposit
	self addTransactionValueToReport: aDeposit withPrefix: 'Depósito por '.! !

!AccountSummaryVisitor methodsFor: 'visiting' stamp: 'EB 5/29/2019 23:53:03'!
visitTransferDeposit: aTransferDeposit 
	self addTransactionValueToReport: aTransferDeposit withPrefix: 'Entrada por transferencia de '.! !

!AccountSummaryVisitor methodsFor: 'visiting' stamp: 'EB 5/30/2019 13:05:03'!
visitTransferWithdraw: aTransferWithdraw 
	self addTransactionValueToReport: aTransferWithdraw withPrefix: 'Salida por transferencia de '.! !

!AccountSummaryVisitor methodsFor: 'visiting' stamp: 'EB 5/29/2019 23:15:41'!
visitWithdraw: aWithdraw
	self addTransactionValueToReport: aWithdraw withPrefix: 'Extracción por '.! !


!AccountSummaryVisitor methodsFor: 'report building' stamp: 'EB 5/29/2019 23:14:54'!
addTransactionValueToReport: aTransaction withPrefix: aPrefix
	report _ report, (
		String streamContents: [ :stream |
			self nextPutValueOfTransaction: aTransaction inStream: stream withPrefix: aPrefix.
		]
	)! !

!AccountSummaryVisitor methodsFor: 'report building' stamp: 'EB 5/29/2019 23:11:17'!
nextPutValueOfTransaction: aTransaction inStream: aStream withPrefix: aPrefix
	aStream
		nextPutAll: aPrefix;
		nextPutAll: aTransaction value asString;
		nextPut: $.;
		newLine.! !


!AccountSummaryVisitor methodsFor: 'report' stamp: 'EB 5/29/2019 23:15:50'!
report
	^report.! !


!AccountSummaryVisitor methodsFor: 'initialization' stamp: 'EB 5/29/2019 23:17:42'!
initialize
	report _ ''.! !


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


!AccountTransaction methodsFor: 'visiting' stamp: 'EB 5/29/2019 23:26:00'!
accept: aVisitor
	self subclassResponsibility.! !


!classDefinition: #SingleAccountTransaction category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #SingleAccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SingleAccountTransaction class' category: #'Portfolio-Ejercicio'!
SingleAccountTransaction class
	instanceVariableNames: ''!

!SingleAccountTransaction class methodsFor: 'instance creation' stamp: 'EB 5/29/2019 23:29:21'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
SingleAccountTransaction subclass: #Deposit
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


!Deposit methodsFor: 'visiting' stamp: 'EB 5/29/2019 22:56:52'!
accept: aVisitor
	aVisitor visitDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
SingleAccountTransaction subclass: #Withdraw
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


!Withdraw methodsFor: 'visiting' stamp: 'EB 5/29/2019 23:19:17'!
accept: aVisitor
	aVisitor visitWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferTransaction category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #TransferTransaction
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferTransaction methodsFor: 'value' stamp: 'EB 5/29/2019 17:59:02'!
value
	^transfer value.! !


!TransferTransaction methodsFor: 'initialization' stamp: 'EB 5/29/2019 17:59:06'!
initializeFor: aTransfer
	transfer _ aTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransaction class' category: #'Portfolio-Ejercicio'!
TransferTransaction class
	instanceVariableNames: ''!

!TransferTransaction class methodsFor: 'instance creation' stamp: 'EB 5/29/2019 17:59:10'!
for: aTransfer
	^self new initializeFor: aTransfer! !


!classDefinition: #TransferDeposit category: #'Portfolio-Ejercicio'!
TransferTransaction subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferDeposit methodsFor: 'value' stamp: 'EB 5/29/2019 17:58:01'!
affectBalance: aBalance
	^aBalance + self value.! !


!TransferDeposit methodsFor: 'visiting' stamp: 'EB 5/29/2019 23:52:13'!
accept: aVisitor 
	aVisitor visitTransferDeposit: self.! !


!classDefinition: #TransferWithdraw category: #'Portfolio-Ejercicio'!
TransferTransaction subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferWithdraw methodsFor: 'value' stamp: 'EB 5/29/2019 17:59:26'!
affectBalance: aBalance
	^aBalance - self value.! !


!TransferWithdraw methodsFor: 'visiting' stamp: 'EB 5/30/2019 13:05:03'!
accept: aVisitor 
	aVisitor visitTransferWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: #'Portfolio-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'as yet unclassified' stamp: 'EB 5/29/2019 17:31:18'!
for: aTransfer
	^self new initializeFor: aTransfer.! !


!classDefinition: #Accountable category: #'Portfolio-Ejercicio'!
Object subclass: #Accountable
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Accountable methodsFor: 'adding' stamp: 'EB 5/25/2019 22:25:09'!
addParent: anAccountable
	self subclassResponsibility.! !

!Accountable methodsFor: 'adding' stamp: 'EB 5/25/2019 22:27:02'!
hasRepeatedAccountsWith: anAccountable
	self subclassResponsibility.! !


!Accountable methodsFor: 'testing' stamp: 'EB 5/25/2019 22:26:03'!
hasAccount: anAccount
	self subclassResponsibility.! !

!Accountable methodsFor: 'testing' stamp: 'EB 5/25/2019 22:26:30'!
hasRegistered: aTransaction
	self subclassResponsibility.! !


!Accountable methodsFor: 'balance' stamp: 'EB 5/25/2019 22:27:34'!
balance
	self subclassResponsibility.! !


!Accountable methodsFor: 'transactions' stamp: 'EB 5/25/2019 22:28:16'!
transactions
	self subclassResponsibility.! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Accountable subclass: #Portfolio
	instanceVariableNames: 'accountsAndPortfolios parentPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'nsm 5/23/2019 21:39:02'!
balance
	^ accountsAndPortfolios sum: [ :account | account balance ].! !


!Portfolio methodsFor: 'initialization' stamp: 'EB 5/25/2019 22:28:37'!
initializeWith: anAccountable
	parentPortfolios  _ OrderedCollection new.
	accountsAndPortfolios _ OrderedCollection with: anAccountable.! !


!Portfolio methodsFor: 'adding' stamp: 'EB 5/25/2019 22:24:38'!
add: anAccountable
	(self parentsHaveRepeatedAccountsWith: anAccountable) ifTrue: [
		self error: self class cantAddTheSameAccountTwiceExceptionMessage ].
	accountsAndPortfolios add: anAccountable.
	anAccountable addParent: self.! !

!Portfolio methodsFor: 'adding' stamp: 'EB 5/25/2019 21:39:47'!
addParent: aPortfolio
	parentPortfolios add: aPortfolio.! !


!Portfolio methodsFor: 'testing' stamp: 'EB 5/25/2019 21:42:40'!
hasAccount: anAccount
	^ accountsAndPortfolios anySatisfy: [ :accountable | accountable hasAccount: anAccount ].! !

!Portfolio methodsFor: 'testing' stamp: 'EB 5/25/2019 21:54:15'!
hasRegistered: aTransaction 
	^ accountsAndPortfolios anySatisfy: [ :accountable | accountable hasRegistered: aTransaction ].! !

!Portfolio methodsFor: 'testing' stamp: 'EB 5/25/2019 21:42:34'!
hasRepeatedAccountsWith: anAccountable
	^ accountsAndPortfolios anySatisfy: [ :accountable | accountable hasRepeatedAccountsWith: anAccountable ]
	! !

!Portfolio methodsFor: 'testing' stamp: 'EB 5/25/2019 21:43:05'!
parentsHaveRepeatedAccountsWith: anAccountable
	parentPortfolios ifEmpty: [
		^ self hasRepeatedAccountsWith: anAccountable.
	].
	^ parentPortfolios anySatisfy: [ :parentPortfolio | parentPortfolio parentsHaveRepeatedAccountsWith: anAccountable ] .! !


!Portfolio methodsFor: 'transactions' stamp: 'EB 5/25/2019 22:09:36'!
transactions

	| totalTransactions |
	totalTransactions _ OrderedCollection new.
	accountsAndPortfolios do: [ :accountable |
			totalTransactions addAll: accountable transactions ].
	^totalTransactions.! !

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
Accountable subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


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


!ReceptiveAccount methodsFor: 'testing' stamp: 'nsm 5/25/2019 18:05:58'!
hasAccount: anAccount
	^ self = anAccount.! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'EB 5/25/2019 22:26:37'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'EB 5/25/2019 22:27:11'!
hasRepeatedAccountsWith: anAccountable
	^ anAccountable hasAccount: self.! !


!ReceptiveAccount methodsFor: 'adding' stamp: 'nsm 5/25/2019 18:16:33'!
addParent: aPortfolio
	.! !


!classDefinition: #Transfer category: #'Portfolio-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'withdraw deposit value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Transfer methodsFor: 'value' stamp: 'EB 5/29/2019 17:34:23'!
value
	^value! !


!Transfer methodsFor: 'initialization' stamp: 'EB 5/29/2019 17:37:43'!
initializeWithValue: aTransactionValue from: originReceptiveAccount to: destinationReceptiveAccount 
	value _ aTransactionValue.
	withdraw _ TransferWithdraw for: self.
	originReceptiveAccount register: withdraw.
	deposit _ TransferDeposit for: self.
	destinationReceptiveAccount register: deposit.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'Portfolio-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'EB 5/29/2019 17:20:42'!
value: aTransactionValue from: originReceptiveAccount to: destinationReceptiveAccount 
	^self new initializeWithValue: aTransactionValue from: originReceptiveAccount to: destinationReceptiveAccount.! !
