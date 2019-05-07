!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'x y orientation position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'EB 5/7/2019 15:11:57'!
initializeWithOrigin: anOriginPoint andOrientation: anOrientation 
	orientation _ anOrientation.
	position _ anOriginPoint.
! !


!MarsRover methodsFor: 'accessing' stamp: 'EB 5/7/2019 15:30:31'!
orientationSymbol
	^orientation asSymbol.! !

!MarsRover methodsFor: 'accessing' stamp: 'EB 5/6/2019 20:33:04'!
position
	^position! !


!MarsRover methodsFor: 'moving' stamp: 'EB 5/7/2019 15:27:29'!
move: aString
	| operationExecutors |
	operationExecutors _ {
		$l -> [self rotateLeft.].
		$r -> [self rotateRight.].
		$f -> [self moveForward.].
		$b -> [self moveBackward.].
	} asDictionary.
	aString do: [ :character | | executor |
		executor _ operationExecutors at: character ifAbsent: [
			self raiseInvalidOperationException.
		].
		executor value.
	].
	
 	
	! !

!MarsRover methodsFor: 'moving' stamp: 'EB 5/7/2019 00:52:20'!
moveBackward
	position _ orientation moveBackward: position.! !

!MarsRover methodsFor: 'moving' stamp: 'EB 5/7/2019 00:51:29'!
moveForward
	position _ orientation moveForward: position.! !

!MarsRover methodsFor: 'moving' stamp: 'EB 5/7/2019 00:59:49'!
rotateLeft
	orientation _ orientation rotateLeft.! !

!MarsRover methodsFor: 'moving' stamp: 'EB 5/7/2019 00:50:41'!
rotateRight
	orientation _ orientation rotateRight.! !


!MarsRover methodsFor: 'exceptions' stamp: 'EB 5/7/2019 15:29:19'!
raiseInvalidOperationException
	self error: self class invalidOperationExceptionDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'creation' stamp: 'EB 5/6/2019 20:31:23'!
withOrigin: aPoint andOrientation: aSymbol 
	^self new initializeWithOrigin: aPoint andOrientation: aSymbol.! !


!MarsRover class methodsFor: 'error descriptions' stamp: 'EB 5/7/2019 13:24:25'!
invalidOperationExceptionDescription
	^'Invalid operation'.! !


!classDefinition: #MarsRoverOrientation category: #MarsRover!
Object subclass: #MarsRoverOrientation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!


!MarsRoverOrientation methodsFor: 'converting' stamp: 'EB 5/7/2019 00:15:31'!
asSymbol
	self subclassResponsibility.! !


!MarsRoverOrientation methodsFor: 'moving' stamp: 'EB 5/7/2019 00:52:06'!
moveBackward: position
	^position - self forwardUnit.! !

!MarsRoverOrientation methodsFor: 'moving' stamp: 'EB 5/7/2019 00:51:45'!
moveForward: position
	^position + self forwardUnit.! !

!MarsRoverOrientation methodsFor: 'moving' stamp: 'EB 5/7/2019 15:09:14'!
rotateLeft
	^self leftRotationClass new.! !

!MarsRoverOrientation methodsFor: 'moving' stamp: 'EB 5/7/2019 15:09:19'!
rotateRight
	^self rightRotationClass new.! !


!MarsRoverOrientation methodsFor: 'accessing' stamp: 'EB 5/7/2019 00:28:04'!
forwardUnit
	self subclassResponsibility.! !

!MarsRoverOrientation methodsFor: 'accessing' stamp: 'EB 5/7/2019 01:02:25'!
leftRotationClass
	self subclassResponsibility.! !

!MarsRoverOrientation methodsFor: 'accessing' stamp: 'EB 5/7/2019 00:48:37'!
rightRotationClass
	self subclassResponsibility.! !


!classDefinition: #EastMarsRoverOrientation category: #MarsRover!
MarsRoverOrientation subclass: #EastMarsRoverOrientation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!EastMarsRoverOrientation methodsFor: 'converting' stamp: 'EB 5/7/2019 00:16:08'!
asSymbol
	^#East.! !


!EastMarsRoverOrientation methodsFor: 'accessing' stamp: 'EB 5/7/2019 00:29:39'!
forwardUnit
	^1 @ 0.! !

!EastMarsRoverOrientation methodsFor: 'accessing' stamp: 'EB 5/7/2019 01:03:24'!
leftRotationClass
	^NorthMarsRoverOrientation.! !

!EastMarsRoverOrientation methodsFor: 'accessing' stamp: 'EB 5/7/2019 00:49:14'!
rightRotationClass
	^SouthMarsRoverOrientation.! !


!classDefinition: #NorthMarsRoverOrientation category: #MarsRover!
MarsRoverOrientation subclass: #NorthMarsRoverOrientation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!NorthMarsRoverOrientation methodsFor: 'converting' stamp: 'EB 5/7/2019 00:16:46'!
asSymbol
	^#North.! !


!NorthMarsRoverOrientation methodsFor: 'accessing' stamp: 'EB 5/7/2019 00:29:05'!
forwardUnit
	^0 @ 1.! !

!NorthMarsRoverOrientation methodsFor: 'accessing' stamp: 'EB 5/7/2019 01:02:54'!
leftRotationClass
	^WestMarsRoverOrientation.! !

!NorthMarsRoverOrientation methodsFor: 'accessing' stamp: 'EB 5/7/2019 00:49:33'!
rightRotationClass
	^EastMarsRoverOrientation.! !


!classDefinition: #SouthMarsRoverOrientation category: #MarsRover!
MarsRoverOrientation subclass: #SouthMarsRoverOrientation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!SouthMarsRoverOrientation methodsFor: 'converting' stamp: 'EB 5/7/2019 00:17:14'!
asSymbol
	^#South.! !


!SouthMarsRoverOrientation methodsFor: 'accessing' stamp: 'EB 5/7/2019 00:29:21'!
forwardUnit
	^0 @ -1.! !

!SouthMarsRoverOrientation methodsFor: 'accessing' stamp: 'EB 5/7/2019 01:03:55'!
leftRotationClass
	^EastMarsRoverOrientation.! !

!SouthMarsRoverOrientation methodsFor: 'accessing' stamp: 'EB 5/7/2019 00:49:56'!
rightRotationClass
	^WestMarsRoverOrientation.! !


!classDefinition: #WestMarsRoverOrientation category: #MarsRover!
MarsRoverOrientation subclass: #WestMarsRoverOrientation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!WestMarsRoverOrientation methodsFor: 'converting' stamp: 'EB 5/7/2019 00:17:26'!
asSymbol
	^#West.! !


!WestMarsRoverOrientation methodsFor: 'accessing' stamp: 'EB 5/7/2019 00:35:13'!
forwardUnit
	^-1 @ 0.! !

!WestMarsRoverOrientation methodsFor: 'accessing' stamp: 'EB 5/7/2019 01:04:07'!
leftRotationClass
	^SouthMarsRoverOrientation.! !

!WestMarsRoverOrientation methodsFor: 'accessing' stamp: 'EB 5/7/2019 00:50:06'!
rightRotationClass
	^NorthMarsRoverOrientation.! !
