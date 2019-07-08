!classDefinition: #TusLibrosClientWindowLogin category: #TusLibros!
Panel subclass: #TusLibrosClientWindowLogin
	instanceVariableNames: 'webClient userName userPass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosClientWindowLogin methodsFor: 'initialization' stamp: 'NSM 7/7/2019 13:33:23'!
defaultExtent

	^ 630@435
	! !

!TusLibrosClientWindowLogin methodsFor: 'initialization' stamp: 'EB 7/7/2019 22:01:10'!
initializeWith: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: TusLibrosClientWindowLoginModel new.
	self morphExtent: self defaultExtent.
	self buildMorphicWindow.
	self openInWorld.
		
	self model when: #createCartRequest send: #openPurchaseWindowWithCartId: to: self.
	
	! !

!TusLibrosClientWindowLogin methodsFor: 'initialization' stamp: 'EB 7/7/2019 21:14:05'!
newCart
	TusLibrosClientWindowPurchase open.! !

!TusLibrosClientWindowLogin methodsFor: 'initialization' stamp: 'EB 7/7/2019 22:05:35'!
openPurchaseWindowWithCartId: aCartId
	TusLibrosClientWindowPurchase openForCart: aCartId.! !


!TusLibrosClientWindowLogin methodsFor: 'layout building' stamp: 'EB 7/7/2019 21:12:58'!
buildMorphicWindow
	
	| loginButton |
	
	loginButton := PluggableButtonMorph 
		model: self model 
		stateGetter: nil
		action: #sendCreateCartRequest 
		label: 'create cart'.
	
	self layoutMorph 
		beColumn;
		separation: 15;
		padding: #left;
		addMorph: (StringMorph contents: 'user:');
		addMorph: (self buildTextModelMorphWithTextSetter: #setUserName:);
		addMorph: (StringMorph contents: 'password:');
		addMorph: (self buildTextModelMorphWithTextSetter: #setPassword:);
		addMorph: loginButton.
	
	! !

!TusLibrosClientWindowLogin methodsFor: 'layout building' stamp: 'EB 7/7/2019 21:08:27'!
buildTextModelMorphWithTextSetter: aTextSetterSymbol

	| textModelMorph |

	textModelMorph _ TextModelMorph 
		textProvider: self model 
		textGetter: nil 
		textSetter: aTextSetterSymbol.
	textModelMorph textMorph 
		setProperty: #keyStroke: 
		toValue: [ :key | textModelMorph textMorph acceptContents ].
	textModelMorph  borderWidth: 1; borderColor: Color skyBlue.
	^textModelMorph.	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientWindowLogin class' category: #TusLibros!
TusLibrosClientWindowLogin class
	instanceVariableNames: ''!

!TusLibrosClientWindowLogin class methodsFor: 'instance creation' stamp: 'NSM 7/7/2019 16:20:37'!
open
	
	^self new initializeWith: 'TusLibros Log in-Service Client Window'.! !


!classDefinition: #TusLibrosClientWindowPurchase category: #TusLibros!
Panel subclass: #TusLibrosClientWindowPurchase
	instanceVariableNames: 'webClient userName userPass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosClientWindowPurchase methodsFor: 'initialization' stamp: 'NSM 7/7/2019 13:33:48'!
defaultExtent

	^ 630@435
	! !

!TusLibrosClientWindowPurchase methodsFor: 'initialization' stamp: 'NSM 7/7/2019 15:41:57'!
initializeWith: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (TusLibrosClientWindowPurchaseModel withCartId: 1).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
			
	self model when: #addToCartRequest send: #refreshCart to: self.
	self model when: #checkoutRequest send: #refreshCart to: self.
	! !

!TusLibrosClientWindowPurchase methodsFor: 'initialization' stamp: 'EB 7/7/2019 21:49:07'!
initializeWithTitle: aTitle forCartId: aCartId

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (TusLibrosClientWindowPurchaseModel withCartId: aCartId).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
			
	self model when: #addToCartRequest send: #refreshCart to: self.
	self model when: #checkoutRequest send: #refreshCart to: self.
	! !

!TusLibrosClientWindowPurchase methodsFor: 'initialization' stamp: 'NSM 7/7/2019 13:47:42'!
refreshCart
	! !


!TusLibrosClientWindowPurchase methodsFor: 'GUI building' stamp: 'EB 7/7/2019 21:15:53'!
build1stCol
	| addToCartButton firstColLayout catalogList |
	
	addToCartButton := PluggableButtonMorph 
		model: self model 
		stateGetter: nil  
		action: #sendAddToCartRequest 
		label: 'Add to Cart'.	
	
	catalogList := PluggableListMorph model: self model listGetter: #catalogo indexGetter: #productoSeleccionadoIndex indexSetter: #productoSeleccionadoIndex:.

"	catalogList := PluggableListMorph model: self model listGetter: #catalogo indexGetter: nil indexSetter: nil."
	catalogList  borderColor: Color skyBlue.
	catalogList  borderWidth: 1.
	
	firstColLayout := LayoutMorph newColumn .
	firstColLayout separation: 25;
	padding: #left;
	addMorph: catalogList ;
	addMorph: addToCartButton.
	
	^firstColLayout.
	! !

!TusLibrosClientWindowPurchase methodsFor: 'GUI building' stamp: 'EB 7/7/2019 21:15:32'!
build2ndCol
	| checkoutButton secondColLayout cartList |
	
	checkoutButton := PluggableButtonMorph 
		model: self model 
		stateGetter: nil
		action: #sendCheckoutCartRequest 
		label: 'Checkout!!'.
	
	cartList := PluggableListMorph 
		model: self model 
		listGetter: #carrito 
		indexGetter: nil
		indexSetter: nil.
	cartList  borderColor: Color skyBlue.
	cartList  borderWidth: 1.
	
	secondColLayout := LayoutMorph newColumn .
	secondColLayout separation: 25;
	padding: #left;
	addMorph: cartList ;
	addMorph: checkoutButton.
	
	^secondColLayout.
	! !

!TusLibrosClientWindowPurchase methodsFor: 'GUI building' stamp: 'NSM 7/7/2019 19:32:30'!
buildMorphicWindow
		
	self layoutMorph beRow ;
	separation: 15;
	padding: #left;
	addMorph: self build1stCol;
	addMorph: self build2ndCol.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientWindowPurchase class' category: #TusLibros!
TusLibrosClientWindowPurchase class
	instanceVariableNames: ''!

!TusLibrosClientWindowPurchase class methodsFor: 'as yet unclassified' stamp: 'NSM 7/7/2019 14:49:34'!
open
	
	^self new initializeWith: 'TusLibros-Service Client Window'.! !


!TusLibrosClientWindowPurchase class methodsFor: 'instance creation' stamp: 'EB 7/7/2019 21:48:28'!
openForCart: aCartId
	
	^self new initializeWithTitle: 'TusLibros-Service Client Window' forCartId: aCartId.! !


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


!CreditCard methodsFor: 'comparing' stamp: 'EB 6/30/2019 19:02:46'!
= anObject
	^(anObject isKindOf: self class) and: [
		self expiration = anObject expiration and: [
			self owner = anObject owner and: [
				self number = anObject number
			]
		]
	]
	! !

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


!classDefinition: #GregorianMonthOfYearHTTPDecoder category: #TusLibros!
Object subclass: #GregorianMonthOfYearHTTPDecoder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!GregorianMonthOfYearHTTPDecoder methodsFor: 'decoding' stamp: 'EB 6/30/2019 18:18:04'!
decode: anEncodedMonthOfYear 
	
	| monthNumber yearNumber |
	
	self assertIsValidEncodedMonthOfYear: anEncodedMonthOfYear.
	
	monthNumber _ (anEncodedMonthOfYear copyFrom: 1 to: 2) asNumber.
	yearNumber _ (anEncodedMonthOfYear copyFrom: 3 to: 6) asNumber.
	
	^GregorianMonthOfYear yearNumber: yearNumber monthNumber: monthNumber.! !


!GregorianMonthOfYearHTTPDecoder methodsFor: 'assertions' stamp: 'EB 6/30/2019 18:24:10'!
assertIsValidEncodedMonthOfYear: anEncodedMonthOfYear
	(self isValidEncodedMonthOfYear: anEncodedMonthOfYear) ifTrue: [
		self error: (self class badlyEncodedMonthOfYearErrorMessage: anEncodedMonthOfYear) 
	].
	! !

!GregorianMonthOfYearHTTPDecoder methodsFor: 'assertions' stamp: 'EB 6/30/2019 18:22:38'!
isAnyNotDigit: aCollection
	^aCollection anySatisfy: [ :character | character isDigit not ]! !

!GregorianMonthOfYearHTTPDecoder methodsFor: 'assertions' stamp: 'EB 6/30/2019 18:23:40'!
isValidEncodedMonthOfYear: anEncodedMonthOfYear
	^(self isAnyNotDigit: anEncodedMonthOfYear) or: [ anEncodedMonthOfYear size ~= 6 ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GregorianMonthOfYearHTTPDecoder class' category: #TusLibros!
GregorianMonthOfYearHTTPDecoder class
	instanceVariableNames: ''!

!GregorianMonthOfYearHTTPDecoder class methodsFor: 'error messages' stamp: 'EB 6/30/2019 18:15:27'!
badlyEncodedMonthOfYearErrorMessage: anEncodedMonthOfYear 
	^anEncodedMonthOfYear, ' is not a valid encoded month of year.'.! !


!classDefinition: #GregorianMonthOfYearHTTPEncoder category: #TusLibros!
Object subclass: #GregorianMonthOfYearHTTPEncoder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!GregorianMonthOfYearHTTPEncoder methodsFor: 'encoding' stamp: 'EB 6/29/2019 21:11:11'!
encode: aGregorianMonthOfYear 
	
	| monthNumber yearNumber |
	
	monthNumber _ aGregorianMonthOfYear month number.
	yearNumber _ aGregorianMonthOfYear year number.
	
	^String streamContents: [ :stream |
		monthNumber printOn: stream integerDigits: 2 fractionDigits: 0.
		yearNumber printOn: stream integerDigits: 4 fractionDigits: 0 ].! !


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


!TusLibrosApi methodsFor: 'cart management' stamp: 'EB 6/22/2019 00:34:09'!
add: anAmount ofBookWithIsbn: aBookIsbn toCart: aCartId 
	
	| cart |
	
	self assertAmountIsGreaterThanZero: anAmount.
	self assertCartHasntBeenCheckedOut: aCartId.
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

!TusLibrosApi methodsFor: 'cart management' stamp: 'EB 6/22/2019 00:34:38'!
checkout: aCartId withCreditCard: aCreditCard

	self assertCartHasntBeenCheckedOut: aCartId.
	self assert30MinutesHaventPassedSinceLastUseOfCartWithId: aCartId.
	
	self debitCart: aCartId withCreditCard: aCreditCard.
	self addCartContentsToClientPurchases: aCartId.
	checkedOutCarts add: aCartId.
	
	^self nextTransactionId.! !

!TusLibrosApi methodsFor: 'cart management' stamp: 'EB 6/28/2019 15:10:08'!
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

!TusLibrosApi methodsFor: 'cart management' stamp: 'EB 6/22/2019 00:34:52'!
listCart: aCartId 
	
	self assertCartHasntBeenCheckedOut: aCartId.
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


!TusLibrosApi methodsFor: 'listing prices' stamp: 'EB 7/1/2019 13:16:40'!
listPrices
	^priceList.! !

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

!TusLibrosApi class methodsFor: 'error messages' stamp: 'EB 6/22/2019 00:32:32'!
cartAlreadyCheckedOutErrorMessage: aCartId 
	^'The cart with ID ', aCartId asString, ' has already been checked out; it can''t be operated on.'.! !

!TusLibrosApi class methodsFor: 'error messages' stamp: 'EB 6/11/2019 20:08:55'!
cartDoesNotExistErrorMessage: aCartId 
	^'The cart with ID ', aCartId asString, ' does not exist.'.! !

!TusLibrosApi class methodsFor: 'error messages' stamp: 'EB 6/18/2019 13:50:35'!
cartHasExpiredErrorMessage: aCartId 
	^'30 minutes have passed from the last use of the cart with ID ', aCartId asString, '; it has expired.'.! !

!TusLibrosApi class methodsFor: 'error messages' stamp: 'EB 6/11/2019 17:38:05'!
invalidUserCredentialsErrorMessage
	^'The user credentials supplied are not valid.'.! !


!classDefinition: #TusLibrosClientWindowLoginModel category: #TusLibros!
Object subclass: #TusLibrosClientWindowLoginModel
	instanceVariableNames: 'webClient userPass clientId userName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosClientWindowLoginModel methodsFor: 'initialization' stamp: 'EB 7/7/2019 20:47:20'!
initialize
	webClient _ TusLibrosWebClient usingWebClient: WebClient forUrl: 'http://localhost:8000'.
	clientId _ ''.
	userName _ ''.	
	userPass _ ''.
	! !


!TusLibrosClientWindowLoginModel methodsFor: 'PluggableButtonSelectors' stamp: 'EB 7/7/2019 21:11:07'!
getUserName
	^userName.! !

!TusLibrosClientWindowLoginModel methodsFor: 'PluggableButtonSelectors' stamp: 'EB 7/7/2019 22:00:20'!
sendCreateCartRequest
	| cartId |
	
	cartId _ webClient  getCreateCartWithClientId: userName andPassword: userPass .
	self triggerEvent: #createCartRequest with: cartId.! !

!TusLibrosClientWindowLoginModel methodsFor: 'PluggableButtonSelectors' stamp: 'EB 7/7/2019 20:51:15'!
setPassword: aPassword
	^ userPass _ aPassword .! !

!TusLibrosClientWindowLoginModel methodsFor: 'PluggableButtonSelectors' stamp: 'NSM 7/7/2019 16:13:40'!
setUserName: aUsername
	userName _ aUsername .! !


!classDefinition: #TusLibrosClientWindowPurchaseModel category: #TusLibros!
Object subclass: #TusLibrosClientWindowPurchaseModel
	instanceVariableNames: 'catalogo cantidadSolicitadaProductoSolicitado productosEnCarrito productoSeleccionadoIndex webClient cartId listPrices'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosClientWindowPurchaseModel methodsFor: 'as yet unclassified' stamp: 'NSM 7/7/2019 19:37:00'!
carrito
	^ productosEnCarrito .! !

!TusLibrosClientWindowPurchaseModel methodsFor: 'as yet unclassified' stamp: 'NSM 7/7/2019 14:26:03'!
catalogo
	^ catalogo .! !

!TusLibrosClientWindowPurchaseModel methodsFor: 'as yet unclassified' stamp: 'NSM 7/7/2019 22:50:22'!
getSelectedBookIsbn
	| isbn |
	isbn _ (listPrices at: productoSeleccionadoIndex) x .
	^ isbn.! !

!TusLibrosClientWindowPurchaseModel methodsFor: 'as yet unclassified' stamp: 'NSM 7/7/2019 15:34:36'!
productoSeleccionadoIndex
	^ productoSeleccionadoIndex .! !

!TusLibrosClientWindowPurchaseModel methodsFor: 'as yet unclassified' stamp: 'NSM 7/7/2019 14:25:49'!
productoSeleccionadoIndex: anIndex
	productoSeleccionadoIndex _ anIndex .! !

!TusLibrosClientWindowPurchaseModel methodsFor: 'as yet unclassified' stamp: 'NSM 7/7/2019 22:50:43'!
sendAddToCartRequest
	webClient getAddToCartWithId: cartId adding: (self getSelectedBookIsbn) of: cantidadSolicitadaProductoSolicitado. 
	self updateCartContents.
	self triggerEvent: #addToCartRequest with: self.
	"Hay que agregar al initialize de la Window algo como eso (si no entendi mal):
	self model when: #addToCartRequest send: #refreshWindow  to: self."! !

!TusLibrosClientWindowPurchaseModel methodsFor: 'as yet unclassified' stamp: 'NSM 7/7/2019 19:44:57'!
sendCheckoutCartRequest
	self showWordInTranscript .
	"webClient  getCheckoutCartWithCartId: cartId andCreditCard: 'credit card?'."
	"self triggerEvent: #showWorldInTranscript with: self."
	! !

!TusLibrosClientWindowPurchaseModel methodsFor: 'as yet unclassified' stamp: 'NSM 7/7/2019 19:51:57'!
showWordInTranscript
	
	TranscriptWindow openTranscript.
	Transcript clear.
	Transcript show: 'Compra eviada: '.
	self carrito do: [:libro| Transcript  show: libro, ' '.].
! !

!TusLibrosClientWindowPurchaseModel methodsFor: 'as yet unclassified' stamp: 'EB 7/7/2019 21:52:47'!
updateCartContents
	productosEnCarrito _ webClient getListCartWithId: cartId.! !



!TusLibrosClientWindowPurchaseModel methodsFor: 'initializing' stamp: 'EB 7/7/2019 21:54:49'!
initializeWithCartId: aCartId
	
	| tusLibrosWebClient |
	
	tusLibrosWebClient _ TusLibrosWebClient usingWebClient: WebClient forUrl: 'http://localhost:8000'.
	self 
		initializeWithWebClient: tusLibrosWebClient
		andCartId: aCartId. 
		
		
	! !

!TusLibrosClientWindowPurchaseModel methodsFor: 'initializing' stamp: 'NSM 7/7/2019 22:53:52'!
initializeWithWebClient: aWebClient andCartId: aCartId
	webClient _ aWebClient.
	cartId _ aCartId.
	
	productoSeleccionadoIndex _ 1.
	cantidadSolicitadaProductoSolicitado _ 1.
	catalogo _ OrderedCollection new.
	listPrices _ OrderedCollection new.
	(webClient getListPrices ) keysAndValuesDo:  [:k :v| 
		catalogo add: 'ISBN: ',(k asString) , '  precio: $',(v asString ).
		listPrices add:k@v.
	].
	self updateCartContents.
		
		
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientWindowPurchaseModel class' category: #TusLibros!
TusLibrosClientWindowPurchaseModel class
	instanceVariableNames: ''!

!TusLibrosClientWindowPurchaseModel class methodsFor: 'instance creation' stamp: 'NSM 7/7/2019 15:41:17'!
withCartId: aCartId
	^self new initializeWithCartId: aCartId .! !

!TusLibrosClientWindowPurchaseModel class methodsFor: 'instance creation' stamp: 'NSM 7/7/2019 14:56:54'!
withWebClient: aWebClient andCartId: aCartId
	^self new initializeWithWebClient: aWebClient andCartId: aCartId .! !


!classDefinition: #TusLibrosWebClient category: #TusLibros!
Object subclass: #TusLibrosWebClient
	instanceVariableNames: 'url webClient'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosWebClient methodsFor: 'initialization' stamp: 'EB 7/2/2019 00:15:22'!
initializeUsingWebClient: aWebClient forUrl: anUrlString
	webClient _ aWebClient.
	url _ anUrlString.! !


!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'EB 7/2/2019 14:52:58'!
getAddToCartWithId: aCartId adding: aBookQuantity of: aBookIsbn 
	self 
		getService: '/addToCart'
		withFields: {
			'cartId' -> aCartId asString. 
			'bookIsbn' -> aBookIsbn asString. 
			'bookQuantity' -> aBookQuantity asString}.! !

!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'EB 7/2/2019 23:13:59'!
getCheckoutCartWithId: aCartId 
withCreditCardNumbered: aCreditCardNumber
withExpirationDate: anExpirationDate
andOwner: anOwner 
	
	| encodedCced |
	
	encodedCced _ GregorianMonthOfYearHTTPEncoder new encode: anExpirationDate.
	self 
		getService: '/checkoutCart'
		withFields: 
			{'cartId' -> aCartId asString.
			'ccn' -> aCreditCardNumber.
			'cced' -> encodedCced.
			'cco' -> anOwner}
		onSuccessDoWithResponseContentMessageHandlingErrors: 
			[ :responseContent | ^responseContent ]! !

!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'EB 7/2/2019 21:22:00'!
getCreateCartWithClientId: aClientId andPassword: aPassword		
	self 
		getService: '/createCart' 
		withFields: {'clientId' -> aClientId. 'password' -> aPassword}
		onSuccessDoWithResponseContentMessageHandlingErrors: [ :contentMessage |
			^contentMessage asNumber ].! !

!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'EB 7/2/2019 23:41:49'!
getListCartWithId: aCartId
	self 
		getService: '/listCart' 
		withFields: {'cartId' -> aCartId asString}
		onSuccessDoWithResponseContentMessageHandlingErrors: [ :content |
			^self responseContentMessageToBookIsbnBag: content ]. ! !

!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'EB 7/7/2019 22:18:03'!
getListPrices
	self 
		getService: '/listPrices' 
		withFields: {} 
		onSuccessDoWithResponseContentMessageHandlingErrors: [ :contentMessage |
			^self responseContentMessageToBookIsbnDictionary: contentMessage.
		]
	! !

!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'EB 7/2/2019 23:41:24'!
getListPurchasesOfClientWithId: aClientId withPassword: aPassword 
	self 
		getService: '/listPurchases'
		withFields: {'clientId' -> aClientId. 'password' -> aPassword}
		onSuccessDoWithResponseContentMessageHandlingErrors: [ :contentMessage |
			^self responseContentMessageToBookIsbnBag: contentMessage ].! !

!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'EB 7/2/2019 14:57:34'!
getService: aService withFields: someFields
	self 
		getService: aService
		withFields: someFields
		onSuccessDoWithResponse: [ :response | ].! !

!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'EB 7/2/2019 14:57:34'!
getService: aService withFields: someFields onSuccessDoWithResponse: aBlock
	
	| response |
	
	response _ self
		htmlSubmitToService: aService fields: someFields. 
	
	self assertResponseCodeIs200: response.
	self assertResponseHasPositiveStatus: response.
	
	^aBlock value: response
	! !

!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'EB 7/2/2019 21:17:17'!
getService: aService 
withFields: someFields 
onSuccessDoWithResponseContentMessageHandlingErrors: aBlock
	self 
		getService: aService
		withFields: someFields
		onSuccessDoWithResponse: [ :response | | contentMessage |
			contentMessage _ self responseContentMessage: response content.
			[ aBlock value: contentMessage] 
				on: Error 
				do: [ self raiseBadResponseErrorForResponse: response ]
		].
		! !

!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'EB 7/2/2019 14:15:28'!
htmlSubmitToService: aServiceString fields: someFields
	^webClient htmlSubmit: url, aServiceString fields: someFields.! !


!TusLibrosWebClient methodsFor: 'parsing response content' stamp: 'EB 7/2/2019 21:11:15'!
assertResponseCodeIs200: aResponse
	aResponse code = 200 ifFalse: [
		self raiseBadResponseErrorForResponse: aResponse ].! !

!TusLibrosWebClient methodsFor: 'parsing response content' stamp: 'EB 7/2/2019 14:42:04'!
assertResponseHasPositiveStatus: aResponse
	
	| responseContent status |
	
	responseContent _ aResponse content.
	status _ self responseContentStatus: responseContent.
	status = $1 ifTrue: [ self error: (self responseContentMessage: responseContent) ].! !

!TusLibrosWebClient methodsFor: 'parsing response content' stamp: 'EB 7/2/2019 00:22:59'!
responseContentMessage: aResponseContent
	^aResponseContent copyFrom: 3 to: aResponseContent size! !

!TusLibrosWebClient methodsFor: 'parsing response content' stamp: 'EB 7/2/2019 23:40:58'!
responseContentMessageToBookIsbnBag: aResponseContentMessage
	
	| numbers |
	
	numbers _ aResponseContentMessage findTokens: '|'.
	^self stringCollectionToBookIsbnBag: numbers! !

!TusLibrosWebClient methodsFor: 'parsing response content' stamp: 'EB 7/7/2019 22:17:30'!
responseContentMessageToBookIsbnDictionary: aResponseContentMessage
	
	| numbers |
	
	numbers _ aResponseContentMessage findTokens: '|'.
	^self stringCollectionToBookIsbnDictionary: numbers! !

!TusLibrosWebClient methodsFor: 'parsing response content' stamp: 'EB 7/2/2019 01:06:57'!
responseContentStatus: aResponseContent 
	^aResponseContent first.! !

!TusLibrosWebClient methodsFor: 'parsing response content' stamp: 'EB 7/2/2019 21:28:12'!
stringCollectionToBookIsbnBag: aCollection
	
	| bag |
	
	aCollection size even ifFalse: [ self error ].
	
	bag _ Bag new.
	aCollection pairsDo: [ :element :quantity |
		bag add: element asNumber withOccurrences: quantity asNumber ].
	^bag
			! !

!TusLibrosWebClient methodsFor: 'parsing response content' stamp: 'EB 7/7/2019 22:16:09'!
stringCollectionToBookIsbnDictionary: aCollection
	
	| priceDictionary |
	
	aCollection size even ifFalse: [ self error ].
	
	priceDictionary _ Dictionary new.
	aCollection pairsDo: [ :bookIsbn :price |
		priceDictionary at: bookIsbn asNumber put: price asNumber ].
	^priceDictionary.! !


!TusLibrosWebClient methodsFor: 'error raising' stamp: 'EB 7/2/2019 21:10:27'!
raiseBadResponseErrorForResponse: aResponse
	self error: (self class badResponseErrorMessageForResponse: aResponse).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosWebClient class' category: #TusLibros!
TusLibrosWebClient class
	instanceVariableNames: ''!

!TusLibrosWebClient class methodsFor: 'instance creation' stamp: 'EB 7/2/2019 00:14:17'!
usingWebClient: aWebClient forUrl: anUrlString 
	^self new initializeUsingWebClient: aWebClient forUrl: anUrlString.! !


!TusLibrosWebClient class methodsFor: 'error messages' stamp: 'EB 7/2/2019 14:10:35'!
badResponseErrorMessageForResponse: aResponse 
	^'The server responded with error code ', aResponse code asString, ' and message: ''', aResponse content, ''''.! !


!classDefinition: #TusLibrosWebServer category: #TusLibros!
Object subclass: #TusLibrosWebServer
	instanceVariableNames: 'tusLibrosApi webServer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosWebServer methodsFor: 'initialization' stamp: 'EB 6/28/2019 13:42:21'!
initializeFor: aTusLibrosApi
	tusLibrosApi _ aTusLibrosApi.
	webServer _ WebServer new.
	
	self addTusLibrosApiServices.
	! !


!TusLibrosWebServer methodsFor: 'request handling' stamp: 'EB 6/28/2019 15:15:28'!
do: aBlock handlingFailureWithRequest: aRequest
	aBlock
		on: Error
		do: [ :error | self sendFailureResponse: error messageText withRequest: aRequest ].
	! !

!TusLibrosWebServer methodsFor: 'request handling' stamp: 'EB 6/29/2019 15:06:00'!
handleAddToCartRequest: aRequest
	
	| bookIsbn cartId quantity |
	
	quantity _ self getNumberField: 'bookQuantity' fromRequest: aRequest.
	bookIsbn _ self getNumberField: 'bookIsbn' fromRequest: aRequest.
	cartId _ self getNumberField: 'cartId' fromRequest: aRequest.
	
	self do: [ tusLibrosApi add: quantity ofBookWithIsbn: bookIsbn toCart: cartId ] 
		handlingFailureWithRequest: aRequest.
	
	self sendSuccessResponse: 'OK' withRequest: aRequest.! !

!TusLibrosWebServer methodsFor: 'request handling' stamp: 'EB 6/30/2019 19:17:06'!
handleCheckoutCartRequest: aRequest

	| cartId creditCard transactionId |

	cartId _ self getNumberField: 'cartId' fromRequest: aRequest.
	creditCard _ self getCreditCardFromRequest: aRequest.
	
	self 
		do: [ transactionId _ tusLibrosApi checkout: cartId withCreditCard: creditCard ] 
		handlingFailureWithRequest: aRequest.
	
	self sendSuccessResponse: transactionId asString withRequest: aRequest. ! !

!TusLibrosWebServer methodsFor: 'request handling' stamp: 'EB 6/29/2019 15:07:03'!
handleCreateCartRequest: aRequest

	| clientId password cartId |

	clientId _ self getStringField: 'clientId' fromRequest: aRequest.
	password _ self getStringField: 'password' fromRequest: aRequest.
	
	self do: [ cartId _ tusLibrosApi createCartWithClientId: clientId andPassword: password ]
		handlingFailureWithRequest: aRequest.
	
	self sendSuccessResponse: cartId asString withRequest: aRequest.! !

!TusLibrosWebServer methodsFor: 'request handling' stamp: 'EB 7/1/2019 02:02:51'!
handleListCartRequest: aRequest

	| cartId contents contentsString |
	
	cartId _ self getNumberField: 'cartId' fromRequest: aRequest.
	
	self do: [ contents _ tusLibrosApi listCart: cartId ]
		handlingFailureWithRequest: aRequest.
	
	contentsString _ self parseBagContents: contents.
	
	self sendSuccessResponse: contentsString withRequest: aRequest.! !

!TusLibrosWebServer methodsFor: 'request handling' stamp: 'EB 7/1/2019 13:38:55'!
handleListPricesRequest: aRequest
	
	| prices contentString contentCollection |
	
	prices _ tusLibrosApi listPrices.
	
	contentCollection _ OrderedCollection new.
	prices keysAndValuesDo: [ :bookIsbn :price |
		contentCollection add: bookIsbn.
		contentCollection add: price ].
	
	contentString _ self joinWithPipes: contentCollection.
	
	self sendSuccessResponse: contentString withRequest: aRequest ! !

!TusLibrosWebServer methodsFor: 'request handling' stamp: 'EB 7/1/2019 02:09:48'!
handleListPurchasesRequest: aRequest
	
	| clientId password purchases contentsString |
	
	clientId _ self getStringField: 'clientId' fromRequest: aRequest.
	password _ self getStringField: 'password' fromRequest: aRequest.
	
	self
		do: [ purchases _ tusLibrosApi listPurchasesOfClient: clientId withPassword: password ]
		 handlingFailureWithRequest: aRequest.
	
	contentsString _ self parseClientPurchases: purchases.
	
	self sendSuccessResponse: contentsString withRequest: aRequest.! !


!TusLibrosWebServer methodsFor: 'listening' stamp: 'EB 6/28/2019 13:21:11'!
listenOn: aPortNumber
	webServer listenOn: aPortNumber.! !


!TusLibrosWebServer methodsFor: 'destroying' stamp: 'EB 6/28/2019 13:24:06'!
destroy
	webServer destroy.! !


!TusLibrosWebServer methodsFor: 'adding services' stamp: 'EB 6/28/2019 13:36:16'!
addService: aServiceString actionSelector: aSelector
	webServer addService: aServiceString action:
		(MessageSend receiver: self selector: aSelector).
	! !

!TusLibrosWebServer methodsFor: 'adding services' stamp: 'EB 7/1/2019 13:24:30'!
addTusLibrosApiServices
	self addService: '/createCart' actionSelector: #handleCreateCartRequest:.
	self addService: '/listCart' actionSelector: #handleListCartRequest:.
	self addService: '/addToCart' actionSelector: #handleAddToCartRequest:.
	self addService: '/checkoutCart' actionSelector: #handleCheckoutCartRequest:.
	self addService: '/listPurchases' actionSelector: #handleListPurchasesRequest:.
	self addService: '/listPrices' actionSelector: #handleListPricesRequest:.! !


!TusLibrosWebServer methodsFor: 'responding' stamp: 'EB 6/28/2019 13:32:06'!
sendFailureResponse: aResponseContent withRequest: aRequest
	self 
		sendResponse: aResponseContent 
		withStatus: '1' 
		withRequest: aRequest! !

!TusLibrosWebServer methodsFor: 'responding' stamp: 'EB 6/28/2019 13:55:05'!
sendInvalidUserCredentialsFailureResponseWithRequest: aRequest
	self 
		sendFailureResponse: self class invalidUserCredentialsErrorMessage 
		withRequest: aRequest! !

!TusLibrosWebServer methodsFor: 'responding' stamp: 'EB 6/28/2019 13:32:32'!
sendResponse: aResponseContent 
withStatus: aResponseStatus 
withRequest: aRequest

	aRequest send200Response: aResponseStatus, '|', aResponseContent.! !

!TusLibrosWebServer methodsFor: 'responding' stamp: 'EB 6/28/2019 13:32:17'!
sendSuccessResponse: aResponseContent withRequest: aRequest
	self 
		sendResponse: aResponseContent 
		withStatus: '0'
		withRequest: aRequest! !


!TusLibrosWebServer methodsFor: 'parsing return values' stamp: 'EB 7/1/2019 13:37:11'!
joinWithPipes: aCollection
	
	| joined |
	
	joined _ aCollection inject: '' into: [ :acum :element | acum, '|', element asString ].
	joined ifNotEmpty: [ joined _ joined allButFirst ].
	^joined! !

!TusLibrosWebServer methodsFor: 'parsing return values' stamp: 'EB 7/1/2019 13:36:26'!
parseBagContents: aBag
	
	| contentsCollection |
	
	contentsCollection _ OrderedCollection new.
	aBag sortedElements do: [ :element |
		contentsCollection add: element key.
		contentsCollection add: element value ].
		
	^self joinWithPipes: contentsCollection.! !

!TusLibrosWebServer methodsFor: 'parsing return values' stamp: 'EB 7/1/2019 02:05:02'!
parseClientPurchases: aClientPurchases
	
	| contentsString |
	
	contentsString _ self parseBagContents: aClientPurchases amountPerBook.
	contentsString ifNotEmpty: [ contentsString _ contentsString, '|' ]. 
	^contentsString, aClientPurchases totalAmount asString.! !


!TusLibrosWebServer methodsFor: 'parsing request' stamp: 'EB 6/29/2019 16:07:30'!
do: aBlock onErrorSend400ResponseWith: aRequest
	aBlock on: Error do: [ ^aRequest send400Response ].! !

!TusLibrosWebServer methodsFor: 'parsing request' stamp: 'EB 6/30/2019 22:47:32'!
getCreditCardFromRequest: aRequest
	
	| creditCardExpirationDate creditCardOwner creditCartNumber |
	
	creditCartNumber _ self getStringField: 'ccn' fromRequest: aRequest.
	creditCardOwner _ self getStringField: 'cco' fromRequest: aRequest.
	creditCardExpirationDate _ self getMonthOfYearField: 'cced' fromRequest: aRequest.
	
	self
		do: [
			^CreditCard 
				numbered: creditCartNumber
				withOwner: creditCardOwner
				andExpiration: creditCardExpirationDate ]
		onErrorSend400ResponseWith: aRequest.! !

!TusLibrosWebServer methodsFor: 'parsing request' stamp: 'EB 6/30/2019 23:18:02'!
getMonthOfYearField: aFieldName fromRequest: aRequest
	
	| monthOfYearString |
	
	monthOfYearString _ self getStringField: aFieldName fromRequest: aRequest.
	self do: [ ^GregorianMonthOfYearHTTPDecoder new decode: monthOfYearString ]
		onErrorSend400ResponseWith: aRequest.! !

!TusLibrosWebServer methodsFor: 'parsing request' stamp: 'EB 6/29/2019 16:09:05'!
getNumberField: aFieldName fromRequest: aRequest
	
	| field |
	
	field _ self getStringField: aFieldName fromRequest: aRequest.
	self 
		do: [ ^field asNumber ]
		onErrorSend400ResponseWith: aRequest.! !

!TusLibrosWebServer methodsFor: 'parsing request' stamp: 'EB 6/29/2019 16:09:40'!
getStringField: aFieldName fromRequest: aRequest

	^self
		do: [ ^aRequest fields at: aFieldName ]
		onErrorSend400ResponseWith: aRequest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosWebServer class' category: #TusLibros!
TusLibrosWebServer class
	instanceVariableNames: ''!

!TusLibrosWebServer class methodsFor: 'instance creation' stamp: 'EB 7/7/2019 20:48:07'!
example

	| api authenticator priceList |

	priceList _ {1 -> 23. 34 -> 42. 69 -> 420. 90 -> 1234} asDictionary.
	authenticator _ CredentialsDictionaryUserAuthenticator 
		withRegisteredCredentials: {'admin' -> 'admin'} asDictionary.

	api _ TusLibrosApi 
		authenticatingWith: authenticator
		debitingFrom: MerchantProcessorForTesting new
		withPriceList: priceList
		andClock: GregorianDateTime. 

	^TusLibrosWebServer for: api listeningOn: 8000.! !

!TusLibrosWebServer class methodsFor: 'instance creation' stamp: 'EB 6/28/2019 13:22:30'!
for: aTusLibrosApi listeningOn: aPortNumber 

	| instance |
	
	instance _ self new initializeFor: aTusLibrosApi.
	instance listenOn: aPortNumber.
	
	^instance! !


!TusLibrosWebServer class methodsFor: 'error messages' stamp: 'EB 6/28/2019 13:00:00'!
invalidUserCredentialsErrorMessage
	^TusLibrosApi  invalidUserCredentialsErrorMessage.! !
