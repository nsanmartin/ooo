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
