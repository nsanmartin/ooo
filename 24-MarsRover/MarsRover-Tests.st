!classDefinition: #MarsRoverTest category: #'MarsRover-Tests'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Tests'!

!MarsRoverTest methodsFor: 'tests' stamp: 'EB 5/12/2019 20:31:59'!
test01StartsWithProvidedValues
	| origen rovie orientacion |
	origen _ 0 @ 0.
	orientacion _ NorthMarsRoverOrientation new.
	rovie _ MarsRover withPosition: origen andOrientation: orientacion.
	
	self assert: origen equals: rovie position.
	self assert: orientacion equals: rovie orientation.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'EB 5/12/2019 19:54:36'!
test02EmptyCommandString
	| origen rovie orientacion |
	origen _ 0 @ 0.
	orientacion _ NorthMarsRoverOrientation new.
	rovie _ MarsRover withPosition: origen andOrientation: orientacion.
	
	rovie execute: ''.
	
	self assert: origen equals: rovie position.
	self assert: orientacion equals: rovie orientation.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'EB 5/12/2019 20:32:57'!
test03GoForwardFacingNorth
	| origen rovie orientacion |
	origen _ 0 @ 0.
	orientacion _ NorthMarsRoverOrientation new.
	rovie _ MarsRover withPosition: origen andOrientation: orientacion.
	
	rovie execute: 'f'.
	
	self assert: 0 @ 1 equals: rovie position.
	self assert: orientacion equals: rovie orientation.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'EB 5/12/2019 20:33:09'!
test04GoBackwardFacingNorth
	| origen rovie orientacion |
	origen _ 0 @ 0.
	orientacion _ NorthMarsRoverOrientation  new.
	rovie _ MarsRover withPosition: origen andOrientation: orientacion.
	
	rovie execute: 'b'.
	
	self assert: 0 @ -1 equals: rovie position.
	self assert: orientacion equals: rovie orientation.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'EB 5/12/2019 20:33:16'!
test05RotateLeftFacingNorth
	| origen rovie orientacion |
	origen _ 0 @ 0.
	orientacion _ NorthMarsRoverOrientation new.
	rovie _ MarsRover withPosition: origen andOrientation: orientacion.
	
	rovie execute: 'l'.
	
	self assert: origen equals: rovie position.
	self assert: WestMarsRoverOrientation new equals: rovie orientation.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'EB 5/12/2019 20:33:25'!
test06RotateRightFacingNorth
	| origen rovie orientacion |
	origen _ 0 @ 0.
	orientacion _ NorthMarsRoverOrientation new.
	rovie _ MarsRover withPosition: origen andOrientation: orientacion.
	
	rovie execute: 'r'.
	
	self assert: origen equals: rovie position.
	self assert: EastMarsRoverOrientation new equals: rovie orientation.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'EB 5/12/2019 20:33:39'!
test07MoreThanOneCommandExecutes
	| origen rovie orientacion |
	origen _ 0 @ 0.
	orientacion _ NorthMarsRoverOrientation new.
	rovie _ MarsRover withPosition: origen andOrientation: orientacion.
	
	rovie execute: 'rf'.
	
	self assert: 1 @ 0 equals: rovie position.
	self assert: EastMarsRoverOrientation new equals: rovie orientation.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'EB 5/12/2019 20:13:42'!
test08GoForwardFacingSouth
	| origen rovie orientacion |
	origen _ 0 @ 0.
	orientacion _ SouthMarsRoverOrientation new.
	rovie _ MarsRover withPosition: origen andOrientation: orientacion.
	
	rovie execute: 'f'.
	
	self assert: 0 @ -1 equals: rovie position.
	self assert: orientacion equals: rovie orientation.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'EB 5/12/2019 20:12:40'!
test09GoForwardFacingWest
	| origen rovie orientacion |
	origen _ 0 @ 0.
	orientacion _ WestMarsRoverOrientation new.
	rovie _ MarsRover withPosition: origen andOrientation: orientacion.
	
	rovie execute: 'f'.
	
	self assert: -1 @ 0 equals: rovie position.
	self assert: orientacion equals: rovie orientation.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'EB 5/12/2019 20:13:59'!
test10GoBackwardFacingSouth
	| origen rovie orientacion |
	origen _ 0 @ 0.
	orientacion _ SouthMarsRoverOrientation new.
	rovie _ MarsRover withPosition: origen andOrientation: orientacion.
	
	rovie execute: 'b'.
	
	self assert: 0 @ 1 equals: rovie position.
	self assert: orientacion equals: rovie orientation.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'EB 5/12/2019 20:14:15'!
test11GoBackwardFacingWest
	| origen rovie orientacion |
	origen _ 0 @ 0.
	orientacion _ WestMarsRoverOrientation new.
	rovie _ MarsRover withPosition: origen andOrientation: orientacion.
	
	rovie execute: 'b'.
	
	self assert: 1 @ 0 equals: rovie position.
	self assert: orientacion equals: rovie orientation.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'EB 5/12/2019 20:14:32'!
test12RotateRightFacingEast
	| origen rovie orientacion |
	origen _ 0 @ 0.
	orientacion _ EastMarsRoverOrientation new.
	rovie _ MarsRover withPosition: origen andOrientation: orientacion.
	
	rovie execute: 'r'.
	
	self assert: origen equals: rovie position.
	self assert: SouthMarsRoverOrientation new equals: rovie orientation.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'EB 5/12/2019 20:24:30'!
test13RotateRightFacingSouth
	| origen rovie orientacion |
	origen _ 0 @ 0.
	orientacion _ SouthMarsRoverOrientation new.
	rovie _ MarsRover withPosition: origen andOrientation: orientacion.
	
	rovie execute: 'r'.
	
	self assert: origen equals: rovie position.
	self assert: WestMarsRoverOrientation new equals: rovie orientation.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'EB 5/12/2019 20:25:13'!
test14RotateRightFacingWest
	| origen rovie orientacion |
	origen _ 0 @ 0.
	orientacion _ WestMarsRoverOrientation new.
	rovie _ MarsRover withPosition: origen andOrientation: orientacion.
	
	rovie execute: 'r'.
	
	self assert: origen equals: rovie position.
	self assert: NorthMarsRoverOrientation new equals: rovie orientation.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'EB 5/12/2019 20:25:50'!
test15RotateLeftFacingSouth
	| origen rovie orientacion |
	origen _ 0 @ 0.
	orientacion _ SouthMarsRoverOrientation new.
	rovie _ MarsRover withPosition: origen andOrientation: orientacion.
	
	rovie execute: 'l'.
	
	self assert: origen equals: rovie position.
	self assert: EastMarsRoverOrientation new equals: rovie orientation.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'EB 5/12/2019 20:26:57'!
test16RotateLeftFacingWest
	| origen rovie orientacion |
	origen _ 0 @ 0.
	orientacion _ WestMarsRoverOrientation new.
	rovie _ MarsRover withPosition: origen andOrientation: orientacion.
	
	rovie execute: 'l'.
	
	self assert: origen equals: rovie position.
	self assert: SouthMarsRoverOrientation new equals: rovie orientation.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'EB 5/12/2019 20:27:55'!
test17RotateLeftFacingEast
	| origen rovie orientacion |
	origen _ 0 @ 0.
	orientacion _ EastMarsRoverOrientation new.
	rovie _ MarsRover withPosition: origen andOrientation: orientacion.
	
	rovie execute: 'l'.
	
	self assert: origen equals: rovie position.
	self assert: NorthMarsRoverOrientation new equals: rovie orientation.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'EB 5/12/2019 20:34:08'!
test18InvalidCommandShouldDoNothing
	| origen rovie orientacion |
	origen _ 22 @ -54.
	orientacion _ EastMarsRoverOrientation new.
	rovie _ MarsRover withPosition: origen andOrientation: orientacion.
	
	self should: [ rovie execute: 'x'.] 
		raise: Error
		withExceptionDo: [ :exception |
			self assert: MarsRover invalidCommandExceptionMessage equals: exception messageText.
			self assert: origen equals: rovie position.
			self assert: orientacion equals: rovie orientation.
		].
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'EB 5/12/2019 20:29:04'!
test19ShouldExecuteUntilInvalidCommandFound
	| origen rovie orientacion |
	origen _ 22 @ -54.
	orientacion _ NorthMarsRoverOrientation new.
	rovie _ MarsRover withPosition: origen andOrientation: orientacion.
	
	self should: [ rovie execute: 'rbxf'.] 
		raise: Error
		withExceptionDo: [ :exception |
			self assert: MarsRover invalidCommandExceptionMessage equals: exception messageText.
			self assert: 21 @ -54 equals: rovie position.
			self assert: EastMarsRoverOrientation new equals: rovie orientation.
		].
	
	! !
