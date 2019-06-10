!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'EB 6/9/2019 18:28:48'!
test01NewCartShouldBeEmpty
	| cart |
	cart _ Cart withPriceList: {} asDictionary.
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'EB 6/9/2019 18:29:13'!
test02CartWithAddedBookShouldContainBook
	| cart bookIsbn priceList |
	bookIsbn _ 123.
	priceList _ {bookIsbn -> 23} asDictionary.
	cart _ Cart withPriceList: priceList.
	
	cart add: bookIsbn.
	
	self deny: cart isEmpty.
	self assert: (cart containsBook: bookIsbn).! !

!CartTest methodsFor: 'tests' stamp: 'EB 6/9/2019 18:30:11'!
test03EmptyCartShouldNotContainAnyBook
	| cart |
	cart _ Cart withPriceList: {} asDictionary.
	
	self deny: (cart containsBook: 123).! !

!CartTest methodsFor: 'tests' stamp: 'EB 6/9/2019 18:30:27'!
test04CantAddBookThatIsntInTheCatalog
	| cart |
	cart _ Cart withPriceList: {} asDictionary.

	self 
		should: [cart add: 123]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: (Cart bookNotInCatalogErrorMessage: 123) equals: exception messageText.
			
			self assert: cart isEmpty.
			self deny: (cart containsBook: 123). 
		].! !

!CartTest methodsFor: 'tests' stamp: 'EB 6/9/2019 18:31:07'!
test05CartWithMoreThanOneBookAddedShouldContainAll
	| cart |
	cart _ Cart withPriceList: {1 -> 1. 2 -> 2} asDictionary.
	
	cart add: 1.
	cart add: 2.
	 
	self deny: cart isEmpty.
	self assert: (cart containsBook: 1).
	self assert: (cart containsBook: 2).! !

!CartTest methodsFor: 'tests' stamp: 'EB 6/9/2019 18:31:21'!
test06AddingABookMoreThanOnceShouldIncrementBookCount
	| cart |
	cart _ Cart withPriceList: {1 -> 1. 2 -> 2} asDictionary.
	
	cart add: 1.
	cart add: 1.
	 
	self deny: cart isEmpty.
	self assert: (cart containsBook: 1).
	self assert: 2 equals: (cart bookCount: 1).! !

!CartTest methodsFor: 'tests' stamp: 'EB 6/9/2019 18:31:37'!
test07EmptyCartShouldHaveBookCount0ForAnyBook
	| cart |
	cart _ Cart withPriceList: {} asDictionary.
	 
	self assert: cart isEmpty.
	self assert: 0 equals: (cart bookCount: 1).! !

!CartTest methodsFor: 'tests' stamp: 'EB 6/9/2019 18:31:50'!
test08CartWithOneBookShouldHaveBookCount1ForThatBook
	| cart |
	cart _ Cart withPriceList: {1 -> 1. 2 -> 2} asDictionary.
	
	cart add: 1.
	
	self deny: cart isEmpty.
	self assert: 1 equals: (cart bookCount: 1).
	self assert: 0 equals: (cart bookCount: 2).! !

!CartTest methodsFor: 'tests' stamp: 'EB 6/9/2019 18:32:05'!
test09ContentsOfCartShouldContainAllBooks
	| cart contents |
	cart _ Cart withPriceList: {1 -> 1. 2 -> 2. 3 -> 3} asDictionary.
	
	cart add: 1.
	cart add: 2.
	cart add: 1.
	
	contents _ cart contents.
	
	self deny: cart isEmpty.
	self assert: 2 equals: (contents occurrencesOf: 1).
	self assert: 1 equals: (contents occurrencesOf: 2).
	self assert: 0 equals: (contents occurrencesOf: 3).! !

!CartTest methodsFor: 'tests' stamp: 'EB 6/9/2019 18:34:04'!
test10TotalPriceWithNoProductsShouldBe0

	| cart |

	cart _ Cart withPriceList: {} asDictionary.
	
	self assert: 0 equals: cart totalPrice.! !

!CartTest methodsFor: 'tests' stamp: 'EB 6/9/2019 18:38:45'!
test11TotalPriceWithProductsShouldBeTheSumOfThePrices

	| cart |

	cart _ Cart withPriceList: {1 -> 2. 2 -> 3} asDictionary. 
	
	cart add: 1.
	cart add: 1.
	cart add: 2.
	
	self assert: 7 equals: cart totalPrice.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'EB 6/9/2019 19:41:40'!
test01CantCheckoutAnEmptyCart
	
	| cart cashier creditCard date |
	
	cart _ Cart withPriceList: {} asDictionary.
	creditCard _ self sampleCreditCard. 
	cashier _ Cashier forCart: cart withMerchantProcessor: {}.
	
	date _ FixedGregorianDate today.
	
	self should: [ cashier checkoutWithCreditCard: creditCard onDate: date ] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: Cashier cantCheckoutAnEmptyCartErrorMessage equals: exception messageText ]! !

!CashierTest methodsFor: 'tests' stamp: 'EB 6/9/2019 19:45:22'!
test02CheckoutWithProductsShouldDebitTheRightAmountUsingTheCreditCard

	| cart cashier creditCard merchantProcessor date |

	cart _ Cart withPriceList: {1 -> 23. 2 -> 123} asDictionary.
	cart add: 1.
	cart add: 1.
	cart add: 2.
	
	merchantProcessor _ MerchantProcessorForTesting new.
	cashier _ Cashier forCart: cart withMerchantProcessor: merchantProcessor. 
	
	creditCard _ self sampleCreditCardWithExpiration: (June of: 2019).
	date _ FixedGregorianDate yearNumber: 2019 month: June dayNumber: 1.
	
	cashier checkoutWithCreditCard: creditCard onDate: date.
	
	self assert: cart totalPrice equals: merchantProcessor debitedAmount.
	self assert: 1 equals: merchantProcessor usedCreditCards size.
	self assert: creditCard equals: merchantProcessor usedCreditCards first.! !

!CashierTest methodsFor: 'tests' stamp: 'EB 6/9/2019 19:46:39'!
test03CantCheckoutWithExpiredCreditCard

	| cart cashier creditCard merchantProcessor date |

	cart _ Cart withPriceList: {1 -> 23. 2 -> 123} asDictionary.
	cart add: 1.
	cart add: 1.
	cart add: 2.
	
	merchantProcessor _ MerchantProcessorForTesting new.
	cashier _ Cashier forCart: cart withMerchantProcessor: merchantProcessor. 
	
	creditCard _ self sampleCreditCardWithExpiration: (June of: 2019).
	date _ FixedGregorianDate yearNumber: 2020 month: January dayNumber: 1.
	
	self should: [ cashier checkoutWithCreditCard: creditCard onDate: date ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: Cashier expiredCreditCardErrorMessage equals: exception messageText.
			
			self assert: 0 equals: merchantProcessor debitedAmount. ]! !


!CashierTest methodsFor: 'sample credit cards' stamp: 'EB 6/9/2019 19:44:02'!
sampleCreditCard
	^self sampleCreditCardWithExpiration: GregorianMonthOfYear current.! !

!CashierTest methodsFor: 'sample credit cards' stamp: 'EB 6/9/2019 19:29:32'!
sampleCreditCardWithExpiration: anExpiration 
	^CreditCard numbered: '1234567890123456' withOwner: 'JOSEFINA SMITH' andExpiration: anExpiration. ! !


!classDefinition: #CreditCardTest category: #TusLibros!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'EB 6/9/2019 02:44:38'!
test01NewCreditCardShouldHaveAllAttributesSet

	| creditCard expiration number owner |
	
	number _ '1234567890123456'.
	owner _ 'PEPE SANCHEZ'.
	expiration _ May of: 2019.
	creditCard _ CreditCard numbered: number withOwner: owner andExpiration: expiration.  

	self assert: number equals: creditCard number.
	self assert: owner equals: creditCard owner.
	self assert: expiration equals: creditCard expiration.! !

!CreditCardTest methodsFor: 'tests' stamp: 'EB 6/9/2019 02:24:12'!
test02ExpiredCreditCardShouldBeExpired

	| creditCard expiredDate |
	
	creditCard _ CreditCard numbered: '1234567890123456' withOwner: 'PEPE SANCHEZ' andExpiration: (May of: 2019).  
	expiredDate _ FixedGregorianDate yearNumber: 2019 month: June dayNumber: 1.
	
	self assert: (creditCard isExpiredOnDate: expiredDate). ! !

!CreditCardTest methodsFor: 'tests' stamp: 'EB 6/9/2019 02:33:31'!
test03CreditCardShouldNotBeExpiredOnSameYearMonthAsExpiration

	| creditCard notExpiredDate |
	
	creditCard _ CreditCard numbered: '1234567890123456' withOwner: 'PEPE SANCHEZ' andExpiration: (June of: 2019).  
	notExpiredDate _ FixedGregorianDate yearNumber: 2019 month: June dayNumber: 1.
	
	self deny: (creditCard isExpiredOnDate: notExpiredDate). ! !

!CreditCardTest methodsFor: 'tests' stamp: 'EB 6/9/2019 02:42:24'!
test04CreditCardShouldNotBeExpiredBeforeExpirationYearMonth

	| creditCard notExpiredDate |
	
	creditCard _ CreditCard numbered: '1234567890123456' withOwner: 'PEPE SANCHEZ' andExpiration: (June of: 2019).  
	notExpiredDate _ FixedGregorianDate yearNumber: 2019 month: May dayNumber: 24.
	
	self deny: (creditCard isExpiredOnDate: notExpiredDate). ! !

!CreditCardTest methodsFor: 'tests' stamp: 'EB 6/9/2019 17:59:30'!
test05CantCreateCreditCardWithNumberLengthDifferentFrom16

	self should: [ CreditCard numbered: '1' withOwner: 'PEPE SANCHEZ' andExpiration: (June of: 2019) ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: (CreditCard invalidNumberLengthErrorMessage: '1') equals: exception messageText ].
	! !

!CreditCardTest methodsFor: 'tests' stamp: 'EB 6/10/2019 12:31:41'!
test06NumberShouldHaveAllDigits

	| number |
	number _ '1234567890AB3456'.

	self should: [ CreditCard numbered: number withOwner: 'PEPE SANCHEZ' andExpiration: (June of: 2019) ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: (CreditCard numberShouldConsistOfDigitsErrorMessage: number) equals: exception messageText ].
	! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'books priceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'evaluating contents' stamp: 'EB 5/31/2019 17:38:02'!
bookCount: aBookIsbn
	^books occurrencesOf: aBookIsbn.! !

!Cart methodsFor: 'evaluating contents' stamp: 'EB 5/31/2019 17:28:48'!
containsBook: aBookIsbn
	^books includes: aBookIsbn.! !

!Cart methodsFor: 'evaluating contents' stamp: 'EB 5/31/2019 17:45:53'!
contents
	^books copy.! !

!Cart methodsFor: 'evaluating contents' stamp: 'EB 5/31/2019 17:29:28'!
isEmpty
	^books isEmpty.! !


!Cart methodsFor: 'initialization' stamp: 'EB 6/9/2019 18:35:51'!
initializeWithCatalog: aCatalog 
	priceList _ aCatalog.
	books _ Bag new.! !


!Cart methodsFor: 'adding books' stamp: 'EB 6/9/2019 18:35:51'!
add: aBookIsbn
	(priceList includesKey: aBookIsbn) ifFalse: [
		self error: (self class bookNotInCatalogErrorMessage: 123) ].
	books add: aBookIsbn.! !


!Cart methodsFor: 'price' stamp: 'EB 6/9/2019 18:37:51'!
totalPrice
	^books sum: [ :book | priceList at: book ] ifEmpty: [0].! !


!Cart methodsFor: 'accessing' stamp: 'EB 6/9/2019 18:43:19'!
priceList
	^priceList.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'EB 6/9/2019 18:28:39'!
withPriceList: aCatalog 
	^self new initializeWithCatalog: aCatalog.! !


!Cart class methodsFor: 'error messages' stamp: 'EB 5/31/2019 17:25:26'!
bookNotInCatalogErrorMessage: aBookIsbn 
	^'The book with ISBN ', aBookIsbn asString, ' isn''t present in the catalog.'.! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'priceList cart merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'EB 6/9/2019 19:08:43'!
initializeForCart: aCart withMerchantProcessor: aMerchantProcessor 
	cart _ aCart.
	merchantProcessor _ aMerchantProcessor.! !


!Cashier methodsFor: 'checkout' stamp: 'EB 6/9/2019 19:49:31'!
checkoutWithCreditCard: aCreditCard onDate: aDate
	self assertCartIsNotEmpty.
	self assertCreditCard: aCreditCard isNotExpiredOnDate: aDate.
	
	merchantProcessor debit: cart totalPrice with: aCreditCard.
! !


!Cashier methodsFor: 'assertions' stamp: 'EB 6/9/2019 19:47:44'!
assertCartIsNotEmpty
	
	cart isEmpty ifTrue: [
		self error: self class cantCheckoutAnEmptyCartErrorMessage ]. 
	! !

!Cashier methodsFor: 'assertions' stamp: 'EB 6/9/2019 19:49:55'!
assertCreditCard: aCreditCard isNotExpiredOnDate: aDate
	(aCreditCard isExpiredOnDate: aDate) ifTrue: [self error: self class expiredCreditCardErrorMessage ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'EB 6/9/2019 18:40:55'!
forCart: aCart withMerchantProcessor: aMerchantProcessor 
	^self new initializeForCart: aCart withMerchantProcessor: aMerchantProcessor.! !


!Cashier class methodsFor: 'error messages' stamp: 'EB 6/4/2019 21:02:44'!
cantCheckoutAnEmptyCartErrorMessage
	^'The cart is empty, there is nothing to checkout.'.! !

!Cashier class methodsFor: 'error messages' stamp: 'EB 6/9/2019 19:39:13'!
expiredCreditCardErrorMessage
	^'The credit card is expired.'.! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'number owner expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'EB 6/9/2019 02:30:35'!
initializeNumbered: aCreditCardNumber withOwner: anOwner andExpiration: anExpirationMonthOfYear 
	number _ aCreditCardNumber.
	owner _ anOwner.
	expiration _ anExpirationMonthOfYear.! !


!CreditCard methodsFor: 'expiration' stamp: 'EB 6/9/2019 02:43:57'!
isExpiredOnDate: aDate 
	^aDate monthOfYear > expiration.! !


!CreditCard methodsFor: 'accessing' stamp: 'EB 6/9/2019 02:31:30'!
expiration
	^expiration! !

!CreditCard methodsFor: 'accessing' stamp: 'EB 6/9/2019 02:28:31'!
number
	^number.! !

!CreditCard methodsFor: 'accessing' stamp: 'EB 6/9/2019 02:30:55'!
owner
	^owner! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'EB 6/10/2019 12:34:03'!
numbered: aCreditCardNumber withOwner: anOwner andExpiration: anExpirationMonthOfYear 

	self assertCreditCardNumberHasCorrectLength: aCreditCardNumber.
	self assertCreditCardNumberIsAllDigits: aCreditCardNumber.
	^self new initializeNumbered: aCreditCardNumber withOwner: anOwner andExpiration: anExpirationMonthOfYear.! !


!CreditCard class methodsFor: 'error messages' stamp: 'EB 6/9/2019 18:04:00'!
invalidNumberLengthErrorMessage: aCreditCardNumber
	^'The credit card number must have 16 digits. The one provided was: ', aCreditCardNumber.! !

!CreditCard class methodsFor: 'error messages' stamp: 'EB 6/10/2019 13:08:58'!
numberShouldConsistOfDigitsErrorMessage: aCreditCardNumber
	^'The number ', aCreditCardNumber, ' has characters that aren''t digits.'. ! !


!CreditCard class methodsFor: 'assertions' stamp: 'EB 6/10/2019 12:32:53'!
assertCreditCardNumberHasCorrectLength: aCreditCardNumber
	aCreditCardNumber size = 16 ifFalse: [
		self error: (self invalidNumberLengthErrorMessage: aCreditCardNumber) ].! !

!CreditCard class methodsFor: 'assertions' stamp: 'EB 6/10/2019 12:33:46'!
assertCreditCardNumberIsAllDigits: aCreditCardNumber
	aCreditCardNumber allSatisfy: [ :character | character isDigit ] :: ifFalse: [
		self error: (self numberShouldConsistOfDigitsErrorMessage: aCreditCardNumber) ].! !


!classDefinition: #MerchantProcessorForTesting category: #TusLibros!
Object subclass: #MerchantProcessorForTesting
	instanceVariableNames: 'debited creditCardsUsed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorForTesting methodsFor: 'debiting' stamp: 'EB 6/9/2019 19:13:34'!
debit: anAmount with: aCreditCard 
	debited _ debited + anAmount.
	creditCardsUsed add: aCreditCard.! !


!MerchantProcessorForTesting methodsFor: 'initialization' stamp: 'EB 6/9/2019 19:14:31'!
initialize
	debited _ 0.
	creditCardsUsed _ OrderedCollection new.! !


!MerchantProcessorForTesting methodsFor: 'accessing' stamp: 'EB 6/9/2019 19:14:59'!
debitedAmount
	^debited! !

!MerchantProcessorForTesting methodsFor: 'accessing' stamp: 'EB 6/9/2019 19:15:18'!
usedCreditCards
	^creditCardsUsed.! !
