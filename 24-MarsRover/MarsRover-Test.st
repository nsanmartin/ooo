!classDefinition: #MarsRoverTest category: #'MarsRover-Test'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Test'!

!MarsRoverTest methodsFor: 'testing' stamp: 'EB 5/7/2019 16:25:20'!
test00InicializarMarsRover
	| orientacion rover origin |
	origin _ 0 @ 0.
	orientacion _ 1 @ 0.
	rover _ MarsRover withOrigin: origin andOrientation: orientacion.
	
	self assert: origin equals: rover position.
	self assert: 1 @ 0 equals: rover orientation.
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EB 5/7/2019 17:26:20'!
test01ExecuteSinComandos
	self assertExecute: '' 
		withOrigin: 0 @ 0 
		andOrientation: 0 @ 1
		resultsInPosition: 0 @ 0 
		andOrientation: 0 @ 1
! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EB 5/7/2019 17:33:34'!
test02RotarDerechaDesdeElNorte
	self assertExecute: 'r' 
		withOrigin: 0 @ 0 
		andOrientation: 0 @ 1
		resultsInPosition: 0 @ 0
		andOrientation: 1 @ 0
! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EB 5/7/2019 17:25:32'!
test03RotarIzquierdaDesdeElNorte
	self assertExecute: 'l' 
		withOrigin: 0 @ 0 
		andOrientation: 0 @ 1
		resultsInPosition: 0 @ 0 
		andOrientation: -1 @ 0
! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EB 5/7/2019 17:24:58'!
test04MoverAdelanteDesdeElNorte
	self assertExecute: 'f' 
		withOrigin: 0 @ 0 
		andOrientation: 0 @ 1
		resultsInPosition: 0 @ 1 
		andOrientation: 0 @ 1

	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EB 5/7/2019 17:24:24'!
test05MoverAtrasDesdeElNorte
	self assertExecute: 'b' 
		withOrigin: 0 @ 0 
		andOrientation: 0 @ 1
		resultsInPosition: 0 @ -1 
		andOrientation: 0 @ 1

	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EB 5/7/2019 18:59:49'!
test06DosComandos
	| orientacion rover origen |
	origen _ -23 @ -34.
	orientacion _ 0 @ 1.
	rover _ MarsRover withOrigin: origen andOrientation: orientacion.
	
	rover execute: 'fr'.
	
	self assert: -23 @ -33 equals: rover position.
	self assert: 1 @ 0 equals: rover orientation! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EB 5/7/2019 16:51:20'!
test07OperacionInválida
	| orientacion rover origen |
	origen _ 0 @ 0.
	orientacion _ 0 @ 1.
	rover _ MarsRover withOrigin: origen andOrientation: orientacion.
	
	self 
		should: [rover execute: 'x'.] 
		raise: Error
		withExceptionDo: [ :exception |
			self assert: MarsRover invalidOperationExceptionDescription equals: exception messageText.
			self assert: origen equals: rover position.
			self assert: orientacion equals: rover orientation.
		]. 
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EB 5/7/2019 16:54:45'!
test08OperacionInválidaDeberíaEjecutarLasOperacionesAnterioresYNoLasPosteriores
	| orientacion rover origen |
	origen _ 0 @ 0.
	orientacion _ 0 @ 1.
	rover _ MarsRover withOrigin: origen andOrientation: orientacion.
	
	self 
		should: [rover execute: 'rxf'.] 
		raise: Exception
		withExceptionDo: [ :exception |
			self assert: MarsRover invalidOperationExceptionDescription equals: exception messageText.
			self assert: origen equals: rover position.
			self assert: 1 @ 0 equals: rover orientation.
		]. 
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EB 5/7/2019 17:21:59'!
test10RotarDerechaDesdeElEste
	self assertExecute: 'r' 
		withOrigin: 0 @ 0 
		andOrientation: 1 @ 0
		resultsInPosition: 0 @ 0 
		andOrientation: 0 @ -1
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EB 5/7/2019 17:34:44'!
test11RotarDerechaDesdeElOeste
	self assertExecute: 'r' 
		withOrigin: -25 @ 10
		andOrientation: -1 @ 0
		resultsInPosition: -25 @ 10 
		andOrientation: 0 @ 1
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EB 5/7/2019 18:02:52'!
test12RotarDerechaDesdeElSur
	self assertExecute: 'r' 
		withOrigin: 24 @ -10
		andOrientation: 0 @ -1
		resultsInPosition: 24 @ -10 
		andOrientation: -1 @ 0
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EB 5/7/2019 18:02:57'!
test13RotarIzquierdaDesdeOtraOrientacionQueElNorte
	self assertExecute: 'l' 
		withOrigin: 0 @ 0
		andOrientation: 0 @ -1
		resultsInPosition: 0 @ 0 
		andOrientation: 1 @ 0
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EB 5/7/2019 18:05:03'!
test14MoverAdelanteDesdeOtraDirecciónQueElNorte
	self assertExecute: 'f'
		withOrigin: 43 @ 0
		andOrientation: 0 @ -1
		resultsInPosition: 43 @ -1 
		andOrientation: 0 @ -1
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EB 5/7/2019 18:05:31'!
test15MoverAtrásDesdeOtraDirecciónQueElNorte
	self assertExecute: 'b'
		withOrigin: 43 @ 0
		andOrientation: 0 @ -1
		resultsInPosition: 43 @ 1 
		andOrientation: 0 @ -1
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EB 5/7/2019 19:00:26'!
test16TresOMásOperaciones
	self assertExecute: 'brf'
		withOrigin: 43 @ 0
		andOrientation: 0 @ 1
		resultsInPosition: 44 @ -1
		andOrientation: 1 @ 0
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EB 5/7/2019 18:36:47'!
test17OrientaciónInválida
	self should: [MarsRover withOrigin: 0 @ 0 andOrientation: 0.5 @ 2]
		raise: Error
		withExceptionDo: [ :exception|
			self assert: MarsRover invalidOrientationExceptionDescription equals: exception messageText.
		].! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'EB 5/7/2019 17:23:35'!
assertExecute: commands withOrigin: originPoint andOrientation: startingOrientation resultsInPosition: expectedPosition andOrientation: expectedOrientation 
	| rover |
	rover _ MarsRover withOrigin: originPoint andOrientation: startingOrientation.
	
	rover execute: commands.
	
	self assert: expectedPosition equals: rover position.
	self assert: expectedOrientation equals: rover orientation.
	! !
