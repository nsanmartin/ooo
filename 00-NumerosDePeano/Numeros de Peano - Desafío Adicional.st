!classDefinition: #I category: #'Numeros de Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Numeros de Peano'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 19:54:57'!
* unNumeroDePeano
	^unNumeroDePeano.! !

!I class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 19:50:03'!
+ unNumeroDePeano
	^unNumeroDePeano next! !

!I class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:07:40'!
- unNumeroDePeano
	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:05:54'!
/ unNumeroDePeano
	unNumeroDePeano = I ifTrue: [^I] ifFalse: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].! !

!I class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 20:39:50'!
<= unNumeroDePeano
	^true! !

!I class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 20:33:49'!
> unNumeroDePeano
	^false! !

!I class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:05:36'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No es un cuerpo'! !

!I class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:07:09'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Números negativos no soportados'! !

!I class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 20:18:17'!
dividir: unNumeroDePeano
	^unNumeroDePeano! !

!I class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 19:43:02'!
next
	^II! !

!I class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 19:51:06'!
restarDe: unNumeroDePeano
	^unNumeroDePeano previous! !


!classDefinition: #II category: #'Numeros de Peano'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Numeros de Peano'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 19:55:30'!
* unNumeroDePeano
	^self previous * unNumeroDePeano + unNumeroDePeano! !

!II class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 19:50:24'!
+ unNumeroDePeano
	^self previous + unNumeroDePeano next
! !

!II class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 19:51:51'!
- unNumeroDePeano
	^unNumeroDePeano restarDe: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 20:18:42'!
/ unNumeroDePeano
	"Devuelve el número de Peano n tal que n * unNumeroDePeano = self."
	^unNumeroDePeano dividir: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 20:41:33'!
<= unNumeroDePeano
	^unNumeroDePeano > self previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 20:42:07'!
> unNumeroDePeano
	^(self = unNumeroDePeano) not and: unNumeroDePeano <= self! !

!II class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:05:22'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^I descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.! !

!II class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:06:18'!
dividir: unNumeroDePeano
	"
	Devuelve unNumeroDePeano / self.
	No funciona si unNumeroDePeano < self.
	"
	(self <= unNumeroDePeano and: self + self > unNumeroDePeano) ifTrue: [^I].
	self > unNumeroDePeano ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	^(unNumeroDePeano - self / self) next.
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:17:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:14:06'!
next
	next ifNil: [
		next _ self createChildNamed: self name, 'I'.
		next previous: self.
	].
	^next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 19:45:48'!
previous
	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 19:45:16'!
previous: unNumeroDePeano
	previous _ unNumeroDePeano.! !

!II class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 19:53:51'!
restarDe: unNumeroDePeano
	^self previous restarDe: unNumeroDePeano previous! !


!classDefinition: #III category: #'Numeros de Peano'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Numeros de Peano'!
III class
	instanceVariableNames: ''!

!III class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:17:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: #'Numeros de Peano'!
III subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'Numeros de Peano'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:17:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !


!classDefinition: #IIIII category: #'Numeros de Peano'!
IIII subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: #'Numeros de Peano'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:17:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIII.
	previous := IIII.! !


!classDefinition: #IIIIII category: #'Numeros de Peano'!
IIIII subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: #'Numeros de Peano'!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:17:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIII.
	previous := IIIII.! !


!classDefinition: #IIIIIII category: #'Numeros de Peano'!
IIIIII subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIII class' category: #'Numeros de Peano'!
IIIIIII class
	instanceVariableNames: ''!

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:17:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIII.
	previous := IIIIII.! !


!classDefinition: #IIIIIIII category: #'Numeros de Peano'!
IIIIIII subclass: #IIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIII class' category: #'Numeros de Peano'!
IIIIIIII class
	instanceVariableNames: ''!

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:17:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIIIIII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!
IIIIIII initializeAfterFileIn!
IIIIIIII initializeAfterFileIn!