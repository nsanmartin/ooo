!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position orientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initializing' stamp: 'EB 5/7/2019 18:55:28'!
initializeWithOrigin: originPoint andOrientation: orientationPoint 
	position _ originPoint.
	(self class isValidOrientationPoint: orientationPoint) ifFalse: [
		self error: self class invalidOrientationExceptionDescription.
	].
	orientation _ orientationPoint.! !


!MarsRover methodsFor: 'accessing' stamp: 'EB 5/7/2019 16:37:02'!
orientation
	^orientation! !

!MarsRover methodsFor: 'accessing' stamp: 'EB 5/7/2019 16:36:53'!
position
	^position! !


!MarsRover methodsFor: 'executing commands' stamp: 'EB 5/7/2019 18:07:35'!
addToPosition: translation
	position _ position + translation.! !

!MarsRover methodsFor: 'executing commands' stamp: 'EB 5/7/2019 18:27:32'!
execute: commands 	
	commands do: [ :command|
		self executeCommand: command.
	].! !

!MarsRover methodsFor: 'executing commands' stamp: 'EB 5/7/2019 18:26:54'!
executeCommand: commandCharacter
	| commandExecutors executor |
	commandExecutors _ {
		$r -> [self rotateRight].
		$l -> [self rotateLeft].
		$f -> [self moveForward].
		$b -> [self moveBackward].
	} asDictionary.
	executor _ commandExecutors at: commandCharacter ifAbsent: [
		self raiseInvalidOperationError.
	].
	executor value.! !

!MarsRover methodsFor: 'executing commands' stamp: 'EB 5/7/2019 18:09:10'!
moveBackward
	self addToPosition: orientation negated.! !

!MarsRover methodsFor: 'executing commands' stamp: 'EB 5/7/2019 18:09:02'!
moveForward
	self addToPosition: orientation.! !

!MarsRover methodsFor: 'executing commands' stamp: 'EB 5/7/2019 18:01:50'!
rotateLeft
	self transposeOrientationAndMultiplyBy: (-1 @ 1).! !

!MarsRover methodsFor: 'executing commands' stamp: 'EB 5/7/2019 18:01:33'!
rotateRight
	self transposeOrientationAndMultiplyBy: (1 @ -1).! !

!MarsRover methodsFor: 'executing commands' stamp: 'EB 5/7/2019 18:01:33'!
transposeOrientationAndMultiplyBy: aPoint
	orientation _ orientation transposed * aPoint.! !


!MarsRover methodsFor: 'exceptions' stamp: 'EB 5/7/2019 16:56:49'!
raiseInvalidOperationError
	self error: self class invalidOperationExceptionDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'EB 5/7/2019 16:36:41'!
withOrigin: originPoint andOrientation: orientationPoint 
	^self new initializeWithOrigin: originPoint andOrientation: orientationPoint! !


!MarsRover class methodsFor: 'exception descriptions' stamp: 'EB 5/7/2019 16:53:06'!
invalidOperationExceptionDescription
	^'Operation is not valid'. ! !

!MarsRover class methodsFor: 'exception descriptions' stamp: 'EB 5/7/2019 18:36:26'!
invalidOrientationExceptionDescription
	^'This orientation is not supported'.! !


!MarsRover class methodsFor: 'orientation validity' stamp: 'EB 5/7/2019 18:53:43'!
isValidOrientationPoint: anOrientationPoint
	^{0 @ 1. 1 @ 0. 0 @ -1. -1 @ 0.} includes: anOrientationPoint.! !
