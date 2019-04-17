!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'EB 4/17/2019 14:00:21'!
test01ShouldFindNoneWhenStackIsEmpty
	self assertFinderWithElements: OrderedCollection new 
		andPrefix: 'Wint' 
		finds: OrderedCollection new.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'EB 4/17/2019 14:01:56'!
test02ShouldFindNoneWhenNoneHasPrefix
	| elements |
	elements _ OrderedCollection with: 'hola' with: 'chau'.
	self assertFinderWithElements: elements 
		andPrefix: 'como estas' 
		finds: OrderedCollection new.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'EB 4/17/2019 14:02:45'!
test03ShouldFindWithOneElementInStack
	| elements |
	elements _ OrderedCollection with: 'hola'.
	self assertFinderWithElements: elements 
		andPrefix: 'hol' 
		finds: elements. ! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'EB 4/17/2019 14:03:44'!
test04ShouldFindWhenAllHavePrefix
	| elements |
	elements _ OrderedCollection with: 'Wint' with: 'Winter' with: 'WintWint'.
	self assertFinderWithElements: elements 
		andPrefix: 'Wint' 
		finds: elements. 
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'EB 4/17/2019 14:04:45'!
test05DoesNotModifyStackWhenFinding
	| finder stack stringsInStack |
	stringsInStack _ OrderedCollection with: 'hola' with: 'chau'.
	stack _ self stackWith: stringsInStack.
	
	finder _ SentenceFinderByPrefix withStack: stack.
	finder find: 'cha'.
	stringsInStack reverseDo: [ :string |
		self assert: string equals: stack top.
		stack pop.
	].! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'EB 4/17/2019 14:05:30'!
test06ShouldFindWhenSomeHavePrefix
	| elements elementsExpected |
	elements _ OrderedCollection with: 'hola' with: 'chau' with: 'chacachaca'.
	elementsExpected _ OrderedCollection with: 'chau' with: 'chacachaca'.
	self assertFinderWithElements: elements andPrefix: 'cha' finds: elementsExpected.
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'EB 4/17/2019 14:06:13'!
test07FindingIsCaseSensitive
	| elements elementsExpected |
	elements _ OrderedCollection with: 'hola' with: 'Hola' with: 'holache' with: 'Holhol'.
	elementsExpected _ OrderedCollection with: 'hola' with: 'holache'.
	self assertFinderWithElements: elements andPrefix: 'hol' finds: elementsExpected.
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'EB 4/17/2019 14:19:13'!
test08CanFindMoreThanOnce
	| elements elementsExpected finder |
	elements _ OrderedCollection with: 'hol' with: 'chau' with: 'holes' with: 'chauches'.
	finder _ self finderWithStackWithElements: elements.
	
	elementsExpected _ OrderedCollection with: 'hol' with: 'holes'.
	self assertFinder: finder withPrefix: 'hol' finds: elementsExpected.
	
	elementsExpected _ OrderedCollection with: 'chau' with: 'chauches'.
	self assertFinder: finder withPrefix: 'chau' finds: elementsExpected.
	
	elementsExpected _ OrderedCollection with: 'holes'.
	self assertFinder: finder withPrefix: 'hole' finds: elementsExpected.
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'EB 4/17/2019 14:33:12'!
test09ShouldFindAllWithEmptyPrefix
	| elements |
	elements _ OrderedCollection with: 'hola' with: 'Hljals' with: '' with: 'lakjsd'.
	self assertFinderWithElements: elements
		andPrefix: ''
		finds: elements.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'EB 4/17/2019 14:35:47'!
test10ShouldFindRepeatedStrings
	| elements |
	elements _ OrderedCollection with: 'hola' with: 'hola' with: 'hola'.
	self assertFinderWithElements: elements
		andPrefix: 'hol'
		finds: elements.! !


!SentenceFinderByPrefixTest methodsFor: 'stack utilities' stamp: 'EB 4/17/2019 13:52:20'!
stackWith: elements
	| stack |
	stack _ OOStack new.
	elements do: [ :element |
		stack push: element.
	].
	^stack.! !


!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'EB 4/17/2019 14:13:04'!
assertFinder: aFinder withPrefix: aPrefix finds: elementsToFind
	| found |
	found _ aFinder find: aPrefix.
	self assert: elementsToFind equals: found.	 ! !

!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'EB 4/17/2019 14:16:27'!
assertFinderWithElements: elementsInStack andPrefix: aPrefix finds: elementsToFind
	| finder |
	finder _ self finderWithStackWithElements: elementsInStack.
	self assertFinder: finder withPrefix: aPrefix finds: elementsToFind.! !


!SentenceFinderByPrefixTest methodsFor: 'finder utilities' stamp: 'EB 4/17/2019 14:15:52'!
finderWithStackWithElements: elementsInStack
	| stack |
	stack _ self stackWith: elementsInStack. 
	^SentenceFinderByPrefix withStack: stack.! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'lastElement elementQuantity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'evaluation' stamp: 'EB 4/17/2019 02:15:02'!
isEmpty
	^lastElement isNullElement.! !

!OOStack methodsFor: 'evaluation' stamp: 'EB 4/17/2019 02:23:49'!
size
	^elementQuantity.! !


!OOStack methodsFor: 'modification' stamp: 'EB 4/17/2019 02:23:13'!
pop
	| poppedValue |
	poppedValue _ lastElement value.
	lastElement _ lastElement previous.
	elementQuantity _ elementQuantity - 1.
	^poppedValue! !

!OOStack methodsFor: 'modification' stamp: 'EB 4/17/2019 12:52:14'!
push: value
	lastElement _ ValueOOStackElement withValue: value andPrevious: lastElement.
	elementQuantity _ elementQuantity + 1.! !


!OOStack methodsFor: 'initialization' stamp: 'EB 4/17/2019 12:51:57'!
initialize
	lastElement _ NullOOStackElement new.
	elementQuantity _ 0.! !


!OOStack methodsFor: 'accessing' stamp: 'EB 4/17/2019 02:20:15'!
top
	^lastElement value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!OOStack class methodsFor: 'error raising' stamp: 'EB 4/17/2019 02:31:20'!
raiseEmptyError
	self error: self stackEmptyErrorDescription.! !


!classDefinition: #OOStackElement category: #'Stack-Exercise'!
Object subclass: #OOStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'evaluation' stamp: 'EB 4/17/2019 02:17:21'!
isNullElement
	self subclassResponsibility.! !


!OOStackElement methodsFor: 'accessing' stamp: 'EB 4/17/2019 02:25:08'!
previous
	self subclassResponsibility.! !

!OOStackElement methodsFor: 'accessing' stamp: 'EB 4/17/2019 02:27:30'!
value
	self subclassResponsibility.! !


!classDefinition: #NullOOStackElement category: #'Stack-Exercise'!
OOStackElement subclass: #NullOOStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NullOOStackElement methodsFor: 'evaluation' stamp: 'EB 4/17/2019 02:15:29'!
isNullElement
	^true! !


!NullOOStackElement methodsFor: 'accessing' stamp: 'EB 4/17/2019 02:31:40'!
previous
	OOStack raiseEmptyError.! !

!NullOOStackElement methodsFor: 'accessing' stamp: 'EB 4/17/2019 02:31:48'!
value
	OOStack raiseEmptyError.! !


!classDefinition: #ValueOOStackElement category: #'Stack-Exercise'!
OOStackElement subclass: #ValueOOStackElement
	instanceVariableNames: 'value previous'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ValueOOStackElement methodsFor: 'initialization' stamp: 'EB 4/17/2019 02:13:48'!
initializeWithValue: aValue andPrevious: previousElement
	value _ aValue.
	previous _ previousElement.! !


!ValueOOStackElement methodsFor: 'evaluation' stamp: 'EB 4/17/2019 02:16:05'!
isNullElement
	^false.! !


!ValueOOStackElement methodsFor: 'accessing' stamp: 'EB 4/17/2019 02:18:08'!
previous
	^previous! !

!ValueOOStackElement methodsFor: 'accessing' stamp: 'EB 4/17/2019 02:19:30'!
value
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ValueOOStackElement class' category: #'Stack-Exercise'!
ValueOOStackElement class
	instanceVariableNames: ''!

!ValueOOStackElement class methodsFor: 'instantiation' stamp: 'EB 4/17/2019 02:13:00'!
withValue: aValue andPrevious: previousElement
	^self new initializeWithValue: aValue andPrevious: previousElement.! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'EB 4/17/2019 13:00:36'!
initializeWithStack: anOOStack 
	stack _ anOOStack.! !


!SentenceFinderByPrefix methodsFor: 'finding' stamp: 'EB 4/17/2019 13:51:12'!
find: aPrefix
	| stackElements |
	stackElements _ self stackToOrderedCollection: stack.
	^stackElements select: [ :element | element beginsWith: aPrefix.].
	! !


!SentenceFinderByPrefix methodsFor: 'stack utilities' stamp: 'EB 4/17/2019 13:43:25'!
stackToOrderedCollection: aStack
	| stackElements |
	stackElements _ OrderedCollection new.
	[stack isEmpty] whileFalse: [
		stackElements addFirst: stack pop.
	].
	stackElements do: [ :element | stack push: element].
	^stackElements.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'instantiation' stamp: 'EB 4/17/2019 13:01:08'!
withStack: anOOStack
	^self new initializeWithStack: anOOStack.! !
