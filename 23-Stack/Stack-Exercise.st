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


!classDefinition: #Element category: #'Stack-Exercise'!
Object subclass: #Element
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Element methodsFor: 'evaluation' stamp: 'EB 4/17/2019 02:17:21'!
isNullElement
	self subclassResponsibility.! !


!Element methodsFor: 'accessing' stamp: 'EB 4/17/2019 02:25:08'!
previous
	self subclassResponsibility.! !

!Element methodsFor: 'accessing' stamp: 'EB 4/17/2019 02:27:30'!
value
	self subclassResponsibility.! !


!classDefinition: #NullElement category: #'Stack-Exercise'!
Element subclass: #NullElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NullElement methodsFor: 'evaluation' stamp: 'EB 4/17/2019 02:15:29'!
isNullElement
	^true! !


!NullElement methodsFor: 'accessing' stamp: 'EB 4/17/2019 02:31:40'!
previous
	OOStack raiseEmptyError.! !

!NullElement methodsFor: 'accessing' stamp: 'EB 4/17/2019 02:31:48'!
value
	OOStack raiseEmptyError.! !


!classDefinition: #ValueElement category: #'Stack-Exercise'!
Element subclass: #ValueElement
	instanceVariableNames: 'value previous'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ValueElement methodsFor: 'initialization' stamp: 'EB 4/17/2019 02:13:48'!
initializeWithValue: aValue andPrevious: previousElement
	value _ aValue.
	previous _ previousElement.! !


!ValueElement methodsFor: 'evaluation' stamp: 'EB 4/17/2019 02:16:05'!
isNullElement
	^false.! !


!ValueElement methodsFor: 'accessing' stamp: 'EB 4/17/2019 02:18:08'!
previous
	^previous! !

!ValueElement methodsFor: 'accessing' stamp: 'EB 4/17/2019 02:19:30'!
value
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ValueElement class' category: #'Stack-Exercise'!
ValueElement class
	instanceVariableNames: ''!

!ValueElement class methodsFor: 'instantiation' stamp: 'EB 4/17/2019 02:13:00'!
withValue: aValue andPrevious: previousElement
	^self new initializeWithValue: aValue andPrevious: previousElement.! !


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

!OOStack methodsFor: 'modification' stamp: 'EB 4/17/2019 02:21:21'!
push: value
	lastElement _ ValueElement withValue: value andPrevious: lastElement.
	elementQuantity _ elementQuantity + 1.! !


!OOStack methodsFor: 'initialization' stamp: 'EB 4/17/2019 02:23:59'!
initialize
	lastElement _ NullElement new.
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


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
