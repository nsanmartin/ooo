!classDefinition: #TatetiTests category: #Tateti!
TestCase subclass: #TatetiTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tateti'!

!TatetiTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 20:13:52'!
simulateGame: plays 
	| tateti |
	tateti _ Tateti new.
	plays withIndexDo: [ :play :index | index odd ifTrue: [ tateti addXAt: play ] ifFalse: [ tateti addOAt: play ]].
	^ tateti.! !

!TatetiTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 18:19:37'!
test01
	| tateti  |
	tateti _ Tateti new.
	self deny: tateti hasEnded.! !

!TatetiTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 18:19:58'!
test02
 	| jugada tateti |
	tateti _ Tateti new.
	jugada _ 2@3.
	tateti addXAt: jugada.
	self assert: (tateti isXAt: jugada). ! !

!TatetiTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 18:20:03'!
test03
 	| tateti libre |
	tateti _ Tateti new.
	libre _ 1@3.
	self deny: (tateti isXAt: libre). ! !

!TatetiTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 18:20:07'!
test04
 	| tateti jugada1 jugada2 |
	tateti _ Tateti new.
	jugada1 _ 1@3.
	jugada2 _ 1@2.
	tateti addXAt: jugada1 .
	tateti addOAt: jugada2.
	self deny: (tateti isXAt: jugada2). ! !

!TatetiTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 18:20:10'!
test05
 	| tateti jugada |
	tateti _ Tateti new.
	jugada _ 1@3.
	self deny: (tateti isOAt: jugada). ! !

!TatetiTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 18:35:55'!
test06
 	| tateti jugada |
	tateti _ Tateti new.
	jugada _ 1@3.
	tateti addXAt: jugada.
	self should: [tateti addOAt: jugada] raise: Error withExceptionDo: [:exception| self assert: exception messageText equals: Tateti occupiedPositionExceptionMessage].
! !

!TatetiTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 18:35:55'!
test07
 	| tateti jugada jugada2 |
	tateti _ Tateti new.
	jugada _ 1@3.
	tateti addXAt: jugada.
	jugada2 _ 3@3.
	tateti addOAt: jugada2.
	self should: [tateti addXAt: jugada] raise: Error withExceptionDo: [:exception| self assert: exception messageText equals: Tateti occupiedPositionExceptionMessage].
	! !

!TatetiTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 18:38:56'!
test08
 	| tateti jugada jugada2 jugada3 |
	tateti _ Tateti new.
	jugada _ 1@3.
	tateti addXAt: jugada.
	jugada2 _ 3@3.
	tateti addOAt: jugada2.
	jugada3 _ 2@2.
	tateti addXAt: jugada3.
	self assert: (tateti isXAt: jugada).
	self assert: (tateti isXAt: jugada3).
	
	! !

!TatetiTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 18:47:26'!
test09
 	| tateti jugada jugada2 |
	tateti _ Tateti new.
	jugada _ 1@3.
	tateti addXAt: jugada.
	jugada2 _ 3@3.
	tateti addOAt: jugada2.
	self assert: (tateti isOAt: jugada2).
	
	! !

!TatetiTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 18:50:01'!
test10
 	| tateti jugada jugada2 jugada3 jugada4 jugada5 |
	tateti _ Tateti new.
	jugada _ 1@3.
	tateti addXAt: jugada.
	jugada2 _ 3@3.
	tateti addOAt: jugada2.
	jugada3 _ 2@2.
	tateti addXAt: jugada3.
	jugada4 _ 1@1.
	tateti addOAt: jugada4.
	jugada5 _ 3@2.
	tateti addXAt: jugada5.
	
	
	self assert: (tateti isXAt: jugada).
	self assert: (tateti isOAt: jugada2).
	self assert: (tateti isXAt: jugada3).
	self assert: (tateti isOAt: jugada4).
	self assert: (tateti isXAt: jugada5).
	! !

!TatetiTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 18:57:00'!
test11
 	| tateti jugada2 jugada1 |
	tateti _ Tateti new.
	jugada1 _ 1@2.
	jugada2 _ 1@3.
	tateti  addXAt: jugada1.
	tateti  addOAt:  jugada2 .
	self assert: (tateti isOAt: jugada2). ! !

!TatetiTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 19:02:27'!
test12
 	| tateti jugada jugada2 |
	tateti _ Tateti new.
	jugada _ 1@3.
	jugada2 _ 1@2.
	tateti addXAt: jugada.
	self should: [tateti addXAt: jugada2] raise: Error withExceptionDo: [:exception| self assert: exception messageText equals: Tateti playersMustInterleave].
	! !

!TatetiTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 19:09:35'!
test13
 	| tateti jugada jugada2 |
	tateti _ Tateti new.
	jugada _ 1@3.
	jugada2 _ 2@3.
	tateti addXAt: jugada.
	tateti addOAt:  jugada2 .
	self should: [tateti addXAt: jugada2] raise: Error withExceptionDo: [:exception| self assert: exception messageText equals: Tateti occupiedPositionExceptionMessage].
! !

!TatetiTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 19:16:45'!
test14
 	| tateti jugada |
	tateti _ Tateti new.
	jugada _ 1@3.
	self should: [tateti addOAt: jugada] raise: Error withExceptionDo: [:exception| self assert: exception messageText equals: Tateti XMustStart].
! !

!TatetiTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 19:20:07'!
test15
 	| tateti jugada jugada2 jugada3 |
	tateti _ Tateti new.
	jugada _ 1@3.
	jugada2 _ 2@3.
	jugada3 _ 3@3.
	tateti addXAt: jugada.
	tateti addOAt:  jugada2 .
	self should: [tateti addOAt: jugada3] raise: Error withExceptionDo: [:exception| self assert: exception messageText equals: Tateti playersMustInterleave ].
! !

!TatetiTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 20:16:04'!
test16
 	| tateti |
	tateti _ self simulateGame: {1@3. 2@3. 2@2. 1@1. 3@1}.
	self assert: tateti hasEnded.
	self assert: tateti xHasWon.
! !

!TatetiTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 20:26:44'!
test17
 	| tateti |
	tateti _ self simulateGame: {1@2. 2@2. 1@3. 1@1. 2@3. 3@3}.
	self assert: tateti hasEnded.
	self assert: tateti oHasWon.
! !

!TatetiTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 20:31:52'!
test18
	| tateti  |
	tateti _ Tateti new.
	self deny: tateti xHasWon.
	self deny: tateti oHasWon.! !

!TatetiTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 20:35:16'!
test19
	| tateti  |
	tateti _ self simulateGame: {1@1}.
	
	self deny: tateti xHasWon.
	self deny: tateti oHasWon.! !

!TatetiTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 20:46:17'!
test20
 	| tateti |
	tateti _ self simulateGame: {1@2. 2@2. 1@3. 1@1. 2@3. 3@3}.
	self assert: tateti hasEnded.
	self deny: tateti xHasWon.
! !

!TatetiTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 20:50:00'!
test21
 	| tateti |
	tateti _ self simulateGame: {1@2. 3@2. 1@3. 1@1. 2@3. 3@3}.
	self deny: tateti hasEnded.
	self deny: tateti xHasWon.
	self deny: tateti oHasWon.
! !

!TatetiTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 20:58:25'!
test22
 	| tateti |
	tateti _ self simulateGame: {1@3. 2@2. 1@2. 3@1. 1@1}.
	self assert: tateti hasEnded.
	self assert: tateti xHasWon.
! !

!TatetiTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 21:00:45'!
test23
 	| tateti |
	tateti _ self simulateGame: {3@3. 2@2. 3@2. 1@1. 3@1}.
	self assert: tateti hasEnded.
	self assert: tateti xHasWon.
! !

!TatetiTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 21:02:35'!
test24
 	| tateti |
	tateti _ self simulateGame: {2@2. 3@1. 3@2. 1@1. 1@2}.
	self assert: tateti hasEnded.
	self assert: tateti xHasWon.
! !

!TatetiTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 21:04:50'!
test25
 	| tateti |
	tateti _ self simulateGame: {2@2. 1@3. 3@2. 2@3. 1@1. 3@3}.
	self assert: tateti hasEnded.
	self assert: tateti oHasWon.
! !


!classDefinition: #Tateti category: #Tateti!
Object subclass: #Tateti
	instanceVariableNames: 'lastPlayed piecePositions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tateti'!

!Tateti methodsFor: 'initialization' stamp: 'NSM 5/20/2019 19:45:14'!
initialize
	piecePositions _ Dictionary new.
	piecePositions add: #X -> OrderedCollection new; add: #O -> OrderedCollection new.
	lastPlayed _ nil.! !


!Tateti methodsFor: 'player actions' stamp: 'NSM 5/20/2019 19:51:08'!
addOAt: aBoardPosition
	lastPlayed = nil ifTrue: [
		self error: self class XMustStart.
	].
	self addPieceType: #O at: aBoardPosition.! !

!Tateti methodsFor: 'player actions' stamp: 'NSM 5/20/2019 19:53:42'!
addPieceType: aPieceType at: aBoardPosition
	self assertCurrentPlayerIs: aPieceType.
	self assertPositionNotOccupied: aBoardPosition.
	piecePositions at: aPieceType :: add: aBoardPosition.
	lastPlayed _ aPieceType.! !

!Tateti methodsFor: 'player actions' stamp: 'NSM 5/20/2019 19:51:08'!
addXAt: aBoardPosition
	self addPieceType: #X at: aBoardPosition.! !


!Tateti methodsFor: 'evaluating' stamp: 'NSM 5/20/2019 19:46:02'!
isOAt: aBoardPosition 
	^piecePositions at: #O :: includes: aBoardPosition.! !

!Tateti methodsFor: 'evaluating' stamp: 'NSM 5/20/2019 19:45:35'!
isXAt: aBoardPosition 
	^piecePositions at: #X :: includes: aBoardPosition.! !


!Tateti methodsFor: 'assertions' stamp: 'NSM 5/20/2019 19:53:31'!
assertCurrentPlayerIs: currentPlayer
	lastPlayed = currentPlayer ifTrue: [
		self raisePlayersMustInterleaveError.
	].! !

!Tateti methodsFor: 'assertions' stamp: 'NSM 5/20/2019 19:47:27'!
assertPositionNotOccupied: aBoardPosition
	(self isXAt: aBoardPosition ) or: (self isOAt: aBoardPosition) :: ifTrue: [
		self raiseOccupiedError.
	].! !


!Tateti methodsFor: 'error raising' stamp: 'NSM 5/20/2019 18:35:55'!
raiseOccupiedError
	self error: self class occupiedPositionExceptionMessage.! !

!Tateti methodsFor: 'error raising' stamp: 'NSM 5/20/2019 19:21:46'!
raisePlayersMustInterleaveError
	self error: self class playersMustInterleave.! !


!Tateti methodsFor: 'winning' stamp: 'NSM 5/20/2019 20:57:38'!
hasEnded
	^self oHasWon or: self xHasWon.! !

!Tateti methodsFor: 'winning' stamp: 'NSM 5/20/2019 23:14:21'!
hasWonPlayer: aPlayer
	| onSameColumn playerPositions onInverseDiagonal onDiagonal onSameRow |
	playerPositions _ piecePositions at: aPlayer.
	onSameColumn _ self positionsOccupyColumn: playerPositions.
	onSameRow _ self positionsOccupyRow: playerPositions.
	onInverseDiagonal _ self positionsOccupyInverseDiagonal: playerPositions.
	onDiagonal _ self positionsOccupyDiagonal: playerPositions.
	^playerPositions size = 3 and: (
		onDiagonal or: 
		onInverseDiagonal or:
		onSameRow or:
		onSameColumn
	).! !

!Tateti methodsFor: 'winning' stamp: 'NSM 5/20/2019 21:20:19'!
oHasWon
"	| allSameY oPositions |
	oPositions _ piecePositions at: #O.
	allSameY _ self positionsOccupyColumn: oPositions.
	^oPositions = (OrderedCollection with: 2@2 with: 2@1 with: 2@3) or:
		oPositions = (OrderedCollection with: 2@2 with: 1@1 with: 3@3) or:
		allSameY."
		^ self hasWonPlayer: #O.! !

!Tateti methodsFor: 'winning' stamp: 'NSM 5/20/2019 23:14:03'!
positionsOccupyColumn: positionsToCheck
	^positionsToCheck allSatisfy: [ :piecePosition | piecePosition y = positionsToCheck first y].! !

!Tateti methodsFor: 'winning' stamp: 'NSM 5/20/2019 23:15:12'!
positionsOccupyDiagonal: positions
	^positions allSatisfy: [ :position | (position x + position y) = 4 ]. ! !

!Tateti methodsFor: 'winning' stamp: 'NSM 5/20/2019 23:04:25'!
positionsOccupyInverseDiagonal: positions
	^positions allSatisfy: [ :position | position x = position y].! !

!Tateti methodsFor: 'winning' stamp: 'NSM 5/20/2019 23:13:09'!
positionsOccupyRow: positions.
	^positions allSatisfy: [ :position |
		position x = positions first x
	].! !

!Tateti methodsFor: 'winning' stamp: 'NSM 5/20/2019 21:19:49'!
xHasWon
	^ self hasWonPlayer: #X.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Tateti class' category: #Tateti!
Tateti class
	instanceVariableNames: ''!

!Tateti class methodsFor: 'exception messages' stamp: 'NSM 5/20/2019 18:35:55'!
occupiedPositionExceptionMessage
	^'The position is already occupied by another piece'! !

!Tateti class methodsFor: 'exception messages' stamp: 'NSM 5/20/2019 19:07:14'!
playersMustInterleave
	^'Players must go one after another interleaving'! !


!Tateti class methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 19:16:01'!
XMustStart
	^'X must be the first to make a move'! !
