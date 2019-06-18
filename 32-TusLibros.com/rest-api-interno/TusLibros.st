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

!CartTest methodsFor: 'tests' stamp: 'EB 6/11/2019 17:04:25'!
test12AddOfWithOneBookShouldAddIt

	| cart |

	cart _ Cart withPriceList: {1 -> 2. 2 -> 3} asDictionary. 
	
	cart add: 1 of: 1.
	
	self deny: cart isEmpty.
	self assert: (cart containsBook: 1).
	self assert: 1 equals: (cart bookCount: 1).! !

!CartTest methodsFor: 'tests' stamp: 'EB 6/11/2019 17:06:36'!
test13AddOfWithMoreThanOneBookShouldAddAllBooks

	| cart |

	cart _ Cart withPriceList: {1 -> 2. 2 -> 3} asDictionary. 
	
	cart add: 2 of: 1.
	cart add: 3 of: 2.
	
	self deny: cart isEmpty.
	self assert: (cart containsBook: 1).
	self assert: (cart containsBook: 2).
	self assert: 2 equals: (cart bookCount: 1).
	self assert: 3 equals: (cart bookCount: 2).! !

!CartTest methodsFor: 'tests' stamp: 'EB 6/11/2019 17:17:08'!
test14CantAddBooksWithNegativeAmount

	| cart |

	cart _ Cart withPriceList: {1 -> 2. 2 -> 3} asDictionary. 
	
	self should: [ cart add: -1 of: 1 ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: Cart cantAddANegativeAmountOfProductsErrorMessage equals: exception messageText.
			
			self assert: cart isEmpty.
			self deny: (cart containsBook: 1).
			self assert: 0 equals: (cart bookCount: 1). ].! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'EB 6/10/2019 15:03:07'!
test01CantCheckoutAnEmptyCart
	
	| cart cashier creditCard date merchantProcessor |
	
	cart _ Cart withPriceList: {} asDictionary.
	merchantProcessor _ MerchantProcessorForTesting new.
	cashier _ Cashier forCart: cart withMerchantProcessor: merchantProcessor.
	
	creditCard _ self sampleCreditCard. 
	date _ FixedGregorianDate today.
	
	self should: [ cashier checkoutWithCreditCard: creditCard onDate: date ] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: Cashier cantCheckoutAnEmptyCartErrorMessage equals: exception messageText.
			self assert: 0 equals: merchantProcessor debitedAmount. ]! !

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

!CreditCardTest methodsFor: 'tests' stamp: 'EB 6/10/2019 15:27:14'!
test07OwnerCantBeEmpty

	self should: [ CreditCard numbered: '1234567890123456' withOwner: '' andExpiration: (June of: 2019) ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: CreditCard ownerEmptyErrorMessage equals: exception messageText ].
	! !


!classDefinition: #TusLibrosApiTest category: #TusLibros!
TestCase subclass: #TusLibrosApiTest
	instanceVariableNames: 'extendedAssertions registeredClientId registeredClientPassword unregisteredClientId apiWithEmptyPriceList merchantProcessor secondRegisteredClientId secondRegisteredClientPassword now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/16/2019 14:28:16'!
advanceMinutesAmount: anAmountOfMinutes
	now _ now next: anAmountOfMinutes * TimeUnits minute.! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/15/2019 20:09:37'!
checkout: aCartId andListPurchasesInApi: aTusLibrosApi
	
	self checkout: aCartId withValidCreditCardInApi: aTusLibrosApi.
	^aTusLibrosApi listPurchasesOfClient: registeredClientId withPassword: registeredClientPassword.
	! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/15/2019 20:09:37'!
checkout: aCartId withValidCreditCardInApi: aTusLibrosApi
	
	^aTusLibrosApi checkout: aCartId withCreditCard: (CreditCardsForTestingFactory new nonExpiredCreditCard).
		! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/15/2019 20:50:14'!
setUp
	merchantProcessor _ MerchantProcessorForTesting new.
	apiWithEmptyPriceList _ self apiWithPriceList: Dictionary new.
	extendedAssertions _ ExtendedAssertions for: self.
	registeredClientId _ 'registered'.
	registeredClientPassword _ 'registeredPassword'.
	registeredClientId _ 'secondRegistered'.
	registeredClientPassword _ 'secondRegisteredPassword'.
	unregisteredClientId _ 'unregistered'.
	now _ GregorianDateTime now. 
	! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/13/2019 20:35:23'!
test01CantCreateCartWithInvalidCredentials
	
	extendedAssertions 
		should: [ apiWithEmptyPriceList createCartWithClientId: unregisteredClientId andPassword: '' ]
		raiseErrorWithMessageText: TusLibrosApi invalidUserCredentialsErrorMessage.! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/13/2019 20:35:23'!
test02ListCartCreatedWithValidCredentialsIsEmpty
	
	| cartContents cartId |
	
	cartId _ self createCartWithValidCredentials.
	
	cartContents _ apiWithEmptyPriceList listCart: cartId.
	self assert: cartContents isEmpty.! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/13/2019 20:35:23'!
test03CantListANonCreatedCart
	
	extendedAssertions 	
		should: [ apiWithEmptyPriceList listCart: 23 ]
		raiseErrorWithMessageText: (TusLibrosApi cartDoesNotExistErrorMessage: 23).! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/11/2019 21:28:01'!
test04DifferentCreatedCartsShouldHaveDifferentId

	| firstCartId secondCartId |
	
	firstCartId _ self createCartWithValidCredentials.
	secondCartId _ self createCartWithValidCredentials. 

	self deny: firstCartId = secondCartId.! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/13/2019 20:35:23'!
test05WhenListingManyCreatedCartsAllShouldBeEmpty

	| firstCartContents firstCartId secondCartContents secondCartId |
	
	firstCartId _ self createCartWithValidCredentials. 
	secondCartId _ self createCartWithValidCredentials. 
	
	firstCartContents _ apiWithEmptyPriceList listCart: firstCartId.
	secondCartContents _ apiWithEmptyPriceList listCart: secondCartId.
	
	self assert: firstCartContents isEmpty.
	self assert: secondCartContents isEmpty.! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/14/2019 01:07:01'!
test06CantAddAProductToNonCreatedCart

	| api |
	
	api _ self apiWithPriceList: {1 -> 2} asDictionary.
	
	extendedAssertions 
		should: [ api add: 1 ofBookWithIsbn: 123 toCart: 42 ]
		raiseErrorWithMessageText: (TusLibrosApi cartDoesNotExistErrorMessage: 42).
	! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/14/2019 01:08:44'!
test07AddedProductToExistingCartAppearsInList

	| api bookIsbn cartId contents |
	
	bookIsbn _ 1.
	api _ self apiWithPriceList: {bookIsbn -> 2} asDictionary.
	cartId _ self createCartWithValidCredentialsInApi: api.
	
	api add: 1 ofBookWithIsbn: bookIsbn toCart: cartId.

	contents _ api listCart: cartId.
	
	self deny: contents isEmpty.
	self assert: (contents includes: bookIsbn).
	self assert: 1 equals: (contents occurrencesOf: bookIsbn).! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/14/2019 01:08:44'!
test08ProductAddedWithAmountGreaterThanOneShouldAppearInListWithRightAmount

	| api bookIsbn cartId contents |
	
	bookIsbn _ 1.
	api _ self apiWithPriceList: {bookIsbn -> 2} asDictionary.
	cartId _ self createCartWithValidCredentialsInApi: api.
	
	api add: 42 ofBookWithIsbn: bookIsbn toCart: cartId.

	contents _ api listCart: cartId.
	
	self deny: contents isEmpty.
	self assert: (contents includes: bookIsbn).
	self assert: 42 equals: (contents occurrencesOf: bookIsbn).! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/14/2019 01:08:44'!
test09ManyProductsAddedToSameCartShouldBeListed

	| api cartId contents firstBookIsbn secondBookIsbn |
	
	firstBookIsbn _ 1.
	secondBookIsbn _ 2.
	api _ self apiWithPriceList: {firstBookIsbn -> 2. secondBookIsbn -> 34} asDictionary.
	cartId _ self createCartWithValidCredentialsInApi: api.
	
	api add: 42 ofBookWithIsbn: firstBookIsbn toCart: cartId.
	api add: 25 ofBookWithIsbn: secondBookIsbn toCart: cartId.
	contents _ api listCart: cartId.
	
	self deny: contents isEmpty.
	self assert: (contents includes: firstBookIsbn).
	self assert: 42 equals: (contents occurrencesOf: firstBookIsbn).
	self assert: (contents includes: secondBookIsbn).
	self assert: 25 equals: (contents occurrencesOf: secondBookIsbn).! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/14/2019 01:11:13'!
test10ProductsAddedToDifferentCartsShouldBeListedSeparated

	| api firstCartId firstContents firstBookIsbn secondBookIsbn secondCartId secondContents |
	
	firstBookIsbn _ 1.
	secondBookIsbn _ 2.
	api _ self apiWithPriceList: {firstBookIsbn -> 2. secondBookIsbn -> 34} asDictionary.
	firstCartId _ self createCartWithValidCredentialsInApi: api.
	secondCartId _ self createCartWithValidCredentialsInApi: api.
	
	api add: 42 ofBookWithIsbn: firstBookIsbn toCart: firstCartId.
	api add: 25 ofBookWithIsbn: secondBookIsbn toCart: secondCartId.
	
	firstContents _ api listCart: firstCartId.
	secondContents _ api listCart: secondCartId.
	
	self deny: firstContents isEmpty.
	self assert: (firstContents includes: firstBookIsbn).
	self assert: 42 equals: (firstContents occurrencesOf: firstBookIsbn).
	self deny: (firstContents includes: secondBookIsbn).
	
	self deny: secondContents isEmpty.
	self assert: (secondContents includes: secondBookIsbn).
	self assert: 25 equals: (secondContents occurrencesOf: secondBookIsbn).
	self deny: (secondContents includes: firstBookIsbn).! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/14/2019 01:21:36'!
test11CantAddLessThanOneBook

	| api cartId bookIsbn |
	
	bookIsbn _ 1.
	api _ self apiWithPriceList: {bookIsbn -> 2.} asDictionary.
	cartId _ self createCartWithValidCredentialsInApi: api.
	
	extendedAssertions 
		should: [ api add: 0 ofBookWithIsbn: bookIsbn toCart: cartId ]
		raiseErrorWithMessageText: (TusLibrosApi amountToAddCantBeLessThan1ErrorMessage: 0)
		withExceptionDo: [ :exception | self assert: (api listCart: cartId) isEmpty ].		! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/14/2019 01:27:48'!
test12CantAddProductNotInPriceList

	| cartId |
	
	cartId _ self createCartWithValidCredentials.
	
	self 
		should: [ apiWithEmptyPriceList add: 1 ofBookWithIsbn: 1 toCart: cartId ]
		raise: Error.		! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/15/2019 17:22:38'!
test13CantCheckoutANonCreatedCart

	| creditCard |
	
	creditCard _ CreditCardsForTestingFactory new nonExpiredCreditCard.
	
	extendedAssertions 
		should: [ apiWithEmptyPriceList checkout: 1 withCreditCard: creditCard ]
		raiseErrorWithMessageText: (TusLibrosApi cartDoesNotExistErrorMessage: 1)
		withExceptionDo: [ :exception |
			self assert: 0 equals: merchantProcessor debitedAmount ].! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/15/2019 17:08:23'!
test14CheckingOutAValidCartShouldDebitTheRightAmount

	| creditCard api cartId |
	
	api _ self apiWithPriceList: {1 -> 2. 2 -> 3} asDictionary.
	cartId _ self createCartWithValidCredentialsInApi: api.
	
	api add: 2 ofBookWithIsbn: 1 toCart: cartId.
	api add: 3 ofBookWithIsbn: 2 toCart: cartId.
		
	creditCard _ CreditCardsForTestingFactory new nonExpiredCreditCard.
	
	api checkout: cartId withCreditCard: creditCard.
	
	self assert: 13 equals: merchantProcessor debitedAmount.
	self assert: 1 equals: merchantProcessor usedCreditCards size.
	self assert: creditCard equals: merchantProcessor usedCreditCards first.! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/15/2019 17:21:54'!
test15CantCheckoutCartWithExpiredCreditCard

	| creditCard api cartId |
	
	api _ self apiWithPriceList: {1 -> 2} asDictionary.
	cartId _ self createCartWithValidCredentialsInApi: api.
	api add: 1 ofBookWithIsbn: 1 toCart: cartId.
	
	creditCard _ CreditCardsForTestingFactory new expiredCreditCard.
		
	self
		should: [ api checkout: cartId withCreditCard: creditCard ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: 0 equals: merchantProcessor debitedAmount ].! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/15/2019 17:24:34'!
test16CantCheckoutAnEmptyCart
	| creditCard api cartId |
	
	api _ self apiWithPriceList: {1 -> 2} asDictionary.
	cartId _ self createCartWithValidCredentialsInApi: api.
	
	creditCard _ CreditCardsForTestingFactory new nonExpiredCreditCard.
		
	self
		should: [ api checkout: cartId withCreditCard: creditCard ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: 0 equals: merchantProcessor debitedAmount ].! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/15/2019 17:40:13'!
test17ListingPurchasesWithoutAnyPurchasesShouldReturnAnEmptyList
	
	| purchases |
	
	purchases _ apiWithEmptyPriceList listPurchasesOfClient: registeredClientId withPassword: registeredClientPassword.
	
	self assert: Bag new equals: purchases amountPerBook.
	self assert: 0 equals: purchases totalAmount.
	! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/15/2019 19:10:23'!
test18ListingPurchasesWithOnePurchaseShouldReturnTheCorrectPurchaseAmount
	
	| purchases api cartId |
	
	api _ self apiWithPriceList: {1 -> 2} asDictionary.
	cartId _ self createCartWithValidCredentialsInApi: api.
	api add: 1 ofBookWithIsbn: 1 toCart: cartId.
	
	purchases _ self checkout: cartId andListPurchasesInApi: api.
	
	self assert: (Bag with: 1) equals: purchases amountPerBook.
	self assert: 1 equals: purchases totalAmount.
	! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/15/2019 19:10:23'!
test19ListingPurchasesWithManyBooksShouldReturnTheCorrectPurchaseAmount
	
	| purchases api cartId resultingAmountsPerBook |
	
	api _ self apiWithPriceList: {1 -> 2. 2 -> 2} asDictionary.
	cartId _ self createCartWithValidCredentialsInApi: api.
	api add: 3 ofBookWithIsbn: 1 toCart: cartId.
	api add: 1 ofBookWithIsbn: 2 toCart: cartId.
	
	purchases _ self checkout: cartId andListPurchasesInApi: api.
	
	resultingAmountsPerBook _ Bag new.
	resultingAmountsPerBook add: 1 withOccurrences: 3. 
	resultingAmountsPerBook add: 2.
	
	self assert: resultingAmountsPerBook equals: purchases amountPerBook.
	self assert: 4 equals: purchases totalAmount.
	! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/15/2019 20:09:37'!
test20ListingPurchasesWithManyCheckoutsShouldReturnTheCorrectPurchaseAmount
	
	| purchases api cartId resultingAmountsPerBook |
	
	api _ self apiWithPriceList: {1 -> 2. 2 -> 2} asDictionary.
	cartId _ self createCartWithValidCredentialsInApi: api.
	api add: 3 ofBookWithIsbn: 1 toCart: cartId.
	
	self checkout: cartId withValidCreditCardInApi: api.
	
	cartId _ self createCartWithValidCredentialsInApi: api.
	api add: 2 ofBookWithIsbn: 1 toCart: cartId.
	api add: 1 ofBookWithIsbn: 2 toCart: cartId.
	
	purchases _ self checkout: cartId andListPurchasesInApi: api.
	
	resultingAmountsPerBook _ Bag new.
	resultingAmountsPerBook add: 1 withOccurrences: 5. 
	resultingAmountsPerBook add: 2.
	
	self assert: resultingAmountsPerBook equals: purchases amountPerBook.
	self assert: 6 equals: purchases totalAmount.
	! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/15/2019 20:09:37'!
test21ListingPurchasesOfDifferentClientsShouldListCorrespondingPurchases
	
	| api cartId firstResultingAmountsPerBook firstPurchases secondPurchases secondResultingAmountsPerBook |
	
	api _ self apiWithPriceList: {1 -> 2. 2 -> 2} asDictionary.
	
	cartId _ api createCartWithClientId: registeredClientId andPassword: registeredClientPassword.
	api add: 5 ofBookWithIsbn: 1 toCart: cartId.
	
	self checkout: cartId withValidCreditCardInApi: api.
	
	cartId _ api createCartWithClientId: secondRegisteredClientId andPassword: secondRegisteredClientPassword.
	api add: 2 ofBookWithIsbn: 1 toCart: cartId.
	api add: 1 ofBookWithIsbn: 2 toCart: cartId.
	
	self checkout: cartId withValidCreditCardInApi: api.
	
	firstPurchases _ api listPurchasesOfClient: registeredClientId withPassword: registeredClientPassword.
	secondPurchases _ api listPurchasesOfClient: secondRegisteredClientId withPassword: secondRegisteredClientPassword.
	
	firstResultingAmountsPerBook _ Bag new.
	firstResultingAmountsPerBook add: 1 withOccurrences: 5. 
	
	self assert: firstResultingAmountsPerBook equals: firstPurchases amountPerBook.
	self assert: 5 equals: firstPurchases totalAmount.
	firstPurchases _ api listPurchasesOfClient: registeredClientId withPassword: registeredClientPassword.
	
	secondResultingAmountsPerBook _ Bag new.
	secondResultingAmountsPerBook add: 1 withOccurrences: 2. 
	secondResultingAmountsPerBook add: 2.
	
	self assert: secondResultingAmountsPerBook equals: secondPurchases amountPerBook.
	self assert: 3 equals: secondPurchases totalAmount.
	
	! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/15/2019 19:58:27'!
test22CantListPurchasesOfNonRegisteredClient
	
	extendedAssertions 
		should: [ apiWithEmptyPriceList listPurchasesOfClient: unregisteredClientId withPassword: '' ]
		raiseErrorWithMessageText: TusLibrosApi invalidUserCredentialsErrorMessage.! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/15/2019 20:09:37'!
test23TwoDifferentCheckoutsShouldHaveDifferentTransactionIds

	| api cartId firstTransactionId secondCartId secondTransactionId |
	
	api _ self apiWithPriceList: {1 -> 2} asDictionary.	
	cartId _ self createCartWithValidCredentialsInApi: api.
	secondCartId _ self createCartWithValidCredentialsInApi: api.
	
	api add: 1 ofBookWithIsbn: 1 toCart: cartId. 
	api add: 2 ofBookWithIsbn: 1 toCart: secondCartId.
	
	firstTransactionId _ self checkout: cartId withValidCreditCardInApi: api.
	secondTransactionId _ self checkout: secondCartId withValidCreditCardInApi: api.
	
	self deny: firstTransactionId = secondTransactionId. ! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/18/2019 14:02:12'!
test24CantCheckoutSameCartTwice

	| api cartId |
	
	api _ self apiWithPriceList: {1 -> 2} asDictionary.	
	cartId _ self createCartWithValidCredentialsInApi: api.
	api add: 1 ofBookWithIsbn: 1 toCart: cartId. 
	
	self checkout: cartId withValidCreditCardInApi: api.
	
	extendedAssertions
		should: [ self checkout: cartId withValidCreditCardInApi: api ]
		raiseErrorWithMessageText: (TusLibrosApi cartAlreadyCheckedOutErrorMessage: cartId)
		withExceptionDo: [ :exception |
			self assert: 2 equals: merchantProcessor debitedAmount ].! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/18/2019 13:48:26'!
test25CantAddToCartAfter30MinutesHavePassed

	| api cartId |

	api _ self apiWithPriceList: {1 -> 2} asDictionary.	
	cartId _ self createCartWithValidCredentialsInApi: api.
	
	self advanceMinutesAmount: 30.
	
	extendedAssertions
		should: [ api add: 1 ofBookWithIsbn: 1 toCart: cartId ]
		raiseErrorWithMessageText: (TusLibrosApi cartHasExpiredErrorMessage: cartId)! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/18/2019 13:57:37'!
test26CantCheckoutCartAfter30MinutesHavePassedSinceCreation

	| api cartId |

	api _ self apiWithPriceList: {1 -> 2} asDictionary.	
	cartId _ self createCartWithValidCredentialsInApi: api.
	api add: 1 ofBookWithIsbn: 1 toCart: cartId.

	self advanceMinutesAmount: 30.
	
	extendedAssertions
		should: [ self checkout: cartId withValidCreditCardInApi: api ]
		raiseErrorWithMessageText: (TusLibrosApi cartHasExpiredErrorMessage: cartId)! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/18/2019 13:46:09'!
test27AddingToCartResets30MinuteDeleteTimer

	| api cartId |

	api _ self apiWithPriceList: {1 -> 2} asDictionary.	
	cartId _ self createCartWithValidCredentialsInApi: api.

	self advanceMinutesAmount: 25.
	api add: 1 ofBookWithIsbn: 1 toCart: cartId.

	self advanceMinutesAmount: 25.	

	self checkout: cartId withValidCreditCardInApi: api.
	
	self assert: 2 equals: merchantProcessor debitedAmount.! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/18/2019 13:57:45'!
test28CantCheckoutCartAfter30MinutesHavePassedSinceAdding

	| api cartId |

	api _ self apiWithPriceList: {1 -> 2} asDictionary.	
	cartId _ self createCartWithValidCredentialsInApi: api.

	self advanceMinutesAmount: 25.	
	api add: 1 ofBookWithIsbn: 1 toCart: cartId.

	self advanceMinutesAmount: 30.
	
	extendedAssertions
		should: [ self checkout: cartId withValidCreditCardInApi: api ]
		raiseErrorWithMessageText: (TusLibrosApi cartHasExpiredErrorMessage: cartId)! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/18/2019 13:57:51'!
test29CantListCartAfter30MinutesHavePassed

	| api cartId |

	api _ self apiWithPriceList: {1 -> 2} asDictionary.	
	cartId _ self createCartWithValidCredentialsInApi: api.
	self advanceMinutesAmount: 30.
	
	extendedAssertions
		should: [ api listCart: cartId ]
		raiseErrorWithMessageText: (TusLibrosApi cartHasExpiredErrorMessage: cartId)! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/16/2019 22:43:49'!
test30ListingCartResets30MinuteDeleteTimer

	| api cartId contents |

	api _ self apiWithPriceList: {1 -> 2} asDictionary.	
	cartId _ self createCartWithValidCredentialsInApi: api.
	
	self advanceMinutesAmount: 25.
	api listCart: cartId.
	
	self advanceMinutesAmount: 25.
	api add: 1 ofBookWithIsbn: 1 toCart: cartId.
	
	contents _ api listCart: cartId.
	
	self assert: (contents includes: 1).
	self assert: 1 equals: (contents occurrencesOf: 1).
	! !


!TusLibrosApiTest methodsFor: 'simulating' stamp: 'EB 6/15/2019 19:21:08'!
authenticate: aClient withPassword: aPassword
	^(aClient = registeredClientId and: aPassword = registeredClientPassword)
		or: (aClient = secondRegisteredClientId and: aPassword = secondRegisteredClientPassword).! !

!TusLibrosApiTest methodsFor: 'simulating' stamp: 'EB 6/15/2019 20:50:23'!
now
	^now.! !


!TusLibrosApiTest methodsFor: 'test objects creation' stamp: 'EB 6/15/2019 17:06:57'!
apiWithPriceList: aPriceList
	^TusLibrosApi 
		authenticatingWith: self
		debitingFrom: merchantProcessor 
		withPriceList: aPriceList 
		andClock: self.
	! !

!TusLibrosApiTest methodsFor: 'test objects creation' stamp: 'EB 6/14/2019 01:08:44'!
createCartWithValidCredentials
	^self createCartWithValidCredentialsInApi: apiWithEmptyPriceList.
	! !

!TusLibrosApiTest methodsFor: 'test objects creation' stamp: 'EB 6/14/2019 01:08:44'!
createCartWithValidCredentialsInApi: aTusLibrosApi
	^aTusLibrosApi createCartWithClientId: registeredClientId andPassword: registeredClientPassword. 
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


!Cart methodsFor: 'initialization' stamp: 'EB 6/13/2019 20:51:59'!
initializeWithPriceList: aPriceList 
	priceList _ aPriceList.
	books _ Bag new.! !


!Cart methodsFor: 'adding books' stamp: 'EB 6/11/2019 17:11:29'!
add: aBookIsbn
	self add: 1 of: aBookIsbn.! !

!Cart methodsFor: 'adding books' stamp: 'EB 6/11/2019 17:18:20'!
add: anAmount of: aBookIsbn 
	(priceList includesKey: aBookIsbn) ifFalse: [
		self error: (self class bookNotInCatalogErrorMessage: 123) ].
	anAmount < 0 ifTrue: [
		self error: self class cantAddANegativeAmountOfProductsErrorMessage ].
	books add: aBookIsbn withOccurrences: anAmount.
	! !


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

!Cart class methodsFor: 'instance creation' stamp: 'EB 6/13/2019 20:51:50'!
withPriceList: aPriceList 
	^self new initializeWithPriceList: aPriceList.! !


!Cart class methodsFor: 'error messages' stamp: 'EB 5/31/2019 17:25:26'!
bookNotInCatalogErrorMessage: aBookIsbn 
	^'The book with ISBN ', aBookIsbn asString, ' isn''t present in the catalog.'.! !

!Cart class methodsFor: 'error messages' stamp: 'EB 6/11/2019 17:19:28'!
cantAddANegativeAmountOfProductsErrorMessage
	^'Can''t add a negative amount of books.'.! !


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


!classDefinition: #ClientPurchases category: #TusLibros!
Object subclass: #ClientPurchases
	instanceVariableNames: 'amountPerBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ClientPurchases methodsFor: 'accessing' stamp: 'EB 6/15/2019 18:51:30'!
amountPerBook
	^amountPerBook.! !

!ClientPurchases methodsFor: 'accessing' stamp: 'EB 6/15/2019 18:55:27'!
totalAmount
	^amountPerBook inject: 0 into: [ :accumulator :element | accumulator + 1 ].! !


!ClientPurchases methodsFor: 'adding' stamp: 'EB 6/15/2019 18:49:36'!
addFromCart: aCart 
	amountPerBook addAll: aCart contents.! !


!ClientPurchases methodsFor: 'initialization' stamp: 'EB 6/15/2019 18:50:09'!
initialize
	amountPerBook _ Bag new.! !


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

!CreditCard class methodsFor: 'instance creation' stamp: 'EB 6/10/2019 15:42:41'!
numbered: aCreditCardNumber withOwner: anOwner andExpiration: anExpirationMonthOfYear 

	self assertCreditCardNumberHasCorrectLength: aCreditCardNumber.
	self assertCreditCardNumberIsAllDigits: aCreditCardNumber.
	self assertOwnerNotEmpty: anOwner.
	^self new initializeNumbered: aCreditCardNumber withOwner: anOwner andExpiration: anExpirationMonthOfYear.! !


!CreditCard class methodsFor: 'error messages' stamp: 'EB 6/9/2019 18:04:00'!
invalidNumberLengthErrorMessage: aCreditCardNumber
	^'The credit card number must have 16 digits. The one provided was: ', aCreditCardNumber.! !

!CreditCard class methodsFor: 'error messages' stamp: 'EB 6/10/2019 13:08:58'!
numberShouldConsistOfDigitsErrorMessage: aCreditCardNumber
	^'The number ', aCreditCardNumber, ' has characters that aren''t digits.'. ! !

!CreditCard class methodsFor: 'error messages' stamp: 'EB 6/10/2019 15:30:14'!
ownerEmptyErrorMessage
	^'The owner can''t be empty.'.! !


!CreditCard class methodsFor: 'assertions' stamp: 'EB 6/10/2019 12:32:53'!
assertCreditCardNumberHasCorrectLength: aCreditCardNumber
	aCreditCardNumber size = 16 ifFalse: [
		self error: (self invalidNumberLengthErrorMessage: aCreditCardNumber) ].! !

!CreditCard class methodsFor: 'assertions' stamp: 'EB 6/10/2019 12:33:46'!
assertCreditCardNumberIsAllDigits: aCreditCardNumber
	aCreditCardNumber allSatisfy: [ :character | character isDigit ] :: ifFalse: [
		self error: (self numberShouldConsistOfDigitsErrorMessage: aCreditCardNumber) ].! !

!CreditCard class methodsFor: 'assertions' stamp: 'EB 6/10/2019 15:42:53'!
assertOwnerNotEmpty: anOwner

	anOwner isEmpty ifTrue: [ self error: self ownerEmptyErrorMessage ].! !


!classDefinition: #CreditCardsForTestingFactory category: #TusLibros!
Object subclass: #CreditCardsForTestingFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardsForTestingFactory methodsFor: 'instance creation' stamp: 'EB 6/15/2019 16:58:01'!
creditCardWithExpiration: anExpiration
	^CreditCard numbered: '1234567890123456' withOwner: 'PEPE SANCHEZ' andExpiration: anExpiration. ! !

!CreditCardsForTestingFactory methodsFor: 'instance creation' stamp: 'EB 6/15/2019 16:58:13'!
expiredCreditCard
	^self creditCardWithExpiration: GregorianMonthOfYear current previous.  ! !

!CreditCardsForTestingFactory methodsFor: 'instance creation' stamp: 'EB 6/15/2019 16:58:24'!
nonExpiredCreditCard
	^self creditCardWithExpiration: GregorianMonthOfYear current next. ! !


!classDefinition: #ExtendedAssertions category: #TusLibros!
Object subclass: #ExtendedAssertions
	instanceVariableNames: 'testCase'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ExtendedAssertions methodsFor: 'initialization' stamp: 'EB 6/11/2019 19:45:09'!
initializeFor: aTestCase
	testCase _ aTestCase.! !


!ExtendedAssertions methodsFor: 'assertions' stamp: 'EB 6/11/2019 19:55:46'!
should: aTestBlock raiseErrorWithMessageText: aMessageText
	self
		should: aTestBlock 
		raiseErrorWithMessageText: aMessageText
		withExceptionDo: [ :exception | ].! !

!ExtendedAssertions methodsFor: 'assertions' stamp: 'EB 6/11/2019 19:51:43'!
should: aTestBlock raiseErrorWithMessageText: aMessageText withExceptionDo: aDoBlock
	testCase 
		should: aTestBlock
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			testCase assert: aMessageText equals: exception messageText.
			aDoBlock value: exception. ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExtendedAssertions class' category: #TusLibros!
ExtendedAssertions class
	instanceVariableNames: ''!

!ExtendedAssertions class methodsFor: 'instance creation' stamp: 'EB 6/11/2019 19:44:48'!
for: aTestCase
	^self new initializeFor: aTestCase.! !


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


!classDefinition: #TusLibrosApi category: #TusLibros!
Object subclass: #TusLibrosApi
	instanceVariableNames: 'userAuthenticator lastCartId carts priceList clock merchantProcessor clientIdPerCart purchasesPerClient lastTransactionId lastUsePerCart checkedOutCarts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosApi methodsFor: 'initialization' stamp: 'EB 6/18/2019 14:07:44'!
initializeAuthenticatingWith: anUserAuthenticator debitingFrom: aMerchantProcessor withPriceList: aPriceList andClock: aClock  
	userAuthenticator _ anUserAuthenticator.
	merchantProcessor _ aMerchantProcessor.
	priceList _ aPriceList.
	clock _ aClock.
	
	lastCartId _ 0.
	lastTransactionId _ 0.
	carts _ Dictionary new.
	purchasesPerClient _ Dictionary new.
	clientIdPerCart _ Dictionary new.
	lastUsePerCart _ Dictionary new.
	checkedOutCarts _ Set new.! !


!TusLibrosApi methodsFor: 'cart management' stamp: 'EB 6/18/2019 13:53:20'!
add: anAmount ofBookWithIsbn: aBookIsbn toCart: aCartId 
	
	| cart |
	
	self assertAmountIsGreaterThanZero: anAmount.
	self assert30MinutesHaventPassedSinceLastUseOfCartWithId: aCartId.
	self logLastUsedTimeForCart: aCartId.
	
	cart _ self cartWithId: aCartId.
	cart add: anAmount of: aBookIsbn.! !

!TusLibrosApi methodsFor: 'cart management' stamp: 'EB 6/16/2019 22:27:48'!
addCartContentsToClientPurchases: aCartId

	| clientId clientPurchases cart |

	clientId _ self clientIdForCart: aCartId.
	clientPurchases _ self purchasesForClient: clientId.
	cart _ self cartWithId: aCartId.
	clientPurchases addFromCart: cart.! !

!TusLibrosApi methodsFor: 'cart management' stamp: 'EB 6/18/2019 14:11:01'!
checkout: aCartId withCreditCard: aCreditCard

	self assert30MinutesHaventPassedSinceLastUseOfCartWithId: aCartId.
	self assertCartHasntBeenCheckedOut: aCartId.
	
	self debitCart: aCartId withCreditCard: aCreditCard.
	self addCartContentsToClientPurchases: aCartId.
	checkedOutCarts add: aCartId.
	
	^self nextTransactionId.! !

!TusLibrosApi methodsFor: 'cart management' stamp: 'EB 6/16/2019 22:48:27'!
createCartWithClientId: aClientId andPassword: aPassword 

	| cart cartId |

	self assertCanAuthenticateClient: aClientId withPassword: aPassword.

	cartId _ self nextCartId.
	cart _ Cart withPriceList: priceList.
	carts at: cartId put: cart.
	clientIdPerCart at: cartId put: aClientId.
	self logLastUsedTimeForCart: cartId.
	^cartId.! !

!TusLibrosApi methodsFor: 'cart management' stamp: 'EB 6/16/2019 22:34:23'!
debitCart: aCartId withCreditCard: aCreditCard
	
	| cart cashier |
	
	cart _ self cartWithId: aCartId.
	cashier _ Cashier forCart: cart withMerchantProcessor: merchantProcessor.
	cashier checkoutWithCreditCard: aCreditCard onDate: clock now.
! !

!TusLibrosApi methodsFor: 'cart management' stamp: 'EB 6/18/2019 14:00:32'!
listCart: aCartId 
	
	self assert30MinutesHaventPassedSinceLastUseOfCartWithId: aCartId.
	self logLastUsedTimeForCart: aCartId.
	
	^(self cartWithId: aCartId) contents.! !

!TusLibrosApi methodsFor: 'cart management' stamp: 'EB 6/18/2019 14:00:45'!
logLastUsedTimeForCart: aCartId

	lastUsePerCart at: aCartId put: clock now.! !

!TusLibrosApi methodsFor: 'cart management' stamp: 'EB 6/18/2019 14:00:51'!
nextCartId

	^lastCartId _ lastCartId + 1.! !

!TusLibrosApi methodsFor: 'cart management' stamp: 'EB 6/18/2019 14:00:54'!
nextTransactionId

	^lastTransactionId _ lastTransactionId + 1.! !


!TusLibrosApi methodsFor: 'assertions' stamp: 'EB 6/18/2019 13:53:20'!
assert30MinutesHaventPassedSinceLastUseOfCartWithId: aCartId
	lastUsePerCart at: aCartId ifPresent: [ :lastUsed |
		(self thirtyMinutesHavePassedSince: lastUsed) ifTrue: [ 
			self error: (self class cartHasExpiredErrorMessage: aCartId).
		]
	].! !

!TusLibrosApi methodsFor: 'assertions' stamp: 'EB 6/15/2019 17:14:42'!
assertAmountIsGreaterThanZero: anAmount
	anAmount < 1 ifTrue: [
		self error: (self class amountToAddCantBeLessThan1ErrorMessage: anAmount) ].! !

!TusLibrosApi methodsFor: 'assertions' stamp: 'EB 6/13/2019 23:46:30'!
assertCanAuthenticateClient: aClientId withPassword: aPassword
	(userAuthenticator authenticate: aClientId withPassword: aPassword) ifFalse: [
		self error: self class invalidUserCredentialsErrorMessage ].
! !

!TusLibrosApi methodsFor: 'assertions' stamp: 'EB 6/18/2019 14:10:38'!
assertCartHasntBeenCheckedOut: aCartId
	(checkedOutCarts includes: aCartId) ifTrue: [
		self error: (self class cartAlreadyCheckedOutErrorMessage: aCartId) ].
	! !

!TusLibrosApi methodsFor: 'assertions' stamp: 'EB 6/16/2019 22:21:19'!
thirtyMinutesHavePassedSince: aTimePoint
	
	| thirtyMinutes |
	
	thirtyMinutes _ 30 * TimeUnits minute.
	^(aTimePoint distanceTo: clock now) >= thirtyMinutes.
! !


!TusLibrosApi methodsFor: 'error raising' stamp: 'EB 6/13/2019 20:27:51'!
raiseCartDoesNotExistError: aCartId
	self error: (self class cartDoesNotExistErrorMessage: aCartId).! !


!TusLibrosApi methodsFor: 'accessing' stamp: 'EB 6/13/2019 23:49:08'!
cartWithId: aCartId 

	^ carts at: aCartId ifAbsent: [ self raiseCartDoesNotExistError: aCartId ].! !

!TusLibrosApi methodsFor: 'accessing' stamp: 'EB 6/15/2019 19:48:06'!
clientIdForCart: aCart 

	^clientIdPerCart at: aCart.! !


!TusLibrosApi methodsFor: 'listing purchases' stamp: 'EB 6/15/2019 19:58:53'!
listPurchasesOfClient: aClientId withPassword: aPassword

	self assertCanAuthenticateClient: aClientId withPassword: aPassword.
	
	^self purchasesForClient: aClientId.! !

!TusLibrosApi methodsFor: 'listing purchases' stamp: 'EB 6/15/2019 19:54:29'!
purchasesForClient: aClientId
	^purchasesPerClient at: aClientId ifAbsent: [ 
		purchasesPerClient at: aClientId put: ClientPurchases new ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosApi class' category: #TusLibros!
TusLibrosApi class
	instanceVariableNames: ''!

!TusLibrosApi class methodsFor: 'instance creation' stamp: 'EB 6/15/2019 17:10:13'!
authenticatingWith: anUserAuthenticator debitingFrom: aMerchantProcessor withPriceList: aPriceList andClock: aClock  
	^self new initializeAuthenticatingWith: anUserAuthenticator debitingFrom: aMerchantProcessor withPriceList: aPriceList andClock: aClock.! !


!TusLibrosApi class methodsFor: 'error messages' stamp: 'EB 6/14/2019 01:23:24'!
amountToAddCantBeLessThan1ErrorMessage: anAmount
	^'Can''t add ', anAmount asString, ' books to cart; the amount must be greater than zero.'.! !

!TusLibrosApi class methodsFor: 'error messages' stamp: 'EB 6/18/2019 14:03:19'!
cartAlreadyCheckedOutErrorMessage: aCartId 
	^'The cart with ID ', aCartId asString, ' has already been checked out; it can''t be checked out again.'.! !

!TusLibrosApi class methodsFor: 'error messages' stamp: 'EB 6/11/2019 20:08:55'!
cartDoesNotExistErrorMessage: aCartId 
	^'The cart with ID ', aCartId asString, ' does not exist.'.! !

!TusLibrosApi class methodsFor: 'error messages' stamp: 'EB 6/18/2019 13:50:35'!
cartHasExpiredErrorMessage: aCartId 
	^'30 minutes have passed from the last use of the cart with ID ', aCartId asString, '; it has expired.'.! !

!TusLibrosApi class methodsFor: 'error messages' stamp: 'EB 6/11/2019 17:38:05'!
invalidUserCredentialsErrorMessage
	^'The user credentials supplied are not valid.'.! !
