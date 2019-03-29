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

!II class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:07:53'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 19:46:43'!
next
	next ifNil: [
		next _ self cloneNamed: self name, 'I'.
		next previous: self.
	].
	^next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 19:45:48'!
previous
	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 19:45:16'!
previous: unNumeroDePeano
	previous _ unNumeroDePeano.! !

!II class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 19:47:24'!
removeAllNext
	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!II class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 19:53:51'!
restarDe: unNumeroDePeano
	^self previous restarDe: unNumeroDePeano previous! !


!classDefinition: #III category: #'Numeros de Peano'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Numeros de Peano'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:28'!
* unNumeroDePeano
	^self previous * unNumeroDePeano + unNumeroDePeano! !

!III class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:28'!
+ unNumeroDePeano
	^self previous + unNumeroDePeano next
! !

!III class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:28'!
- unNumeroDePeano
	^unNumeroDePeano restarDe: self! !

!III class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:28'!
/ unNumeroDePeano
	"Devuelve el número de Peano n tal que n * unNumeroDePeano = self."
	^unNumeroDePeano dividir: self! !

!III class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:28'!
<= unNumeroDePeano
	^unNumeroDePeano > self previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:28'!
> unNumeroDePeano
	^(self = unNumeroDePeano) not and: unNumeroDePeano <= self! !

!III class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:28'!
dividir: unNumeroDePeano
	"
	Devuelve unNumeroDePeano / self.
	No funciona si unNumeroDePeano < self.
	"
	(self <= unNumeroDePeano and: self + self > unNumeroDePeano) ifTrue: [^I].
	self > unNumeroDePeano ifTrue: [self error: 'No es un cuerpo'].
	^(unNumeroDePeano - self / self) next.
	! !

!III class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:07:53'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:28'!
next
	next ifNil: [
		next _ self cloneNamed: self name, 'I'.
		next previous: self.
	].
	^next.! !

!III class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:28'!
previous
	^previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:28'!
previous: unNumeroDePeano
	previous _ unNumeroDePeano.! !

!III class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:28'!
removeAllNext
	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!III class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:28'!
restarDe: unNumeroDePeano
	^self previous restarDe: unNumeroDePeano previous! !


!classDefinition: #IIII category: #'Numeros de Peano'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'Numeros de Peano'!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:28'!
* unNumeroDePeano
	^self previous * unNumeroDePeano + unNumeroDePeano! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:28'!
+ unNumeroDePeano
	^self previous + unNumeroDePeano next
! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:28'!
- unNumeroDePeano
	^unNumeroDePeano restarDe: self! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:28'!
/ unNumeroDePeano
	"Devuelve el número de Peano n tal que n * unNumeroDePeano = self."
	^unNumeroDePeano dividir: self! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:28'!
<= unNumeroDePeano
	^unNumeroDePeano > self previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:28'!
> unNumeroDePeano
	^(self = unNumeroDePeano) not and: unNumeroDePeano <= self! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:28'!
dividir: unNumeroDePeano
	"
	Devuelve unNumeroDePeano / self.
	No funciona si unNumeroDePeano < self.
	"
	(self <= unNumeroDePeano and: self + self > unNumeroDePeano) ifTrue: [^I].
	self > unNumeroDePeano ifTrue: [self error: 'No es un cuerpo'].
	^(unNumeroDePeano - self / self) next.
	! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:07:53'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:28'!
next
	next ifNil: [
		next _ self cloneNamed: self name, 'I'.
		next previous: self.
	].
	^next.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:28'!
previous
	^previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:28'!
previous: unNumeroDePeano
	previous _ unNumeroDePeano.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:28'!
removeAllNext
	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:28'!
restarDe: unNumeroDePeano
	^self previous restarDe: unNumeroDePeano previous! !


!classDefinition: #IIIII category: #'Numeros de Peano'!
DenotativeObject subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: #'Numeros de Peano'!
IIIII class
	instanceVariableNames: 'next previous'!

!IIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:33'!
* unNumeroDePeano
	^self previous * unNumeroDePeano + unNumeroDePeano! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:33'!
+ unNumeroDePeano
	^self previous + unNumeroDePeano next
! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:33'!
- unNumeroDePeano
	^unNumeroDePeano restarDe: self! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:33'!
/ unNumeroDePeano
	"Devuelve el número de Peano n tal que n * unNumeroDePeano = self."
	^unNumeroDePeano dividir: self! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:33'!
<= unNumeroDePeano
	^unNumeroDePeano > self previous! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:33'!
> unNumeroDePeano
	^(self = unNumeroDePeano) not and: unNumeroDePeano <= self! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:33'!
dividir: unNumeroDePeano
	"
	Devuelve unNumeroDePeano / self.
	No funciona si unNumeroDePeano < self.
	"
	(self <= unNumeroDePeano and: self + self > unNumeroDePeano) ifTrue: [^I].
	self > unNumeroDePeano ifTrue: [self error: 'No es un cuerpo'].
	^(unNumeroDePeano - self / self) next.
	! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:07:53'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIII.
	previous := IIII.! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:33'!
next
	next ifNil: [
		next _ self cloneNamed: self name, 'I'.
		next previous: self.
	].
	^next.! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:33'!
previous
	^previous! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:33'!
previous: unNumeroDePeano
	previous _ unNumeroDePeano.! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:33'!
removeAllNext
	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:33'!
restarDe: unNumeroDePeano
	^self previous restarDe: unNumeroDePeano previous! !


!classDefinition: #IIIIII category: #'Numeros de Peano'!
DenotativeObject subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: #'Numeros de Peano'!
IIIIII class
	instanceVariableNames: 'next previous'!

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:34'!
* unNumeroDePeano
	^self previous * unNumeroDePeano + unNumeroDePeano! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:34'!
+ unNumeroDePeano
	^self previous + unNumeroDePeano next
! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:34'!
- unNumeroDePeano
	^unNumeroDePeano restarDe: self! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:34'!
/ unNumeroDePeano
	"Devuelve el número de Peano n tal que n * unNumeroDePeano = self."
	^unNumeroDePeano dividir: self! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:34'!
<= unNumeroDePeano
	^unNumeroDePeano > self previous! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:34'!
> unNumeroDePeano
	^(self = unNumeroDePeano) not and: unNumeroDePeano <= self! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:34'!
dividir: unNumeroDePeano
	"
	Devuelve unNumeroDePeano / self.
	No funciona si unNumeroDePeano < self.
	"
	(self <= unNumeroDePeano and: self + self > unNumeroDePeano) ifTrue: [^I].
	self > unNumeroDePeano ifTrue: [self error: 'No es un cuerpo'].
	^(unNumeroDePeano - self / self) next.
	! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:07:53'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIII.
	previous := IIIII.! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:34'!
next
	next ifNil: [
		next _ self cloneNamed: self name, 'I'.
		next previous: self.
	].
	^next.! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:34'!
previous
	^previous! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:34'!
previous: unNumeroDePeano
	previous _ unNumeroDePeano.! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:34'!
removeAllNext
	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:34'!
restarDe: unNumeroDePeano
	^self previous restarDe: unNumeroDePeano previous! !


!classDefinition: #IIIIIII category: #'Numeros de Peano'!
DenotativeObject subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIII class' category: #'Numeros de Peano'!
IIIIIII class
	instanceVariableNames: 'next previous'!

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:39'!
* unNumeroDePeano
	^self previous * unNumeroDePeano + unNumeroDePeano! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:39'!
+ unNumeroDePeano
	^self previous + unNumeroDePeano next
! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:39'!
- unNumeroDePeano
	^unNumeroDePeano restarDe: self! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:39'!
/ unNumeroDePeano
	"Devuelve el número de Peano n tal que n * unNumeroDePeano = self."
	^unNumeroDePeano dividir: self! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:39'!
<= unNumeroDePeano
	^unNumeroDePeano > self previous! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:39'!
> unNumeroDePeano
	^(self = unNumeroDePeano) not and: unNumeroDePeano <= self! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:39'!
dividir: unNumeroDePeano
	"
	Devuelve unNumeroDePeano / self.
	No funciona si unNumeroDePeano < self.
	"
	(self <= unNumeroDePeano and: self + self > unNumeroDePeano) ifTrue: [^I].
	self > unNumeroDePeano ifTrue: [self error: 'No es un cuerpo'].
	^(unNumeroDePeano - self / self) next.
	! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:07:53'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIII.
	previous := IIIIII.! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:39'!
next
	next ifNil: [
		next _ self cloneNamed: self name, 'I'.
		next previous: self.
	].
	^next.! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:39'!
previous
	^previous! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:39'!
previous: unNumeroDePeano
	previous _ unNumeroDePeano.! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:39'!
removeAllNext
	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:39'!
restarDe: unNumeroDePeano
	^self previous restarDe: unNumeroDePeano previous! !


!classDefinition: #IIIIIIII category: #'Numeros de Peano'!
DenotativeObject subclass: #IIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIII class' category: #'Numeros de Peano'!
IIIIIIII class
	instanceVariableNames: 'next previous'!

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:39'!
* unNumeroDePeano
	^self previous * unNumeroDePeano + unNumeroDePeano! !

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:39'!
+ unNumeroDePeano
	^self previous + unNumeroDePeano next
! !

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:39'!
- unNumeroDePeano
	^unNumeroDePeano restarDe: self! !

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:39'!
/ unNumeroDePeano
	"Devuelve el número de Peano n tal que n * unNumeroDePeano = self."
	^unNumeroDePeano dividir: self! !

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:39'!
<= unNumeroDePeano
	^unNumeroDePeano > self previous! !

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:39'!
> unNumeroDePeano
	^(self = unNumeroDePeano) not and: unNumeroDePeano <= self! !

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:39'!
dividir: unNumeroDePeano
	"
	Devuelve unNumeroDePeano / self.
	No funciona si unNumeroDePeano < self.
	"
	(self <= unNumeroDePeano and: self + self > unNumeroDePeano) ifTrue: [^I].
	self > unNumeroDePeano ifTrue: [self error: 'No es un cuerpo'].
	^(unNumeroDePeano - self / self) next.
	! !

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:07:53'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIIIIII.! !

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:39'!
next
	next ifNil: [
		next _ self cloneNamed: self name, 'I'.
		next previous: self.
	].
	^next.! !

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:39'!
previous
	^previous! !

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:39'!
previous: unNumeroDePeano
	previous _ unNumeroDePeano.! !

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:39'!
removeAllNext
	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'EB 3/28/2019 21:00:39'!
restarDe: unNumeroDePeano
	^self previous restarDe: unNumeroDePeano previous! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!
IIIIIII initializeAfterFileIn!
IIIIIIII initializeAfterFileIn!