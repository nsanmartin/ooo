!classDefinition: #CartTest category: #'TusLibros-Tests'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

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


!classDefinition: #CashierTest category: #'TusLibros-Tests'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

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


!classDefinition: #CreditCardTest category: #'TusLibros-Tests'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

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


!classDefinition: #GregorianMonthOfYearHTTPDecoderTest category: #'TusLibros-Tests'!
TestCase subclass: #GregorianMonthOfYearHTTPDecoderTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!GregorianMonthOfYearHTTPDecoderTest methodsFor: 'tests' stamp: 'EB 6/29/2019 21:10:41'!
test01ShouldDecodeMonthOfYearCorrectly
	
	| decodedMonthOfYear encodedMonthOfYear expectedMonthOfYear |
	
	encodedMonthOfYear _ '012019'.
	expectedMonthOfYear _ GregorianMonthOfYear yearNumber: 2019 monthNumber: 1.
	
	decodedMonthOfYear _ GregorianMonthOfYearHTTPDecoder new decode: encodedMonthOfYear.
	
	self assert: expectedMonthOfYear equals: decodedMonthOfYear.! !

!GregorianMonthOfYearHTTPDecoderTest methodsFor: 'tests' stamp: 'EB 6/30/2019 18:16:53'!
test02CantDecodeIfIncorrectNumberOfDigits
	
	| encodedMonthOfYear expectedMessageText extendedAssertions |
	
	encodedMonthOfYear _ '12019'.
	
	extendedAssertions _ ExtendedAssertions for: self.
	expectedMessageText _ 
		GregorianMonthOfYearHTTPDecoder badlyEncodedMonthOfYearErrorMessage: encodedMonthOfYear.
	
	extendedAssertions
		should: [ GregorianMonthOfYearHTTPDecoder new decode: encodedMonthOfYear ]
		raiseErrorWithMessageText: expectedMessageText.
			! !

!GregorianMonthOfYearHTTPDecoderTest methodsFor: 'tests' stamp: 'EB 6/30/2019 18:18:40'!
test03CantDecodeIfSomeCharactersArentDigits
	
	| encodedMonthOfYear expectedMessageText extendedAssertions |
	
	encodedMonthOfYear _ '12019a'.
	
	extendedAssertions _ ExtendedAssertions for: self.
	expectedMessageText _ 
		GregorianMonthOfYearHTTPDecoder badlyEncodedMonthOfYearErrorMessage: encodedMonthOfYear.
	
	extendedAssertions
		should: [ GregorianMonthOfYearHTTPDecoder new decode: encodedMonthOfYear ]
		raiseErrorWithMessageText: expectedMessageText.
			! !

!GregorianMonthOfYearHTTPDecoderTest methodsFor: 'tests' stamp: 'EB 6/30/2019 18:28:11'!
test04CantDecodeIfMonthIsOutOfBounds
	self
		should: [ GregorianMonthOfYearHTTPDecoder new decode: '132019' ]
		raise: Error.
			! !


!classDefinition: #GregorianMonthOfYearHTTPEncoderTest category: #'TusLibros-Tests'!
TestCase subclass: #GregorianMonthOfYearHTTPEncoderTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!GregorianMonthOfYearHTTPEncoderTest methodsFor: 'tests' stamp: 'EB 6/29/2019 21:11:11'!
test01ShouldConvertToStringWithMonthNumberFirstAndThenFullYear

	| converted monthOfYear |

	monthOfYear _ GregorianMonthOfYear yearNumber: 2019 month: January.
	converted _ GregorianMonthOfYearHTTPEncoder new encode: monthOfYear.
	self assert: '012019' equals: converted.! !

!GregorianMonthOfYearHTTPEncoderTest methodsFor: 'tests' stamp: 'EB 6/29/2019 21:11:11'!
test02YearWithLessThanFourDigitsShouldBePaddedWithZeros

	| converted monthOfYear |

	monthOfYear _ GregorianMonthOfYear yearNumber: 25 month: December.
	converted _ GregorianMonthOfYearHTTPEncoder new encode: monthOfYear.
	self assert: '120025' equals: converted.! !


!classDefinition: #TusLibrosApiTest category: #'TusLibros-Tests'!
TestCase subclass: #TusLibrosApiTest
	instanceVariableNames: 'extendedAssertions registeredClientId registeredClientPassword unregisteredClientId apiWithEmptyPriceList merchantProcessor secondRegisteredClientId secondRegisteredClientPassword now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

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

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/22/2019 00:33:16'!
test31CantListCartAfterCheckout

	| api cartId |
	
	api _ self apiWithPriceList: {1 -> 2} asDictionary.	
	cartId _ self createCartWithValidCredentialsInApi: api.
	api add: 1 ofBookWithIsbn: 1 toCart: cartId. 	
	
	self checkout: cartId withValidCreditCardInApi: api.
	
	extendedAssertions
		should: [ api listCart: cartId ]
		raiseErrorWithMessageText: (TusLibrosApi cartAlreadyCheckedOutErrorMessage: cartId)
		withExceptionDo: [ :exception |
			self assert: 2 equals: merchantProcessor debitedAmount ].! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 6/22/2019 00:33:42'!
test32CantAddToCartAfterCheckout

	| api cartId |
	
	api _ self apiWithPriceList: {1 -> 2} asDictionary.	
	cartId _ self createCartWithValidCredentialsInApi: api.
	api add: 1 ofBookWithIsbn: 1 toCart: cartId. 	
	
	self checkout: cartId withValidCreditCardInApi: api.
	
	extendedAssertions
		should: [ api add: 1 ofBookWithIsbn: 1 toCart: cartId ]
		raiseErrorWithMessageText: (TusLibrosApi cartAlreadyCheckedOutErrorMessage: cartId)
		withExceptionDo: [ :exception |
			self assert: 2 equals: merchantProcessor debitedAmount ].! !

!TusLibrosApiTest methodsFor: 'tests' stamp: 'EB 7/1/2019 13:16:12'!
test33ListPricesShouldReturnPriceList

	| api expectedPriceList priceList |
	
	expectedPriceList _ {1 -> 2. 2 -> 3} asDictionary.
	api _ self apiWithPriceList: expectedPriceList.
	priceList _ api listPrices.
	
	self assert: expectedPriceList equals: priceList.! !


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


!classDefinition: #TusLibrosWebClientTest category: #'TusLibros-Tests'!
TestCase subclass: #TusLibrosWebClientTest
	instanceVariableNames: 'webServerWrapper extendedAssertions htmlSubmitBlock domainUrl tusLibrosWebClient'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!TusLibrosWebClientTest methodsFor: 'tests - createCart' stamp: 'EB 7/2/2019 14:19:38'!
test01CreateCartShouldPropagateResponsesWithStatus1
	
	| responseErrorMessage responseContent |
	
	responseErrorMessage _ 'There was an error.'.
	responseContent _ '1|', responseErrorMessage.
	self onHtmlSubmitToService: 'createCart' doWithParameters: [ :parameters |
		WebResponseTestDouble withCode: 200 andContent: responseContent ].
	
	extendedAssertions
		should: [ tusLibrosWebClient getCreateCartWithClientId: 'Juancito' andPassword: 'password' ]
		raiseErrorWithMessageText: responseErrorMessage.
		! !

!TusLibrosWebClientTest methodsFor: 'tests - createCart' stamp: 'EB 7/2/2019 01:01:11'!
test02CreateCartShouldCallApiWithRightParameters

	| clientId password expectedCartId responseContent cartId |

	expectedCartId _ 123.
	responseContent _ '0|', expectedCartId asString.
	clientId _ 'Juancito'.
	password _ 'password'.
	self 
		onHtmlSubmitToService: 'createCart' 
		doWithParameters: [ :parameters |
			parameters = {'clientId' -> clientId. 'password' -> password} ifTrue: [
				WebResponseTestDouble withCode: 200 andContent: responseContent ]
		].

	cartId _ tusLibrosWebClient getCreateCartWithClientId: clientId andPassword: password.
	
	self assert: expectedCartId equals: cartId.! !

!TusLibrosWebClientTest methodsFor: 'tests - createCart' stamp: 'EB 7/2/2019 14:09:14'!
test03CreateCartWithCodeDIfferentFrom200ShouldPropagateTheError

	| clientId password response responseContent |

	responseContent _ 'error message'.
	clientId _ 'Juancito'.
	password _ 'password'.
	response _ WebResponseTestDouble withCode: 500 andContent: responseContent.
	self 
		onHtmlSubmitToService: 'createCart' 
		doWithParameters: [ :parameters |
			parameters = {'clientId' -> clientId. 'password' -> password} ifTrue: [ response ]
		].

	extendedAssertions 
		should: [ tusLibrosWebClient getCreateCartWithClientId: clientId andPassword: password ]
		raiseErrorWithMessageText: 
			(TusLibrosWebClient badResponseErrorMessageForResponse: response).! !

!TusLibrosWebClientTest methodsFor: 'tests - createCart' stamp: 'EB 7/2/2019 14:18:47'!
test04CreateCartOnServerUnavailableShouldPropagateTheError

	| clientId password |

	clientId _ 'Juancito'.
	password _ 'password'.
	self 
		onHtmlSubmitToService: 'createCart' 
		doWithParameters: [ :parameters |
			ConnectionTimedOut new signal.
		].

	self 
		should: [ tusLibrosWebClient getCreateCartWithClientId: clientId andPassword: password ]
		raise: ConnectionTimedOut.! !

!TusLibrosWebClientTest methodsFor: 'tests - createCart' stamp: 'EB 7/2/2019 21:21:47'!
test13CreateCartOnNonNumberServerResponseShouldRaiseError

	| clientId password response |

	clientId _ 'Juancito'.
	password _ 'password'.
	response _ WebResponseTestDouble withCode: 200 andContent: '0|eric'.
	self 
		onHtmlSubmitToService: 'createCart' 
		doWithParameters: [ :parameters |
			parameters = {'clientId' -> clientId. 'password' -> password} ifTrue: [ response ]
		].

	extendedAssertions 
		should: [ tusLibrosWebClient getCreateCartWithClientId: clientId andPassword: password ]
		raiseErrorWithMessageText:
			(TusLibrosWebClient badResponseErrorMessageForResponse: response).
	! !


!TusLibrosWebClientTest methodsFor: 'setUp' stamp: 'EB 7/2/2019 00:51:51'!
setUp
	domainUrl _ 'http://url.com'.
	tusLibrosWebClient _ TusLibrosWebClient usingWebClient: self forUrl: domainUrl.
	extendedAssertions _ ExtendedAssertions for: self.
	htmlSubmitBlock _ [].

! !


!TusLibrosWebClientTest methodsFor: 'simulating' stamp: 'EB 7/1/2019 23:53:07'!
htmlSubmit: anUrlString fields: someFields
	^htmlSubmitBlock value: anUrlString value: someFields.! !

!TusLibrosWebClientTest methodsFor: 'simulating' stamp: 'EB 7/2/2019 00:59:55'!
onHtmlSubmitToService: aService doWithParameters: aBlock
	
	| expectedUrl |
	
	expectedUrl _ domainUrl, '/', aService.
	htmlSubmitBlock _ [ :url :params |
		url = expectedUrl ifTrue: [ aBlock value: params ] 
	].! !


!TusLibrosWebClientTest methodsFor: 'tests - addToCart' stamp: 'EB 7/2/2019 14:38:44'!
test05AddToCartShouldSendAddToCartRequestOnlyOnce

	| alreadyCalled bookIsbn cartId quantity |

	cartId _ 1.
	bookIsbn _ 1.
	quantity _ 23.
	alreadyCalled _ false.
	self 
		onHtmlSubmitToService: 'addToCart' 
		doWithParameters: [ :parameters |
			self assert: 
					{'cartId' -> cartId asString. 
					'bookIsbn' -> bookIsbn asString. 
					'bookQuantity' -> quantity asString}
				equals: parameters.
			self deny: alreadyCalled description: 'Should add only once.'. 
			alreadyCalled _ true.
			WebResponseTestDouble withCode: 200 andContent: '0|OK'.
		].

	tusLibrosWebClient getAddToCartWithId: cartId adding: quantity of: bookIsbn.
	
	self assert: alreadyCalled description: 'getAddToCart should send the request.'.! !

!TusLibrosWebClientTest methodsFor: 'tests - addToCart' stamp: 'EB 7/2/2019 14:34:33'!
test06AddToCartShouldPropagateServerErrorsWhenResponseStatusIs1

	| bookIsbn cartId quantity responseMessage |

	cartId _ 1.
	bookIsbn _ 1.
	quantity _ 23.
	responseMessage _ 'error message.'.
	self 
		onHtmlSubmitToService: 'addToCart' 
		doWithParameters: [ :parameters |
			WebResponseTestDouble withCode: 200 andContent: '1|', responseMessage. 
		].

	extendedAssertions 
		should: [ tusLibrosWebClient getAddToCartWithId: cartId adding: quantity of: bookIsbn ]
		raiseErrorWithMessageText: responseMessage.! !

!TusLibrosWebClientTest methodsFor: 'tests - addToCart' stamp: 'EB 7/2/2019 14:44:59'!
test07AddToCartWithCodeDIfferentFrom200ShouldPropagateTheError

	| bookIsbn cartId quantity response |

	cartId _ 1.
	bookIsbn _ 1.
	quantity _ 23.
	response _ WebResponseTestDouble withCode: 500 andContent: 'error message.'.
	self 
		onHtmlSubmitToService: 'addToCart' 
		doWithParameters: [ :parameters | response ].

	extendedAssertions 
		should: [ tusLibrosWebClient getAddToCartWithId: cartId adding: quantity of: bookIsbn ]
		raiseErrorWithMessageText: 
			(TusLibrosWebClient badResponseErrorMessageForResponse: response).! !

!TusLibrosWebClientTest methodsFor: 'tests - addToCart' stamp: 'EB 7/2/2019 21:19:20'!
test08AddToCartOnServerUnavailableShouldPropagateTheError

	self 
		onHtmlSubmitToService: 'addToCart' 
		doWithParameters: [ :parameters | ConnectionTimedOut new signal ].

	self 
		should: [ tusLibrosWebClient getAddToCartWithId: 2 adding: 23 of: 3 ]
		raise: ConnectionTimedOut.! !


!TusLibrosWebClientTest methodsFor: 'tests - listCart' stamp: 'EB 7/2/2019 15:05:14'!
test09ListCartShouldParseEmptyListCartResponseCorrectly

	| cartContents cartId |

	cartId _ 1.
	self 
		onHtmlSubmitToService: 'listCart' 
		doWithParameters: [ :parameters |
			parameters = {'cartId' -> cartId asString} ifTrue: [
				WebResponseTestDouble withCode: 200 andContent: '0|' ].
		].

	cartContents _ tusLibrosWebClient getListCartWithId: cartId.
	self assert: Bag new equals: cartContents.! !

!TusLibrosWebClientTest methodsFor: 'tests - listCart' stamp: 'EB 7/2/2019 15:22:25'!
test10ListCartShouldParseFullListCartResponseCorrectly

	| cartContents cartId expectedContents |

	cartId _ 1.
	self 
		onHtmlSubmitToService: 'listCart' 
		doWithParameters: [ :parameters |
			parameters = {'cartId' -> cartId asString} ifTrue: [
				WebResponseTestDouble withCode: 200 andContent: '0|1|2|32|4' ].
		].

	cartContents _ tusLibrosWebClient getListCartWithId: cartId.
	expectedContents _ Bag new.
	expectedContents add: 1 withOccurrences: 2.
	expectedContents add: 32 withOccurrences: 4.
	self assert: expectedContents equals: cartContents.! !

!TusLibrosWebClientTest methodsFor: 'tests - listCart' stamp: 'EB 7/2/2019 21:13:06'!
test11ListCartWithServerResponseWithOddAmountOfElementsShouldRaiseError

	| cartId response |

	cartId _ 1.
	response _ WebResponseTestDouble withCode: 200 andContent: '0|1'.
	self 
		onHtmlSubmitToService: 'listCart' 
		doWithParameters: [ :parameters |
			parameters = {'cartId' -> cartId asString} ifTrue: [ response ].
		].

	extendedAssertions
		should: [ tusLibrosWebClient getListCartWithId: cartId ]
		raiseErrorWithMessageText:
			(TusLibrosWebClient badResponseErrorMessageForResponse: response).! !

!TusLibrosWebClientTest methodsFor: 'tests - listCart' stamp: 'EB 7/2/2019 21:13:43'!
test12ListCartWithServerResponseWithNonNumberElementsShouldRaiseError

	| cartId response |

	cartId _ 1.
	response _ WebResponseTestDouble withCode: 200 andContent: '0|asd|asd'.
	self 
		onHtmlSubmitToService: 'listCart' 
		doWithParameters: [ :parameters |
			parameters = {'cartId' -> cartId asString} ifTrue: [ response ].
		].

	extendedAssertions
		should: [ tusLibrosWebClient getListCartWithId: cartId ]
		raiseErrorWithMessageText:
			(TusLibrosWebClient badResponseErrorMessageForResponse: response).! !


!TusLibrosWebClientTest methodsFor: 'tests - checkoutCart' stamp: 'EB 7/2/2019 23:15:37'!
test14CheckoutCartShouldMakeTheRequestWithCorrectParameters

	| cartId cced ccn cco responseMessage transactionId response expirationMonthOfYear |

	cartId _ 123.
	ccn _ '1234567890123456'.
	expirationMonthOfYear _ GregorianMonthOfYear 
		yearNumber: 2019 month: January.
	cced _ GregorianMonthOfYearHTTPEncoder new encode: expirationMonthOfYear.
	cco _ 'Pepito'.
	responseMessage _ '54'.
	response _ WebResponseTestDouble withCode: 200 andContent: '0|', responseMessage.
	
	self 
		assertHtmlSubmitIsSentOnceToService: 'checkoutCart'
		withParameters: 
			{'cartId' -> cartId asString.
			'ccn' -> ccn.
			'cced' -> cced.
			'cco' -> cco}
		whenDoing: [
			transactionId _ tusLibrosWebClient 
				getCheckoutCartWithId: cartId
				withCreditCardNumbered: ccn
				withExpirationDate: expirationMonthOfYear
				andOwner: cco ]
		response: response.
		
	self assert: responseMessage equals: transactionId.! !


!TusLibrosWebClientTest methodsFor: 'assertions' stamp: 'EB 7/2/2019 23:01:54'!
assertHtmlSubmitIsSentOnceToService: aService
withParameters: someParameters
whenDoing: aBlock
response: aResponse 

	| alreadyCalled expectedUrl |
	
	expectedUrl _ domainUrl, '/', aService.
	alreadyCalled _ false.
	htmlSubmitBlock _ [ :url :fields |
		self deny: alreadyCalled.
		self assert: expectedUrl equals: url.
		self assert: someParameters equals: fields.
		alreadyCalled _ true.
		aResponse ].
	
	aBlock value.
	self assert: alreadyCalled.! !


!TusLibrosWebClientTest methodsFor: 'tests - listPurchases' stamp: 'EB 7/2/2019 23:33:49'!
test15ListPurchasesWithEmptyListShouldReturnAnEmptyBag
	
	| clientId password purchases |
	clientId _ 'Pepito'.
	password _ 'password'.
	self 
		onHtmlSubmitToService: 'listPurchases'
		doWithParameters: [ :parameters |
			parameters = {'clientId' -> clientId. 'password' -> password} ifTrue: [
				WebResponseTestDouble withCode: 200 andContent: '0|' ]
		].
	
	purchases _ tusLibrosWebClient 
		getListPurchasesOfClientWithId: clientId 
		withPassword: password.
	self assert: Bag new equals: purchases.! !

!TusLibrosWebClientTest methodsFor: 'tests - listPurchases' stamp: 'EB 7/2/2019 23:33:49'!
test16ListPurchasesWithNonEmptyListShouldReturnAFullBag
	
	| clientId password purchases expectedContents |
	clientId _ 'Pepito'.
	password _ 'password'.
	self 
		onHtmlSubmitToService: 'listPurchases'
		doWithParameters: [ :parameters |
			parameters = {'clientId' -> clientId. 'password' -> password} ifTrue: [
				WebResponseTestDouble withCode: 200 andContent: '0|1|2|34|2' ]
		].
	
	purchases _ tusLibrosWebClient 
		getListPurchasesOfClientWithId: clientId 
		withPassword: password.
		
	expectedContents _ Bag new.
	expectedContents add: 1 withOccurrences: 2.
	expectedContents add: 34 withOccurrences: 2.
	self assert: expectedContents equals: purchases.! !


!classDefinition: #TusLibrosWebServerTest category: #'TusLibros-Tests'!
TestCase subclass: #TusLibrosWebServerTest
	instanceVariableNames: 'port server merchantProcessor clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!TusLibrosWebServerTest methodsFor: 'tests' stamp: 'EB 6/28/2019 16:14:05'!
test03CanDestroyServer
	
	self createServerWithApiWithNoCredentials.
	server destroy.
	
	self should: [ self getCreateCartWithParams: {} ]
		raise: ConnectionTimedOut.! !


!TusLibrosWebServerTest methodsFor: 'excercising' stamp: 'EB 6/28/2019 16:19:33'!
getAddToCartWithCartId: aCartId andBookIsbn: aBookIsbn andQuantity: aBookQuantity
	^self 
		getService: 'addToCart' 
		withParams: {'cartId' -> aCartId. 'bookIsbn' -> aBookIsbn. 'bookQuantity' -> aBookQuantity}. ! !

!TusLibrosWebServerTest methodsFor: 'excercising' stamp: 'EB 6/30/2019 18:59:29'!
getCheckoutCartWithCartId: aCartId
andCreditCard: aCreditCard
	
	| encodedExpiration encodedOwner expirationMonthOfYear |
	
	expirationMonthOfYear _ aCreditCard expiration.
	encodedExpiration _ GregorianMonthOfYearHTTPEncoder new encode: expirationMonthOfYear.
	encodedOwner _ aCreditCard owner copyReplaceAll: ' ' with: '%20'.
	^self 
		getService: 'checkOutCart'
		withParams: {
			'cartId' -> aCartId. 
			'ccn' -> aCreditCard number.
			'cced' -> encodedExpiration.
			'cco' -> encodedOwner }.! !

!TusLibrosWebServerTest methodsFor: 'excercising' stamp: 'EB 6/30/2019 22:05:34'!
getCheckoutCartWithCartId: aCartId
andCreditCardNumber: aCreditCardNumber
andCreditCardExpiration: aCreditCardExpiration
andCreditCardOwner: aCreditCardOwner
	^self
		getService: 'checkOutCart'
		withParams: {
			'cartId' -> aCartId. 
			'ccn' -> aCreditCardNumber.
			'cced' -> aCreditCardExpiration.
			'cco' -> aCreditCardOwner }.! !

!TusLibrosWebServerTest methodsFor: 'excercising' stamp: 'EB 6/27/2019 16:00:56'!
getCreateCartWithClientId: aClientId andPassword: aPassword
	^self getCreateCartWithParams: {'clientId' -> aClientId. 'password' -> aPassword}.! !

!TusLibrosWebServerTest methodsFor: 'excercising' stamp: 'EB 6/25/2019 17:25:56'!
getCreateCartWithParams: someParams
	^self getService: 'createCart' withParams: someParams.! !

!TusLibrosWebServerTest methodsFor: 'excercising' stamp: 'EB 6/28/2019 15:53:51'!
getListCartWithCartId: aCartId
	^self getService: 'listCart' withParams: {'cartId' -> aCartId}. ! !

!TusLibrosWebServerTest methodsFor: 'excercising' stamp: 'EB 7/1/2019 13:40:26'!
getListPrices
	^self getService: 'listPrices' withParams: {}.! !

!TusLibrosWebServerTest methodsFor: 'excercising' stamp: 'EB 7/1/2019 01:49:10'!
getListPurchasesWithClientId: aClientId andPassword: aPassword
	^self 
		getService: 'listPurchases' 
		withParams: {'clientId' -> aClientId. 'password' -> aPassword}. ! !

!TusLibrosWebServerTest methodsFor: 'excercising' stamp: 'EB 7/1/2019 19:46:09'!
getService: aService withParams: someParams
	^WebClient htmlSubmit: self serverUrl, '/', aService fields: someParams.! !

!TusLibrosWebServerTest methodsFor: 'excercising' stamp: 'EB 6/25/2019 14:54:46'!
port
	"Use a random port to minimise chances of concurrently running test suites clashing."
	^ port
		ifNil: [port := (10000 to: 50000) atRandom]! !

!TusLibrosWebServerTest methodsFor: 'excercising' stamp: 'EB 7/1/2019 19:46:09'!
serverUrl
	^'http://localhost:', self port asString! !


!TusLibrosWebServerTest methodsFor: 'test objects creation' stamp: 'EB 7/1/2019 01:46:52'!
createServerAndCreateCartWithPriceList: aPriceList
	^self 
		createServerAndCreateCartWithPriceList: aPriceList
		withClientId: 'Juancito' 
		andPassword: 'hunter2'.
! !

!TusLibrosWebServerTest methodsFor: 'test objects creation' stamp: 'EB 7/1/2019 01:46:16'!
createServerAndCreateCartWithPriceList: aPriceList
withClientId: aClientId andPassword: aPassword
	
	| response |
	
	self 
		createServerWithApiWithRegisteredCredentials: {aClientId -> aPassword} asDictionary 
		andPriceList: aPriceList.
	
	response _ self getCreateCartWithClientId: aClientId andPassword: aPassword.
	^self responseDescription: response.! !

!TusLibrosWebServerTest methodsFor: 'test objects creation' stamp: 'EB 6/27/2019 15:51:20'!
createServerFor: aTusLibrosApi
	server _ TusLibrosWebServer for: aTusLibrosApi listeningOn: self port.! !

!TusLibrosWebServerTest methodsFor: 'test objects creation' stamp: 'EB 6/28/2019 16:12:26'!
createServerWithApiWithNoCredentials
	^self createServerWithApiWithRegisteredCredentials: Dictionary new.! !

!TusLibrosWebServerTest methodsFor: 'test objects creation' stamp: 'EB 6/28/2019 16:10:15'!
createServerWithApiWithRegisteredCredentials: someRegisteredCredentials
	^self 
		createServerWithApiWithRegisteredCredentials: someRegisteredCredentials 
		andPriceList: Dictionary new. ! !

!TusLibrosWebServerTest methodsFor: 'test objects creation' stamp: 'EB 6/28/2019 16:11:11'!
createServerWithApiWithRegisteredCredentials: someRegisteredCredentials
andPriceList: aPriceList
	
	| api |
	api _ self 
		tusLibrosApiWithRegisteredCredentials: someRegisteredCredentials
		andPriceList: aPriceList.
	self createServerFor: api.
	^api.! !

!TusLibrosWebServerTest methodsFor: 'test objects creation' stamp: 'EB 6/29/2019 18:50:07'!
tusLibrosApiWithRegisteredCredentials: someRegisteredCredentials
andPriceList: aPriceList
	
	| authenticator |
	
	authenticator _ CredentialsDictionaryUserAuthenticator 
		withRegisteredCredentials: someRegisteredCredentials.
	merchantProcessor _ MerchantProcessorForTesting new.
	clock _ ManualClock startingNow.
	^TusLibrosApi 
		authenticatingWith: authenticator
		debitingFrom: merchantProcessor
		withPriceList: aPriceList
		andClock: clock.! !


!TusLibrosWebServerTest methodsFor: 'tearDown' stamp: 'EB 6/27/2019 15:47:24'!
tearDown

	server ifNotNil: [ server destroy ].! !


!TusLibrosWebServerTest methodsFor: 'response parsing' stamp: 'EB 6/28/2019 16:21:47'!
responseDescription: aResponse
	^aResponse content after: $|.! !


!TusLibrosWebServerTest methodsFor: 'tests - checkout' stamp: 'EB 6/30/2019 19:08:28'!
test13CheckoutCartShouldDebitCorrectAmountFromMerchantProcessor

	| response bookIsbn bookIsbn2 bookPrice bookPrice2 
	bookQuantity bookQuantity2 cartId 
	totalPrice expectedCreditCard 
	usedCreditCards |
 
	bookIsbn _ 1.
	bookPrice _ 23.
	bookIsbn2 _ 2.
	bookPrice2 _ 45.
	cartId _ self createServerAndCreateCartWithPriceList: 
		{bookIsbn -> bookPrice. bookIsbn2 -> bookPrice2} asDictionary.
	
	bookQuantity _ 34.
	bookQuantity2 _ 2.
	self getAddToCartWithCartId: cartId andBookIsbn: bookIsbn andQuantity: bookQuantity.
	self getAddToCartWithCartId: cartId andBookIsbn: bookIsbn andQuantity: bookQuantity.
	self getAddToCartWithCartId: cartId andBookIsbn: bookIsbn2 andQuantity: bookQuantity2.
	
	expectedCreditCard _ 
		CreditCard 
			numbered: '1234567890123456' 
			withOwner: 'Juan Perez' 
			andExpiration: clock now monthOfYear. 		
	response _ self 
		getCheckoutCartWithCartId: cartId
		andCreditCard: expectedCreditCard.

	totalPrice _ 2 * bookQuantity * bookPrice + (bookQuantity2 * bookPrice2).
	
	self assert: 200 equals: response code.
	self assert: (response content beginsWith: '0|').
	self assert: totalPrice equals: merchantProcessor debitedAmount.
	
	usedCreditCards _ merchantProcessor usedCreditCards.
	self assert: 1 equals: usedCreditCards size.
	self assert: expectedCreditCard equals: usedCreditCards first.
	! !

!TusLibrosWebServerTest methodsFor: 'tests - checkout' stamp: 'EB 6/30/2019 21:55:40'!
test14TusLibrosApiErrorsArePropagatedWhenCheckingOut
	"Can't checkout with a nonexistent cart ID."
	| expectedCreditCard |

	self createServerWithApiWithNoCredentials.
	
	expectedCreditCard _
		CreditCard 
			numbered: '1234567890123456' 
			withOwner: 'Juan Perez'
			andExpiration: clock now monthOfYear. 
	
	self should: [ self getCheckoutCartWithCartId: '1' andCreditCard: expectedCreditCard ]
		returnFailureResponseWithDescription: (TusLibrosApi cartDoesNotExistErrorMessage: 1)	! !

!TusLibrosWebServerTest methodsFor: 'tests - checkout' stamp: 'EB 6/30/2019 22:49:23'!
test15CantCheckoutWithInvalidCreditCardNumber

	| cartId |
	
	cartId _ self createServerAndCreateCartWithPriceList: Dictionary new.
	
	self shouldReturnBadRequestResponse: [
		self
			getCheckoutCartWithCartId: cartId
			andCreditCardNumber: '1234'
			andCreditCardExpiration: '012019'
			andCreditCardOwner: 'JUAN PEREJIL' ]! !

!TusLibrosWebServerTest methodsFor: 'tests - checkout' stamp: 'EB 6/30/2019 23:17:16'!
test16CantCheckoutWithInvalidCreditCardExpiration

	| cartId |
	
	cartId _ self createServerAndCreateCartWithPriceList: Dictionary new.
	
	self shouldReturnBadRequestResponse: [
		self
			getCheckoutCartWithCartId: cartId
			andCreditCardNumber: '1234567890123456'
			andCreditCardExpiration: 'a12019'
			andCreditCardOwner: 'JUAN PEREJIL' ]! !


!TusLibrosWebServerTest methodsFor: 'tests - createCart' stamp: 'EB 6/30/2019 22:00:20'!
test01CreateCartWithoutParametersShouldReturnBadRequestError

	self createServerWithApiWithNoCredentials.

	self shouldReturnBadRequestResponse: [ self getCreateCartWithParams: {} ]
	! !

!TusLibrosWebServerTest methodsFor: 'tests - createCart' stamp: 'EB 6/28/2019 16:13:20'!
test02CanCreateACartWithValidCredentials

	| response password user |
	user _ 'Juan'.
	password _ 'hunter2'.
	self createServerWithApiWithRegisteredCredentials: {user -> password} asDictionary .
	
	response _ self getCreateCartWithClientId: user andPassword: password.
	
	self assert: 200 equals: response code.
	self assert: (response content beginsWith: '0|').! !

!TusLibrosWebServerTest methodsFor: 'tests - createCart' stamp: 'EB 6/30/2019 21:54:32'!
test04CantCreateCartWithNotRegisteredUser
	
	self createServerWithApiWithNoCredentials.
	
	self 
		should: [ self getCreateCartWithClientId: 'Jose' andPassword: 'asdasd' ]
		returnFailureResponseWithDescription: 
			TusLibrosApi invalidUserCredentialsErrorMessage.! !

!TusLibrosWebServerTest methodsFor: 'tests - createCart' stamp: 'EB 6/30/2019 21:56:19'!
test05CantCreateCartWithWrongPassword
	
	| clientId password |

	clientId _ 'Juan'.
	password _ 'password'.
	self createServerWithApiWithRegisteredCredentials: {clientId -> password} asDictionary.
	
	self 
		should: [ self getCreateCartWithClientId: clientId andPassword: 'asdasd' ]
		returnFailureResponseWithDescription: 
			TusLibrosWebServer invalidUserCredentialsErrorMessage.! !

!TusLibrosWebServerTest methodsFor: 'tests - createCart' stamp: 'EB 6/30/2019 21:58:47'!
test06CantCreateCartWithoutProvidingPassword
	
	| clientId password |

	clientId _ 'Juan'.
	password _ 'password'.
	self createServerWithApiWithRegisteredCredentials: {clientId -> password} asDictionary.
	
	self shouldReturnBadRequestResponse: [ self getCreateCartWithParams: {'clientId' -> clientId} ]
	! !


!TusLibrosWebServerTest methodsFor: 'tests - listCart' stamp: 'EB 6/28/2019 16:22:39'!
test07CanListAnEmptyCart

	| response password user cartId |
	user _ 'Juan'.
	password _ 'hunter2'.
	self createServerWithApiWithRegisteredCredentials: {user -> password} asDictionary.
	
	response _ self getCreateCartWithClientId: user andPassword: password.
	
	cartId _ self responseDescription: response.
	response _ self getListCartWithCartId: cartId.
	
	self assert: 200 equals: response code.
	self assert: '0|' equals: response content.! !

!TusLibrosWebServerTest methodsFor: 'tests - listCart' stamp: 'EB 6/30/2019 21:54:26'!
test08CantListANotCreatedCart

	self createServerWithApiWithNoCredentials.
	self 
		should: [ self getListCartWithCartId: '1' ]
		returnFailureResponseWithDescription: 
			(TusLibrosApi cartDoesNotExistErrorMessage: 1).! !

!TusLibrosWebServerTest methodsFor: 'tests - listCart' stamp: 'EB 6/29/2019 14:51:30'!
test10AddedProductsAppearInCartList

	| response clientId password cartId bookIsbn bookPrice bookQuantity bookIsbn2 bookPrice2 bookQuantity2 expectedString |
 
	clientId _ 'Juan'.
	password _ 'hunter2'. 
	bookIsbn _ 1.
	bookPrice _ 23.
	bookIsbn2 _ 2.
	bookPrice2 _ 45.
	self 
		createServerWithApiWithRegisteredCredentials: {clientId -> password} asDictionary 
		andPriceList: {bookIsbn -> bookPrice. bookIsbn2 -> bookPrice2} asDictionary.
	
	response _ self getCreateCartWithClientId: clientId andPassword: password.
	cartId _ self responseDescription: response.
	bookQuantity _ 34.
	bookQuantity2 _ 2.
	self getAddToCartWithCartId: cartId andBookIsbn: bookIsbn andQuantity: bookQuantity.
	self getAddToCartWithCartId: cartId andBookIsbn: bookIsbn andQuantity: bookQuantity.
	self getAddToCartWithCartId: cartId andBookIsbn: bookIsbn2 andQuantity: bookQuantity2.
	
	response _ self getListCartWithCartId: cartId.
	
	expectedString _ 
		'0|', bookIsbn asString, '|', (bookQuantity * 2) asString, '|',
		bookIsbn2 asString, '|', bookQuantity2 asString.
		
	self assert: 200 equals: response code.
	self assert:  expectedString equals: response content.! !

!TusLibrosWebServerTest methodsFor: 'tests - listCart' stamp: 'EB 6/30/2019 21:58:22'!
test12CantPassSomethingOtherThanANumberAsCartIdToListCart

	self createServerWithApiWithNoCredentials.
	
	self shouldReturnBadRequestResponse: [ self getListCartWithCartId: 'aStringCartId' ]! !


!TusLibrosWebServerTest methodsFor: 'tests - addToCart' stamp: 'EB 6/30/2019 19:25:00'!
test09CanAddProductToCart

	| response clientId password cartId bookIsbn bookPrice |
 
	clientId _ 'Juan'.
	password _ 'hunter2'. 
	bookIsbn _ 1.
	bookPrice _ 23.
	self 
		createServerWithApiWithRegisteredCredentials: {clientId -> password} asDictionary
		andPriceList: {bookIsbn -> bookPrice} asDictionary. 
	
	response _ self getCreateCartWithClientId: clientId andPassword: password.
	
	cartId _ self responseDescription: response.
	response _ self getAddToCartWithCartId: cartId andBookIsbn: bookIsbn andQuantity: 1.
	
	self assert: 200 equals: response code.
	self assert: '0|OK' equals: response content.
! !

!TusLibrosWebServerTest methodsFor: 'tests - addToCart' stamp: 'EB 6/30/2019 21:54:26'!
test11ErrorsAddingToCartAreParsedInTheResponse

	| bookIsbn bookPrice |
 
	bookIsbn _ 1.
	bookPrice _ 42.
	self 
		createServerWithApiWithRegisteredCredentials: Dictionary new 
		andPriceList: {bookIsbn -> bookPrice} asDictionary.
	
	self 
		should: [ self getAddToCartWithCartId: 1 andBookIsbn: bookIsbn andQuantity: 1 ]   
		returnFailureResponseWithDescription: (TusLibrosApi cartDoesNotExistErrorMessage: 1)! !


!TusLibrosWebServerTest methodsFor: 'assertions' stamp: 'EB 6/30/2019 21:54:26'!
should: aBlock returnFailureResponseWithDescription: aMessageText 
	
	| response |
	
	response _ aBlock value.
	
	self assert: 200 equals: response code.
	self assert: '1|', aMessageText equals: response content.! !

!TusLibrosWebServerTest methodsFor: 'assertions' stamp: 'EB 6/30/2019 21:57:41'!
shouldReturnBadRequestResponse: aBlock
	self assert: 400 equals: aBlock value code.! !


!TusLibrosWebServerTest methodsFor: 'tests - listPurchases' stamp: 'EB 7/1/2019 01:49:37'!
test17ListPurchasesShouldReturnEmptyResponseWhenNoPurchasesHaveBeenMade

	| clientId password response |
	
	clientId _ 'Pepe'.
	password _ 'xXpasswordXx'.
	self createServerWithApiWithRegisteredCredentials: {clientId -> password} asDictionary.
	
	response _ self getListPurchasesWithClientId: clientId andPassword: password.

	self assert: 200 equals: response code.
	self assert: '0|0' equals: response content.! !

!TusLibrosWebServerTest methodsFor: 'tests - listPurchases' stamp: 'EB 7/1/2019 02:06:39'!
test18ListPurchasesWithPurchasesMadeShouldShowBooksPurchased

	| clientId password response bookIsbn bookPrice cartId creditCard expectedString quantity |
	
	clientId _ 'Pepe'.
	password _ 'xXpasswordXx'.
	bookIsbn _ 1.
	bookPrice _ 2.
	cartId _ self createServerAndCreateCartWithPriceList: {bookIsbn -> bookPrice} asDictionary
		withClientId: clientId andPassword: password.
	
	quantity _ '23'.
	self getAddToCartWithCartId: cartId andBookIsbn: bookIsbn asString andQuantity: quantity.
	creditCard _ CreditCardsForTestingFactory new nonExpiredCreditCard.
	self getCheckoutCartWithCartId: cartId andCreditCard: creditCard.
	
	response _ self getListPurchasesWithClientId: clientId andPassword: password.
	
	expectedString _ '0|', bookIsbn asString, '|', quantity, '|', quantity.
	self assert: 200 equals: response code.
	self assert: expectedString equals: response content.! !

!TusLibrosWebServerTest methodsFor: 'tests - listPurchases' stamp: 'EB 7/1/2019 02:10:01'!
test19ErrorsListingPurchasesAreParsedInTheResponse

	self createServerWithApiWithNoCredentials.
	self 
		should: [ self getListPurchasesWithClientId: 'Pepe' andPassword: 'soyelmejor' ]
		returnFailureResponseWithDescription: 
			TusLibrosApi invalidUserCredentialsErrorMessage.! !


!TusLibrosWebServerTest methodsFor: 'tests - listPrices' stamp: 'EB 7/1/2019 13:40:38'!
test20ListPricesShouldReturnResponseWithParsedPriceList

	| priceList response |
	
	priceList _ {1 -> 2. 3 -> 4} asDictionary.
	self 
		createServerWithApiWithRegisteredCredentials: Dictionary new 
		andPriceList: priceList.
	
	response _ self getListPrices.
	
	self assert: 200 equals: response code.
	self assert: '0|1|2|3|4' equals: response content.! !

!TusLibrosWebServerTest methodsFor: 'tests - listPrices' stamp: 'EB 7/1/2019 13:40:53'!
test21ListPricesWithoutPricesShouldReturnEmptyResponseContent

	| response |
	
	self createServerWithApiWithNoCredentials.

	response _ self getListPrices.
	
	self assert: 200 equals: response code.
	self assert: '0|' equals: response content.! !


!classDefinition: #CredentialsDictionaryUserAuthenticator category: #'TusLibros-Tests'!
Object subclass: #CredentialsDictionaryUserAuthenticator
	instanceVariableNames: 'registeredCredentials'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!CredentialsDictionaryUserAuthenticator methodsFor: 'initialization' stamp: 'EB 6/25/2019 16:53:52'!
initializeWithRegisteredCredentials: someRegisteredCredentials
	registeredCredentials _ someRegisteredCredentials.! !


!CredentialsDictionaryUserAuthenticator methodsFor: 'authenticating' stamp: 'EB 6/28/2019 15:12:19'!
authenticate: aClient withPassword: aPassword 
	^(registeredCredentials includesKey: aClient) and: 
		[ (registeredCredentials at: aClient) = aPassword ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CredentialsDictionaryUserAuthenticator class' category: #'TusLibros-Tests'!
CredentialsDictionaryUserAuthenticator class
	instanceVariableNames: ''!

!CredentialsDictionaryUserAuthenticator class methodsFor: 'instance creation' stamp: 'EB 6/25/2019 16:51:52'!
withRegisteredCredentials: someRegisteredCredentials
	"UserAuthenticatorForTesting withRegisteredCredentials: {'Juan' -> 'hunter2'} asDictionary"
	^self new initializeWithRegisteredCredentials: someRegisteredCredentials.! !


!classDefinition: #CreditCardsForTestingFactory category: #'TusLibros-Tests'!
Object subclass: #CreditCardsForTestingFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!CreditCardsForTestingFactory methodsFor: 'instance creation' stamp: 'EB 6/15/2019 16:58:01'!
creditCardWithExpiration: anExpiration
	^CreditCard numbered: '1234567890123456' withOwner: 'PEPE SANCHEZ' andExpiration: anExpiration. ! !

!CreditCardsForTestingFactory methodsFor: 'instance creation' stamp: 'EB 6/15/2019 16:58:13'!
expiredCreditCard
	^self creditCardWithExpiration: GregorianMonthOfYear current previous.  ! !

!CreditCardsForTestingFactory methodsFor: 'instance creation' stamp: 'EB 6/15/2019 16:58:24'!
nonExpiredCreditCard
	^self creditCardWithExpiration: GregorianMonthOfYear current next. ! !


!classDefinition: #ExtendedAssertions category: #'TusLibros-Tests'!
Object subclass: #ExtendedAssertions
	instanceVariableNames: 'testCase'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

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

!classDefinition: 'ExtendedAssertions class' category: #'TusLibros-Tests'!
ExtendedAssertions class
	instanceVariableNames: ''!

!ExtendedAssertions class methodsFor: 'instance creation' stamp: 'EB 6/11/2019 19:44:48'!
for: aTestCase
	^self new initializeFor: aTestCase.! !


!classDefinition: #ManualClock category: #'TusLibros-Tests'!
Object subclass: #ManualClock
	instanceVariableNames: 'currentDateTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!ManualClock methodsFor: 'accessing' stamp: 'EB 6/25/2019 17:10:59'!
now
	^currentDateTime! !


!ManualClock methodsFor: 'advancing time' stamp: 'EB 6/25/2019 17:12:02'!
advance: aTimeMeasure
	currentDateTime _ currentDateTime next: aTimeMeasure.! !


!ManualClock methodsFor: 'initialization' stamp: 'EB 6/25/2019 17:13:31'!
initializeOn: aTimePoint
	currentDateTime _ aTimePoint.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ManualClock class' category: #'TusLibros-Tests'!
ManualClock class
	instanceVariableNames: ''!

!ManualClock class methodsFor: 'instance creation' stamp: 'EB 6/25/2019 17:13:07'!
startingAt: aTimePoint
	^self new initializeOn: aTimePoint.! !

!ManualClock class methodsFor: 'instance creation' stamp: 'EB 6/25/2019 17:14:59'!
startingNow
	^self startingAt: GregorianDateTime now.! !


!classDefinition: #MerchantProcessorForTesting category: #'TusLibros-Tests'!
Object subclass: #MerchantProcessorForTesting
	instanceVariableNames: 'debited creditCardsUsed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

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


!classDefinition: #WebResponseTestDouble category: #'TusLibros-Tests'!
Object subclass: #WebResponseTestDouble
	instanceVariableNames: 'content code'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!WebResponseTestDouble methodsFor: 'accessing' stamp: 'EB 7/2/2019 00:05:51'!
code
	^code! !

!WebResponseTestDouble methodsFor: 'accessing' stamp: 'EB 7/2/2019 00:05:29'!
content
	^content.! !


!WebResponseTestDouble methodsFor: 'initializing' stamp: 'EB 7/2/2019 00:06:20'!
initializeWithCode: aCode andContent: someContent
	content _ someContent.
	code _ aCode.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WebResponseTestDouble class' category: #'TusLibros-Tests'!
WebResponseTestDouble class
	instanceVariableNames: ''!

!WebResponseTestDouble class methodsFor: 'instance creation' stamp: 'EB 7/2/2019 00:06:59'!
withCode: aCode andContent: someContent
	^self new initializeWithCode: aCode andContent: someContent! !
