!classDefinition: #TerniLapilliTests category: #TerniLapilli!
TestCase subclass: #TerniLapilliTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 20:07:32'!
simulateGame: plays 
	| tateti |
	tateti _ TerniLapilli new.
	plays withIndexDo: [ :play :index | index odd ifTrue: [ tateti addXAt: play ] ifFalse: [ tateti addOAt: play ]].
	^ tateti.! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 20:07:32'!
test01
	| tateti |
	tateti _ TerniLapilli new.
	self deny: tateti hasEnded.! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 20:07:31'!
test02
 	| jugada tateti |
	tateti _ TerniLapilli new.
	jugada _ 2@3.
	tateti addXAt: jugada.
	self assert: (tateti isXAt: jugada). ! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 20:07:32'!
test03
 	| tateti libre |
	tateti _ TerniLapilli new.
	libre _ 1@3.
	self deny: (tateti isXAt: libre). ! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 20:07:31'!
test04
 	| tateti jugada1 jugada2 |
	tateti _ TerniLapilli new.
	jugada1 _ 1@3.
	jugada2 _ 1@2.
	tateti addXAt: jugada1 .
	tateti addOAt: jugada2.
	self deny: (tateti isXAt: jugada2). ! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 20:07:31'!
test05
 	| tateti jugada |
	tateti _ TerniLapilli new.
	jugada _ 1@3.
	self deny: (tateti isOAt: jugada). ! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 20:07:32'!
test06
 	| tateti jugada |
	tateti _ TerniLapilli new.
	jugada _ 1@3.
	tateti addXAt: jugada.
	self should: [tateti addOAt: jugada] raise: Error withExceptionDo: [:exception| self assert: exception messageText equals: TerniLapilli occupiedPositionExceptionMessage].
! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 20:07:31'!
test07
 	| tateti jugada jugada2 |
	tateti _ TerniLapilli new.
	jugada _ 1@3.
	tateti addXAt: jugada.
	jugada2 _ 3@3.
	tateti addOAt: jugada2.
	self should: [tateti addXAt: jugada] raise: Error withExceptionDo: [:exception| self assert: exception messageText equals: TerniLapilli occupiedPositionExceptionMessage].
	! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 20:07:31'!
test08
 	| tateti jugada jugada2 jugada3 |
	tateti _ TerniLapilli new.
	jugada _ 1@3.
	tateti addXAt: jugada.
	jugada2 _ 3@3.
	tateti addOAt: jugada2.
	jugada3 _ 2@2.
	tateti addXAt: jugada3.
	self assert: (tateti isXAt: jugada).
	self assert: (tateti isXAt: jugada3).
	
	! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 20:07:31'!
test09
 	| tateti jugada jugada2 |
	tateti _ TerniLapilli new.
	jugada _ 1@3.
	tateti addXAt: jugada.
	jugada2 _ 3@3.
	tateti addOAt: jugada2.
	self assert: (tateti isOAt: jugada2).
	
	! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 20:07:31'!
test10
 	| tateti jugada jugada2 jugada3 jugada4 jugada5 |
	tateti _ TerniLapilli new.
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

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 20:07:31'!
test11
 	| tateti jugada2 jugada1 |
	tateti _ TerniLapilli new.
	jugada1 _ 1@2.
	jugada2 _ 1@3.
	tateti  addXAt: jugada1.
	tateti  addOAt:  jugada2 .
	self assert: (tateti isOAt: jugada2). ! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 20:07:32'!
test12
 	| tateti jugada jugada2 |
	tateti _ TerniLapilli new.
	jugada _ 1@3.
	jugada2 _ 1@2.
	tateti addXAt: jugada.
	self should: [tateti addXAt: jugada2] raise: Error withExceptionDo: [:exception| self assert: exception messageText equals: TerniLapilli playersMustInterleave].
	! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 20:07:31'!
test13
 	| tateti jugada jugada2 |
	tateti _ TerniLapilli new.
	jugada _ 1@3.
	jugada2 _ 2@3.
	tateti addXAt: jugada.
	tateti addOAt:  jugada2 .
	self should: [tateti addXAt: jugada2] raise: Error withExceptionDo: [:exception| self assert: exception messageText equals: TerniLapilli occupiedPositionExceptionMessage].
! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 20:07:31'!
test14
 	| tateti jugada |
	tateti _ TerniLapilli new.
	jugada _ 1@3.
	self should: [tateti addOAt: jugada] raise: Error withExceptionDo: [:exception| self assert: exception messageText equals: TerniLapilli XMustStart].
! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 20:07:31'!
test15
 	| tateti jugada jugada2 jugada3 |
	tateti _ TerniLapilli new.
	jugada _ 1@3.
	jugada2 _ 2@3.
	jugada3 _ 3@3.
	tateti addXAt: jugada.
	tateti addOAt:  jugada2 .
	self should: [tateti addOAt: jugada3] raise: Error withExceptionDo: [:exception| self assert: exception messageText equals: TerniLapilli playersMustInterleave ].
! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 20:16:04'!
test16
 	| tateti |
	tateti _ self simulateGame: {1@3. 2@3. 2@2. 1@1. 3@1}.
	self assert: tateti hasEnded.
	self assert: tateti xHasWon.
! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 20:26:44'!
test17
 	| tateti |
	tateti _ self simulateGame: {1@2. 2@2. 1@3. 1@1. 2@3. 3@3}.
	self assert: tateti hasEnded.
	self assert: tateti oHasWon.
! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 20:07:31'!
test18
	| tateti  |
	tateti _ TerniLapilli new.
	self deny: tateti xHasWon.
	self deny: tateti oHasWon.! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 20:35:16'!
test19
	| tateti  |
	tateti _ self simulateGame: {1@1}.
	
	self deny: tateti xHasWon.
	self deny: tateti oHasWon.! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 20:46:17'!
test20
 	| tateti |
	tateti _ self simulateGame: {1@2. 2@2. 1@3. 1@1. 2@3. 3@3}.
	self assert: tateti hasEnded.
	self deny: tateti xHasWon.
! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 20:50:00'!
test21
 	| tateti |
	tateti _ self simulateGame: {1@2. 3@2. 1@3. 1@1. 2@3. 3@3}.
	self deny: tateti hasEnded.
	self deny: tateti xHasWon.
	self deny: tateti oHasWon.
! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 20:58:25'!
test22
 	| tateti |
	tateti _ self simulateGame: {1@3. 2@2. 1@2. 3@1. 1@1}.
	self assert: tateti hasEnded.
	self assert: tateti xHasWon.
! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 21:00:45'!
test23
 	| tateti |
	tateti _ self simulateGame: {3@3. 2@2. 3@2. 1@1. 3@1}.
	self assert: tateti hasEnded.
	self assert: tateti xHasWon.
! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 21:02:35'!
test24
 	| tateti |
	tateti _ self simulateGame: {2@2. 3@1. 3@2. 1@1. 1@2}.
	self assert: tateti hasEnded.
	self assert: tateti xHasWon.
! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 21:04:50'!
test25
 	| tateti |
	tateti _ self simulateGame: {2@2. 1@3. 3@2. 2@3. 1@1. 3@3}.
	self assert: tateti hasEnded.
	self assert: tateti oHasWon.
! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/22/2019 02:02:47'!
test26CantAddAnXAtXBoardPositionBelow1
 	| tateti position |
	tateti _ TerniLapilli new.
	position _ 0@1. 
	self 
		should: [ tateti addXAt: position ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: (TerniLapilli invalidPositionExceptionMessage: position) equals: exception messageText ].
! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/22/2019 02:02:58'!
test27CantAddAnXAtXBoardPositionOver3
 	| tateti position |
	tateti _ TerniLapilli new.
	position _ 4@1. 
	self 
		should: [ tateti addXAt: position ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: (TerniLapilli invalidPositionExceptionMessage: position) equals: exception messageText ].
! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/22/2019 02:03:07'!
test28CantAddAnXAtInvalidYBoardPosition
 	| tateti position |
	tateti _ TerniLapilli new.
	position _ 3@-1. 
	self 
		should: [ tateti addXAt: position ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: (TerniLapilli invalidPositionExceptionMessage: position) equals: exception messageText ].
! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NSM 5/22/2019 02:04:10'!
test29CantAddAnOAtInvalidBoardPosition
 	| tateti position |
	tateti _ TerniLapilli new.
	position _ -2@5.
	tateti addXAt: 1@3. 
	self 
		should: [ tateti addOAt: position ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: (TerniLapilli invalidPositionExceptionMessage: position) equals: exception messageText ].
! !


!classDefinition: #LastPlayed category: #TerniLapilli!
Object subclass: #LastPlayed
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!LastPlayed methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 19:48:56'!
playO
	self subclassResponsibility.! !

!LastPlayed methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 19:48:44'!
playX
	self subclassResponsibility.! !


!classDefinition: #NoneLastPlayed category: #TerniLapilli!
LastPlayed subclass: #NoneLastPlayed
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!NoneLastPlayed methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 20:07:32'!
playO
	self error: TerniLapilli XMustStart.! !

!NoneLastPlayed methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 19:48:44'!
playX
	^XLastPlayed new.! !


!classDefinition: #OLastPlayed category: #TerniLapilli!
LastPlayed subclass: #OLastPlayed
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!OLastPlayed methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 20:07:31'!
playO
	self error: TerniLapilli playersMustInterleave! !

!OLastPlayed methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 19:48:44'!
playX
	^XLastPlayed new.! !


!classDefinition: #XLastPlayed category: #TerniLapilli!
LastPlayed subclass: #XLastPlayed
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!XLastPlayed methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 19:48:56'!
playO
	^OLastPlayed new.! !

!XLastPlayed methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 20:07:32'!
playX
	self error: TerniLapilli playersMustInterleave.! !


!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'lastPlayed piecePositions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'initialization' stamp: 'NSM 5/21/2019 19:25:03'!
initialize
	piecePositions _ Dictionary new.
	piecePositions add: #X -> OrderedCollection new; add: #O -> OrderedCollection new.
	lastPlayed _ NoneLastPlayed new.! !


!TerniLapilli methodsFor: 'player actions' stamp: 'NSM 5/22/2019 02:06:41'!
addOAt: aBoardPosition
	lastPlayed _ lastPlayed playO.
	self addPieceType: #O at: aBoardPosition.! !

!TerniLapilli methodsFor: 'player actions' stamp: 'NSM 5/22/2019 02:08:30'!
addPieceType: aPieceType at: aBoardPosition
	self assertPositionInsideBoard: aBoardPosition.
	self assertPositionNotOccupied: aBoardPosition.
	piecePositions at: aPieceType :: add: aBoardPosition.! !

!TerniLapilli methodsFor: 'player actions' stamp: 'NSM 5/22/2019 02:06:51'!
addXAt: aBoardPosition
	lastPlayed _ lastPlayed playX.
	self addPieceType: #X at: aBoardPosition.! !


!TerniLapilli methodsFor: 'evaluating' stamp: 'NSM 5/20/2019 19:46:02'!
isOAt: aBoardPosition 
	^piecePositions at: #O :: includes: aBoardPosition.! !

!TerniLapilli methodsFor: 'evaluating' stamp: 'NSM 5/20/2019 19:45:35'!
isXAt: aBoardPosition 
	^piecePositions at: #X :: includes: aBoardPosition.! !


!TerniLapilli methodsFor: 'assertions' stamp: 'NSM 5/22/2019 02:14:25'!
assertPositionInsideBoard: aBoardPosition
	self isPositionInsideBoard: aBoardPosition :: ifFalse: [
		self raiseInvalidPositionError: aBoardPosition.].! !

!TerniLapilli methodsFor: 'assertions' stamp: 'NSM 5/20/2019 19:47:27'!
assertPositionNotOccupied: aBoardPosition
	(self isXAt: aBoardPosition ) or: (self isOAt: aBoardPosition) :: ifTrue: [
		self raiseOccupiedError.
	].! !

!TerniLapilli methodsFor: 'assertions' stamp: 'NSM 5/22/2019 02:12:59'!
isCoordinateInsideBoard: aCoordinate
	^aCoordinate >= 1 and: aCoordinate <= 3.! !

!TerniLapilli methodsFor: 'assertions' stamp: 'NSM 5/22/2019 02:12:59'!
isPositionInsideBoard: aBoardPosition
	^(self isCoordinateInsideBoard: aBoardPosition x) and: 
		(self isCoordinateInsideBoard: aBoardPosition y).! !


!TerniLapilli methodsFor: 'error raising' stamp: 'NSM 5/22/2019 02:13:55'!
raiseInvalidPositionError: aBoardPosition
	self error: (self class invalidPositionExceptionMessage: aBoardPosition).! !

!TerniLapilli methodsFor: 'error raising' stamp: 'NSM 5/20/2019 18:35:55'!
raiseOccupiedError
	self error: self class occupiedPositionExceptionMessage.! !


!TerniLapilli methodsFor: 'winning' stamp: 'NSM 5/20/2019 20:57:38'!
hasEnded
	^self oHasWon or: self xHasWon.! !

!TerniLapilli methodsFor: 'winning' stamp: 'NSM 5/20/2019 23:14:21'!
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

!TerniLapilli methodsFor: 'winning' stamp: 'NSM 5/21/2019 19:42:05'!
oHasWon
	^ self hasWonPlayer: #O.! !

!TerniLapilli methodsFor: 'winning' stamp: 'NSM 5/20/2019 23:14:03'!
positionsOccupyColumn: positionsToCheck
	^positionsToCheck allSatisfy: [ :piecePosition | piecePosition y = positionsToCheck first y].! !

!TerniLapilli methodsFor: 'winning' stamp: 'NSM 5/20/2019 23:15:12'!
positionsOccupyDiagonal: positions
	^positions allSatisfy: [ :position | (position x + position y) = 4 ]. ! !

!TerniLapilli methodsFor: 'winning' stamp: 'NSM 5/20/2019 23:04:25'!
positionsOccupyInverseDiagonal: positions
	^positions allSatisfy: [ :position | position x = position y].! !

!TerniLapilli methodsFor: 'winning' stamp: 'NSM 5/20/2019 23:13:09'!
positionsOccupyRow: positions.
	^positions allSatisfy: [ :position |
		position x = positions first x
	].! !

!TerniLapilli methodsFor: 'winning' stamp: 'NSM 5/20/2019 21:19:49'!
xHasWon
	^ self hasWonPlayer: #X.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #TerniLapilli!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'exception messages' stamp: 'NSM 5/22/2019 01:58:44'!
invalidPositionExceptionMessage: anInvalidBoardPosition
	^'There''s no position in the board at ', anInvalidBoardPosition asString.! !

!TerniLapilli class methodsFor: 'exception messages' stamp: 'NSM 5/20/2019 18:35:55'!
occupiedPositionExceptionMessage
	^'The position is already occupied by another piece'! !

!TerniLapilli class methodsFor: 'exception messages' stamp: 'NSM 5/20/2019 19:07:14'!
playersMustInterleave
	^'Players must go one after another interleaving'! !


!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'NSM 5/20/2019 19:16:01'!
XMustStart
	^'X must be the first to make a move'! !
