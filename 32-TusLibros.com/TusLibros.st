!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'EB 5/31/2019 17:14:53'!
test01NewCartShouldBeEmpty
	| cart |
	cart _ Cart withCatalog: {}.
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'EB 5/31/2019 17:15:26'!
test02CartWithAddedBookShouldContainBook
	| cart bookIsbn catalog |
	bookIsbn _ 123.
	catalog _ {bookIsbn}.
	cart _ Cart withCatalog: catalog.
	
	cart add: bookIsbn.
	
	self deny: cart isEmpty.
	self assert: (cart containsBook: bookIsbn).! !

!CartTest methodsFor: 'tests' stamp: 'EB 5/31/2019 17:18:40'!
test03EmptyCartShouldNotContainAnyBook
	| cart |
	cart _ Cart withCatalog: {}.
	
	self deny: (cart containsBook: 123).! !

!CartTest methodsFor: 'tests' stamp: 'EB 5/31/2019 17:22:16'!
test04CantAddBookThatIsntInTheCatalog
	| cart |
	cart _ Cart withCatalog: {}.

	self 
		should: [cart add: 123]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: (Cart bookNotInCatalogErrorMessage: 123) equals: exception messageText.
			
			self assert: cart isEmpty.
			self deny: (cart containsBook: 123). 
		].! !

!CartTest methodsFor: 'tests' stamp: 'EB 5/31/2019 17:27:53'!
test05CartWithMoreThanOneBookAddedShouldContainAll
	| cart |
	cart _ Cart withCatalog: {1. 2}.
	
	cart add: 1.
	cart add: 2.
	 
	self deny: cart isEmpty.
	self assert: (cart containsBook: 1).
	self assert: (cart containsBook: 2).! !

!CartTest methodsFor: 'tests' stamp: 'EB 5/31/2019 17:31:46'!
test06AddingABookMoreThanOnceShouldIncrementBookCount
	| cart |
	cart _ Cart withCatalog: {1. 2}.
	
	cart add: 1.
	cart add: 1.
	 
	self deny: cart isEmpty.
	self assert: (cart containsBook: 1).
	self assert: 2 equals: (cart bookCount: 1).! !

!CartTest methodsFor: 'tests' stamp: 'EB 5/31/2019 17:37:04'!
test07EmptyCartShouldHaveBookCount0ForAnyBook
	| cart |
	cart _ Cart withCatalog: {}.
	 
	self assert: cart isEmpty.
	self assert: 0 equals: (cart bookCount: 1).! !

!CartTest methodsFor: 'tests' stamp: 'EB 5/31/2019 17:37:41'!
test08CartWithOneBookShouldHaveBookCount1ForThatBook
	| cart |
	cart _ Cart withCatalog: {1. 2}.
	
	cart add: 1.
	
	self deny: cart isEmpty.
	self assert: 1 equals: (cart bookCount: 1).
	self assert: 0 equals: (cart bookCount: 2).! !

!CartTest methodsFor: 'tests' stamp: 'EB 5/31/2019 17:44:51'!
test09ContentsOfCartShouldContainAllBooks
	| cart contents |
	cart _ Cart withCatalog: {1. 2. 3}.
	
	cart add: 1.
	cart add: 2.
	cart add: 1.
	
	contents _ cart contents.
	
	self deny: cart isEmpty.
	self assert: 2 equals: (contents occurrencesOf: 1).
	self assert: 1 equals: (contents occurrencesOf: 2).
	self assert: 0 equals: (contents occurrencesOf: 3).! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'EB 6/4/2019 22:34:38'!
test01CantCheckoutAnEmptyCart
	| cart cashier |
	cart _ Cart withCatalog: {}.
	cashier _ Cashier withPriceList: Dictionary new.
	
	self should: [ cashier checkout: cart withBankAccount: BankAccountForTesting new ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: Cashier cantCheckoutAnEmptyCartErrorMessage equals: exception messageText ]! !

!CashierTest methodsFor: 'tests' stamp: 'EB 6/4/2019 22:34:51'!
test02CantCheckoutACartWithProductNotInPriceList
	| cart cashier |
	cart _ Cart withCatalog: {1}.
	cart add: 1.
	cashier _ Cashier withPriceList: Dictionary new.
	
	self should: [ cashier checkout: cart withBankAccount: BankAccountForTesting new ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: (Cashier cartHasProductNotInPriceListErrorMessage: 1) equals: exception messageText ]! !

!CashierTest methodsFor: 'tests' stamp: 'EB 6/4/2019 22:35:21'!
test03CheckoutWithProductsShouldDebitTheRightAmount

	| cart cashier bankAccount |

	cart _ Cart withCatalog: {1. 2}.
	cart add: 1.
	cart add: 1.
	cart add: 2.
	cashier _ Cashier withPriceList: {1 -> 23. 2 -> 123} asDictionary.
	
	bankAccount _ BankAccountForTesting new.
	cashier checkout: cart withBankAccount: bankAccount.
	
	self assert: 169 equals: bankAccount debited.	! !

!CashierTest methodsFor: 'tests' stamp: 'EB 6/4/2019 22:35:15'!
test04CheckoutWithAProductNotInPriceListShouldNotDebitForAnyProduct

	| cart cashier bankAccount |

	cart _ Cart withCatalog: {1. 2}.
	cart add: 2.
	cart add: 2.
	cart add: 1.
	cashier _ Cashier withPriceList: {2 -> 23} asDictionary.
	
	bankAccount _ BankAccountForTesting new.
	
	self should: [ cashier checkout: cart withBankAccount: bankAccount ]
		raise: Error - MessageNotUnderstood.
	
	self assert: 0 equals: bankAccount debited.! !

!CashierTest methodsFor: 'tests' stamp: 'EB 6/4/2019 22:35:08'!
test05CheckoutShouldDebitJustOnce

	| cart cashier bankAccount |

	cart _ Cart withCatalog: {1. 2}.
	cart add: 2.
	cart add: 2.
	cart add: 1.
	cashier _ Cashier withPriceList: {1 -> 45. 2 -> 23} asDictionary.
	
	bankAccount _ BankAccountForTesting new.
	
	cashier checkout: cart withBankAccount: bankAccount.
	
	self assert: 91 equals: bankAccount debited.
	self assert: bankAccount wasDebitedOnlyOnce.! !


!classDefinition: #BankAccountForTesting category: #TusLibros!
Object subclass: #BankAccountForTesting
	instanceVariableNames: 'debited timesDebited'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!BankAccountForTesting methodsFor: 'debiting' stamp: 'EB 6/4/2019 22:30:51'!
debit: anAmount
	timesDebited _ timesDebited + 1.
	debited _ debited + anAmount.! !

!BankAccountForTesting methodsFor: 'debiting' stamp: 'EB 6/4/2019 22:00:52'!
debited
	^debited! !


!BankAccountForTesting methodsFor: 'initialization' stamp: 'EB 6/4/2019 22:30:29'!
initialize
	debited _ 0.
	timesDebited _ 0.! !


!BankAccountForTesting methodsFor: 'testing' stamp: 'EB 6/4/2019 22:31:05'!
wasDebitedOnlyOnce
	^timesDebited = 1.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog books'
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


!Cart methodsFor: 'initialization' stamp: 'EB 5/31/2019 17:35:17'!
initializeWithCatalog: aCatalog 
	catalog _ aCatalog.
	books _ Bag new.! !


!Cart methodsFor: 'adding books' stamp: 'EB 5/31/2019 17:29:56'!
add: aBookIsbn

	(catalog includes: aBookIsbn) ifFalse: [
		self error: (self class bookNotInCatalogErrorMessage: 123) ].
	books add: aBookIsbn.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'EB 5/31/2019 16:56:15'!
withCatalog: aCatalog 
	^self new initializeWithCatalog: aCatalog.! !


!Cart class methodsFor: 'error messages' stamp: 'EB 5/31/2019 17:25:26'!
bookNotInCatalogErrorMessage: aBookIsbn 
	^'The book with ISBN ', aBookIsbn asString, ' isn''t present in the catalog.'.! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'priceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'EB 6/4/2019 22:07:22'!
initializeWithPriceList: aPriceList

	priceList _ aPriceList.! !


!Cashier methodsFor: 'checkout' stamp: 'EB 6/4/2019 22:25:49'!
calculateDebitAmountFor: aCart
	
	| products |
	
	products _ aCart contents.
	self assertProductsInPriceList: products.
	
	^products sum: [ :product | priceList at: product ].! !

!Cashier methodsFor: 'checkout' stamp: 'EB 6/4/2019 22:20:28'!
checkout: aCart withBankAccount: aBankAccount
	
	self assertCartIsNotEmpty: aCart.
	
	aBankAccount debit: (self calculateDebitAmountFor: aCart).
	
	! !


!Cashier methodsFor: 'assertions' stamp: 'EB 6/4/2019 22:07:18'!
assertCartIsNotEmpty: aCart

	aCart isEmpty ifTrue: [ self error: self class cantCheckoutAnEmptyCartErrorMessage ].! !

!Cashier methodsFor: 'assertions' stamp: 'EB 6/4/2019 22:23:41'!
assertProductsInPriceList: products
	products do: [ :product |
		(priceList includesKey: product) ifFalse: [
			self error: (self class cartHasProductNotInPriceListErrorMessage: product) ].
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'EB 6/4/2019 21:06:41'!
withPriceList: aPriceList
	^self new initializeWithPriceList: aPriceList.! !


!Cashier class methodsFor: 'error messages' stamp: 'EB 6/4/2019 21:02:44'!
cantCheckoutAnEmptyCartErrorMessage
	^'The cart is empty, there is nothing to checkout.'.! !

!Cashier class methodsFor: 'error messages' stamp: 'EB 6/4/2019 21:12:27'!
cartHasProductNotInPriceListErrorMessage: aProduct
	^'The product ', aProduct asString, ' is not in the price list.'.! !

!Cashier class methodsFor: 'error messages' stamp: 'EB 6/4/2019 21:10:53'!
cartHasProductsNotInPriceListErrorMessage: anArray 
	self shouldBeImplemented.! !

!Cashier class methodsFor: 'error messages' stamp: 'EB 6/4/2019 21:27:55'!
creditCardIsInvalidErrorMessage
	^'The credit card supplied is invalid.'.! !
