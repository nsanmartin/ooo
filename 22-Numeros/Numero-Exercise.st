!classDefinition: #NumeroTest category: #'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:26'!
test27EnteroSubstractsEnteroCorrectly

	self assert: two - one equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: #'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'EB 4/9/2019 19:48:44'!
- aSubtrahend
	^aSubtrahend negated + self.! !

!Numero methodsFor: 'arithmetic operations' stamp: 'EB 4/9/2019 19:42:49'!
/ aDivisor
	^self * aDivisor inverse.! !

!Numero methodsFor: 'arithmetic operations' stamp: 'EB 4/9/2019 20:20:20'!
addEntero: anEntero
	self subclassResponsibility! !

!Numero methodsFor: 'arithmetic operations' stamp: 'EB 4/9/2019 20:20:49'!
addFraccion: aFraccion
	self subclassResponsibility! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'EB 4/9/2019 19:47:52'!
inverse
	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'EB 4/9/2019 20:28:44'!
multiplyByEntero: anEntero
	self subclassResponsibility.! !

!Numero methodsFor: 'arithmetic operations' stamp: 'EB 4/9/2019 20:29:29'!
multiplyByFraccion: aFraccion
	self subclassResponsibility.! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !


!Numero methodsFor: 'comparing' stamp: 'EB 4/9/2019 20:38:34'!
= anObject
	self subclassResponsibility.
! !

!Numero methodsFor: 'comparing' stamp: 'EB 4/9/2019 20:37:55'!
isEqualToEntero: anEntero
	self subclassResponsibility.! !

!Numero methodsFor: 'comparing' stamp: 'EB 4/9/2019 20:37:32'!
isEqualToFraccion: aFraccion
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: #'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:45'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/8/2019 02:58:13'!
invalidNumberTypeErrorDescription
	^ 'Tipo de número inválido'! !


!classDefinition: #Entero category: #'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'EB 4/9/2019 20:29:11'!
* aMultiplier 
	^aMultiplier multiplyByEntero: self.
	
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'EB 4/9/2019 20:21:09'!
+ anAdder 
	^anAdder addEntero: self
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'EB 4/11/2019 20:56:44'!
addEntero: anEntero
	^self class with: self integerValue + anEntero integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'EB 4/9/2019 20:27:43'!
addFraccion: aFraccion
	^Fraccion with: self * aFraccion denominator + aFraccion numerator over: aFraccion denominator.
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'EB 4/11/2019 21:05:17'!
fibonacci

	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'EB 4/9/2019 19:41:16'!
inverse
	^Fraccion with: (Entero with: 1) over: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'EB 4/9/2019 20:30:08'!
multiplyByEntero: anEntero
	^Entero with: self integerValue * anEntero integerValue.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'EB 4/9/2019 20:30:37'!
multiplyByFraccion: aFraccion
	^Fraccion with: self * aFraccion numerator over: aFraccion denominator.! !


!Entero methodsFor: 'comparing' stamp: 'EB 4/9/2019 20:38:57'!
= anObject
	^anObject isEqualToEntero: self.
	! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !

!Entero methodsFor: 'comparing' stamp: 'EB 4/9/2019 20:39:27'!
isEqualToEntero: anEntero
	^value = anEntero integerValue! !

!Entero methodsFor: 'comparing' stamp: 'EB 4/9/2019 20:39:52'!
isEqualToFraccion: aFraccion
	^false.! !


!Entero methodsFor: 'initialization' stamp: 'EB 4/11/2019 21:52:08'!
fraccionConDenominadorMayorAUno: aDenominadorMayorAUno
	| denominator greatestCommonDivisor numerator |
	greatestCommonDivisor := self greatestCommonDivisorWith: aDenominadorMayorAUno . 
	numerator := self // greatestCommonDivisor.
	denominator := aDenominadorMayorAUno // greatestCommonDivisor.

	^denominator fraccionConNumeradorYaSimplificado: numerator.

! !

!Entero methodsFor: 'initialization' stamp: 'EB 4/11/2019 21:46:26'!
fraccionConNumerador: unNumerador
	^unNumerador fraccionConDenominadorMayorAUno: self.
	! !

!Entero methodsFor: 'initialization' stamp: 'EB 4/11/2019 21:52:00'!
fraccionConNumeradorYaSimplificado: unNumerador
	^Fraccion new initializeWith: unNumerador over: self.	! !

!Entero methodsFor: 'initialization' stamp: 'EB 4/11/2019 20:31:42'!
initalizeWith: aValue 
	value := aValue! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'NR 9/23/2018 22:17:55'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: #'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/8/2019 02:57:57'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos'! !

!Entero class methodsFor: 'instance creation' stamp: 'EB 4/11/2019 21:17:03'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	aValue = 0 ifTrue: [^EnteroCero new].
	aValue = 1 ifTrue: [^EnteroUno new].
	aValue < 0 ifTrue: [^EnteroNegativo new initalizeWith: aValue].
	^self new initalizeWith: aValue! !


!classDefinition: #EnteroCero category: #'Numero-Exercise'!
Entero subclass: #EnteroCero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroCero methodsFor: 'initialization' stamp: 'EB 4/11/2019 21:45:56'!
fraccionConDenominadorMayorAUno: aDenominadorMayorAUno
	^self! !

!EnteroCero methodsFor: 'initialization' stamp: 'EB 4/11/2019 21:31:50'!
fraccionConNumerador: aNumerador
	 self error: Fraccion canNotDivideByZeroErrorDescription.! !

!EnteroCero methodsFor: 'initialization' stamp: 'EB 4/11/2019 20:48:43'!
initialize
	value := 0.! !


!EnteroCero methodsFor: 'arithmetic operations' stamp: 'EB 4/11/2019 20:49:30'!
fibonacci
	^Entero with: 1.! !


!classDefinition: #EnteroNegativo category: #'Numero-Exercise'!
Entero subclass: #EnteroNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroNegativo methodsFor: 'arithmetic operations' stamp: 'EB 4/11/2019 21:05:25'!
fibonacci
	self error: Entero negativeFibonacciErrorDescription.
	! !


!EnteroNegativo methodsFor: 'initialization' stamp: 'EB 4/11/2019 21:34:22'!
fraccionConNumerador: aNumerador
	^aNumerador negated / self negated! !


!classDefinition: #EnteroUno category: #'Numero-Exercise'!
Entero subclass: #EnteroUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroUno methodsFor: 'initialization' stamp: 'EB 4/11/2019 21:51:05'!
fraccionConNumeradorYaSimplificado: aNumerador
	^aNumerador! !

!EnteroUno methodsFor: 'initialization' stamp: 'EB 4/11/2019 20:41:35'!
initialize
	value := 1.! !


!EnteroUno methodsFor: 'arithmetic operations' stamp: 'EB 4/11/2019 20:49:39'!
fibonacci
	^Entero with: 1.! !


!classDefinition: #Fraccion category: #'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'EB 4/9/2019 20:31:01'!
* aMultiplier 
	^aMultiplier multiplyByFraccion: self
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'EB 4/9/2019 20:21:35'!
+ anAdder 
	^anAdder addFraccion: self.
	
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'EB 4/9/2019 20:25:58'!
addEntero: anEntero
	^anEntero addFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'EB 4/9/2019 20:26:39'!
addFraccion: aFraccion
	| newNumerator newDenominator |
	newNumerator := (numerator * aFraccion denominator) + (denominator * aFraccion numerator).
	newDenominator := denominator * aFraccion denominator.
	
	^newNumerator / newDenominator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'EB 4/9/2019 19:23:56'!
inverse
	^Fraccion with: self denominator over: self numerator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'EB 4/9/2019 20:32:56'!
multiplyByEntero: anEntero
	^anEntero multiplyByFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'EB 4/9/2019 20:32:09'!
multiplyByFraccion: aFraccion
	^(self numerator * aFraccion numerator) / (self denominator * aFraccion denominator).	
	! !


!Fraccion methodsFor: 'comparing' stamp: 'EB 4/9/2019 20:40:18'!
= anObject
	^anObject isEqualToFraccion: self.
! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !

!Fraccion methodsFor: 'comparing' stamp: 'EB 4/9/2019 20:41:38'!
isEqualToEntero: anEntero
	^false.! !

!Fraccion methodsFor: 'comparing' stamp: 'EB 4/9/2019 20:41:04'!
isEqualToFraccion: aFraccion
	^(self numerator * aFraccion denominator) = (self denominator * aFraccion numerator).
! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: #'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'EB 4/11/2019 21:39:50'!
with: aDividend over: aDivisor
	^aDivisor fraccionConNumerador: aDividend! !
