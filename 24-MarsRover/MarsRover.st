!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position orientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'EB 5/12/2019 18:19:12'!
initializeWithPosition: aPosition andOrientation: anOrientation 
	position _ aPosition.
	orientation _ anOrientation.! !


!MarsRover methodsFor: 'accessing' stamp: 'EB 5/12/2019 18:19:38'!
orientation
	^orientation! !

!MarsRover methodsFor: 'accessing' stamp: 'EB 5/12/2019 18:17:38'!
position
	^position! !


!MarsRover methodsFor: 'executing' stamp: 'EB 5/12/2019 19:43:20'!
execute: someCommands
	someCommands do: [ :command |
		self executeCommand: command.
	].! !

!MarsRover methodsFor: 'executing' stamp: 'EB 5/12/2019 19:50:21'!
executeCommand: aCommand
	| commandExecutors executorMessage |
	commandExecutors _ {
		$f -> #moveForward.
		$b -> #moveBackward.
		$l -> #rotateLeft.
		$r -> #rotateRight.
	} asDictionary.
	executorMessage _ commandExecutors at: aCommand ifAbsent: [
		self error: self class invalidCommandExceptionMessage.
	].
	executorMessage asMessage sendTo: self.! !

!MarsRover methodsFor: 'executing' stamp: 'EB 5/12/2019 20:29:37'!
moveBackward
	position _ position - orientation forwardVector.! !

!MarsRover methodsFor: 'executing' stamp: 'EB 5/12/2019 20:29:32'!
moveForward
	position _ position + orientation forwardVector.	! !

!MarsRover methodsFor: 'executing' stamp: 'EB 5/12/2019 20:29:50'!
rotateLeft
	orientation _ orientation leftRotated.! !

!MarsRover methodsFor: 'executing' stamp: 'EB 5/12/2019 20:29:56'!
rotateRight
	orientation _ orientation rightRotated.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'EB 5/12/2019 18:11:32'!
withPosition: aPosition andOrientation: anOrientation 
	^self new initializeWithPosition: aPosition andOrientation: anOrientation.! !


!MarsRover class methodsFor: 'exception messages' stamp: 'EB 5/12/2019 19:39:38'!
invalidCommandExceptionMessage
	^'The command is invalid.'! !


!classDefinition: #MarsRoverOrientation category: #MarsRover!
Object subclass: #MarsRoverOrientation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverOrientation methodsFor: 'comparing' stamp: 'EB 5/12/2019 20:08:42'!
= anObject
	^anObject class = self class.! !


!MarsRoverOrientation methodsFor: 'accessing' stamp: 'EB 5/12/2019 20:10:25'!
forwardVector
	self subclassResponsibility.! !


!MarsRoverOrientation methodsFor: 'rotating' stamp: 'EB 5/12/2019 20:26:13'!
leftRotated
	self subclassResponsibility.! !

!MarsRoverOrientation methodsFor: 'rotating' stamp: 'EB 5/12/2019 20:14:49'!
rightRotated
	self subclassResponsibility.! !


!classDefinition: #EastMarsRoverOrientation category: #MarsRover!
MarsRoverOrientation subclass: #EastMarsRoverOrientation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!EastMarsRoverOrientation methodsFor: 'accessing' stamp: 'EB 5/12/2019 20:10:43'!
forwardVector
	^1 @ 0.! !


!EastMarsRoverOrientation methodsFor: 'rotating' stamp: 'EB 5/12/2019 20:28:14'!
leftRotated
	^NorthMarsRoverOrientation new.! !

!EastMarsRoverOrientation methodsFor: 'rotating' stamp: 'EB 5/12/2019 20:21:50'!
rightRotated
	^ SouthMarsRoverOrientation new.! !


!classDefinition: #NorthMarsRoverOrientation category: #MarsRover!
MarsRoverOrientation subclass: #NorthMarsRoverOrientation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!NorthMarsRoverOrientation methodsFor: 'accessing' stamp: 'EB 5/12/2019 19:59:33'!
forwardVector
	^ 0 @ 1.! !


!NorthMarsRoverOrientation methodsFor: 'rotating' stamp: 'EB 5/12/2019 20:03:56'!
leftRotated
	^WestMarsRoverOrientation new.! !

!NorthMarsRoverOrientation methodsFor: 'rotating' stamp: 'EB 5/12/2019 20:06:50'!
rightRotated
	^EastMarsRoverOrientation new.! !


!classDefinition: #SouthMarsRoverOrientation category: #MarsRover!
MarsRoverOrientation subclass: #SouthMarsRoverOrientation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!SouthMarsRoverOrientation methodsFor: 'accessing' stamp: 'EB 5/12/2019 20:12:10'!
forwardVector
	^NorthMarsRoverOrientation new forwardVector negated.! !


!SouthMarsRoverOrientation methodsFor: 'rotating' stamp: 'EB 5/12/2019 20:26:30'!
leftRotated
	^EastMarsRoverOrientation new.! !

!SouthMarsRoverOrientation methodsFor: 'rotating' stamp: 'EB 5/12/2019 20:24:54'!
rightRotated
	^WestMarsRoverOrientation new.! !


!classDefinition: #WestMarsRoverOrientation category: #MarsRover!
MarsRoverOrientation subclass: #WestMarsRoverOrientation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!WestMarsRoverOrientation methodsFor: 'accessing' stamp: 'EB 5/12/2019 20:13:21'!
forwardVector
	^-1 @ 0.! !


!WestMarsRoverOrientation methodsFor: 'rotating' stamp: 'EB 5/12/2019 20:27:20'!
leftRotated
	^SouthMarsRoverOrientation new.! !

!WestMarsRoverOrientation methodsFor: 'rotating' stamp: 'EB 5/12/2019 20:25:30'!
rightRotated
	^NorthMarsRoverOrientation new.! !
