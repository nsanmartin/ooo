!classDefinition: #MarsRoverTest category: #'MarsRover-Test'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Test'!

!MarsRoverTest methodsFor: 'testing' stamp: 'EB 5/7/2019 15:30:31'!
test00InicializarMarsRover
	| orientacion rover origin |
	origin _ 0@0.
	orientacion _ NorthMarsRoverOrientation new.
	rover _ MarsRover withOrigin: origin andOrientation: orientacion.
	
	self assert: origin equals: rover position.
	self assert: #North equals: rover orientationSymbol.
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EB 5/7/2019 15:30:31'!
test01MoverConStringVacio
	| orientacion rover comandos origen |
	origen _ 0@0.
	orientacion _ #North.
	rover _ MarsRover withOrigin: origen andOrientation: orientacion.
	
	comandos _ ''.
	rover move: comandos.
	
	self assert: origen equals: rover position.
	self assert: orientacion equals: rover orientationSymbol.
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EB 5/7/2019 15:30:31'!
test02RotarDerecha
	| orientacion rover comandos origen |
	origen _ 0@0.
	orientacion _ NorthMarsRoverOrientation new.
	rover _ MarsRover withOrigin: origen andOrientation: orientacion.
	
	comandos _ 'r'.
	rover move: comandos.
	
	self assert: origen equals: rover position.
	self assert: #East equals: rover orientationSymbol.
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EB 5/7/2019 15:30:31'!
test03RotarIzquierda
	| orientacion rover comandos origen |
	origen _ 0@0.
	orientacion _ NorthMarsRoverOrientation new.
	rover _ MarsRover withOrigin: origen andOrientation: orientacion.
	
	comandos _ 'l'.
	rover move: comandos.
	
	self assert: origen equals: rover position.
	self assert: #West equals: rover orientationSymbol.
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EB 5/7/2019 15:30:31'!
test04MoverAdelante
	| orientacion rover comandos origen |
	origen _ 0@0.
	orientacion _ NorthMarsRoverOrientation new.
	rover _ MarsRover withOrigin: origen andOrientation: orientacion.
	
	comandos _ 'f'.
	rover move: comandos.
	
	self assert: origen + (0@1) equals: rover position.
	self assert: orientacion asSymbol equals: rover orientationSymbol.
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EB 5/7/2019 15:30:31'!
test05MoverAtras
	| orientacion rover comandos origen |
	origen _ 0@0.
	orientacion _ NorthMarsRoverOrientation new.
	rover _ MarsRover withOrigin: origen andOrientation: orientacion.
	
	comandos _ 'b'.
	rover move: comandos.
	
	self assert: origen - (0@1) equals: rover position.
	self assert: orientacion asSymbol equals: rover orientationSymbol.
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EB 5/7/2019 15:37:44'!
test06MásDeUnaOperación
	| orientacion rover origen |
	origen _ -23@-34.
	orientacion _ EastMarsRoverOrientation new.
	rover _ MarsRover withOrigin: origen andOrientation: orientacion.
	
	rover move: 'fr'.
	
	self assert: origen + (1 @ 0) equals: rover position.
	self assert: #South equals: rover orientationSymbol.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EB 5/7/2019 15:30:31'!
test07OperacionInválida
	| orientacion rover origen |
	origen _ 0@0.
	orientacion _ #North.
	rover _ MarsRover withOrigin: origen andOrientation: orientacion.
	
	self should: [rover move: 'x'.] 
		raise: Exception
		withExceptionDo: [ :exception |
			self assert: MarsRover invalidOperationExceptionDescription equals: exception messageText.
			self assert: origen equals: rover position.
			self assert: orientacion equals: rover orientationSymbol.
		]. 
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EB 5/7/2019 15:37:58'!
test08OperacionInválidaDeberíaEjecutarLasOperacionesAnterioresYNoLasPosteriores
	| orientacion rover origen |
	origen _ 0@0.
	orientacion _ WestMarsRoverOrientation new.
	rover _ MarsRover withOrigin: origen andOrientation: orientacion.
	
	self should: [rover move: 'rxf'.] 
		raise: Exception
		withExceptionDo: [ :exception |
			self assert: MarsRover invalidOperationExceptionDescription equals: exception messageText.
			self assert: origen equals: rover position.
			self assert: #North equals: rover orientationSymbol.
		]. 
	! !
