!classDefinition: #TerniLapilliTests category: #TerniLapilli!
TestCase subclass: #TerniLapilliTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 13:54:30'!
test01AtCreationShouldNotBeEnded
	| tateti |
	tateti _ TerniLapilli new.
	self deny: tateti hasEnded.! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 13:54:51'!
test02ShouldAddInXPosition
 	| jugada tateti |
	tateti _ TerniLapilli new.
	jugada _ 2@3.
	tateti addXAt: jugada.
	self assert: (tateti isXAt: jugada). ! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 13:55:11'!
test03XPositionNotAddedShouldBeEmpty
 	| tateti libre |
	tateti _ TerniLapilli new.
	libre _ 1@3.
	self deny: (tateti isXAt: libre). ! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 14:00:10'!
test04ShouldNotAddXWhenAddingO
 	| tateti jugada1 jugada2 |
	tateti _ TerniLapilli new.
	jugada1 _ 1@3.
	jugada2 _ 1@2.
	tateti addXAt: jugada1 .
	tateti addOAt: jugada2.
	self deny: (tateti isXAt: jugada2). ! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 14:00:56'!
test05OPositionNotAddedShouldBeEmpty
 	| tateti jugada |
	tateti _ TerniLapilli new.
	jugada _ 1@3.
	self deny: (tateti isOAt: jugada). ! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 14:01:21'!
test06CantAddOOnPositionOccupiedByX
 	| tateti jugada |
	tateti _ TerniLapilli new.
	jugada _ 1@3.
	tateti addXAt: jugada.
	self should: [tateti addOAt: jugada] raise: Error withExceptionDo: [:exception| self assert: exception messageText equals: TerniLapilli occupiedPositionExceptionMessage].
! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 14:01:43'!
test07CantAddXOnPositionOccupiedByX
 	| tateti jugada jugada2 |
	tateti _ TerniLapilli new.
	jugada _ 1@3.
	tateti addXAt: jugada.
	jugada2 _ 3@3.
	tateti addOAt: jugada2.
	self should: [tateti addXAt: jugada] raise: Error withExceptionDo: [:exception| self assert: exception messageText equals: TerniLapilli occupiedPositionExceptionMessage].
	! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 14:15:55'!
test08CantAddXOnPositionOccupiedByO
 	| tateti jugada jugada2 |
	tateti _ TerniLapilli new.
	jugada _ 1@3.
	jugada2 _ 2@3.
	tateti addXAt: jugada.
	tateti addOAt:  jugada2 .
	self should: [tateti addXAt: jugada2] raise: Error withExceptionDo: [:exception| self assert: exception messageText equals: TerniLapilli occupiedPositionExceptionMessage].
! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 14:02:30'!
test09ShouldAddOPosition
 	| tateti jugada jugada2 |
	tateti _ TerniLapilli new.
	jugada _ 1@3.
	tateti addXAt: jugada.
	jugada2 _ 3@3.
	tateti addOAt: jugada2.
	self assert: (tateti isOAt: jugada2).
	
	! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 14:16:28'!
test10AddingTwoXPositionsShouldAddBoth
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

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 14:16:33'!
test11ShouldAddManyPositions
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

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 14:16:44'!
test12CantAddOTwice
 	| tateti jugada jugada2 jugada3 |
	tateti _ TerniLapilli new.
	jugada _ 1@3.
	jugada2 _ 2@3.
	jugada3 _ 3@3.
	tateti addXAt: jugada.
	tateti addOAt:  jugada2 .
	self should: [tateti addOAt: jugada3] raise: Error withExceptionDo: [:exception| self assert: exception messageText equals: TerniLapilli playersMustInterleave ].
! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 14:15:37'!
test13CantAddXTwice
 	| tateti jugada jugada2 |
	tateti _ TerniLapilli new.
	jugada _ 1@3.
	jugada2 _ 1@2.
	tateti addXAt: jugada.
	self should: [tateti addXAt: jugada2] raise: Error withExceptionDo: [:exception| self assert: exception messageText equals: TerniLapilli playersMustInterleave].
	! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 14:05:30'!
test14XShouldBeFirstPlayer
 	| tateti jugada |
	tateti _ TerniLapilli new.
	jugada _ 1@3.
	self should: [tateti addOAt: jugada] raise: Error withExceptionDo: [:exception| self assert: exception messageText equals: TerniLapilli XMustStart].
! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 14:17:15'!
test15XWinningByPlacingInColumn1
 	| tateti |
	tateti _ self simulateGame: {1@3. 2@2. 1@2. 3@1. 1@1}.
	self assert: tateti hasEnded.
	self assert: tateti xHasWon.
! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 14:17:24'!
test16XWinningByPlacingInOtherColumns
 	| tateti |
	tateti _ self simulateGame: {3@3. 2@2. 3@2. 1@1. 3@1}.
	self assert: tateti hasEnded.
	self assert: tateti xHasWon.
! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 14:17:50'!
test17XWinningByPlacingInSameRow
 	| tateti |
	tateti _ self simulateGame: {2@2. 3@1. 3@2. 1@1. 1@2}.
	self assert: tateti hasEnded.
	self assert: tateti xHasWon.
! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 14:18:05'!
test18OWinningByPlacingInSameRow
 	| tateti |
	tateti _ self simulateGame: {2@2. 1@3. 3@2. 2@3. 1@1. 3@3}.
	self assert: tateti hasEnded.
	self assert: tateti oHasWon.
! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 14:18:31'!
test19OWinningByDiagonal
 	| tateti |
	tateti _ self simulateGame: {1@2. 2@2. 1@3. 1@1. 2@3. 3@3}.
	self assert: tateti hasEnded.
	self assert: tateti oHasWon.
! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 14:18:47'!
test20XWinningByInverseDiagonalInOrder
 	| tateti |
	tateti _ self simulateGame: {1@3. 2@3. 2@2. 1@1. 3@1}.
	self assert: tateti hasEnded.
	self assert: tateti xHasWon.
! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 14:19:29'!
test21NoneShouldHaveWonAtTheStart
	| tateti  |
	tateti _ TerniLapilli new.
	self deny: tateti xHasWon.
	self deny: tateti oHasWon.! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 14:19:55'!
test22NoneShouldHaveWonWhenPlayingJustOneMove
	| tateti  |
	tateti _ self simulateGame: {1@1}.
	
	self deny: tateti xHasWon.
	self deny: tateti oHasWon.! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 14:20:03'!
test23NoneShouldHaveWonWhenPlacing3PiecesEach
 	| tateti |
	tateti _ self simulateGame: {1@2. 3@2. 1@3. 1@1. 2@3. 3@3}.
	self deny: tateti hasEnded.
	self deny: tateti xHasWon.
	self deny: tateti oHasWon.
! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 14:20:21'!
test24XShouldNotHaveWonWhenOWon
 	| tateti |
	tateti _ self simulateGame: {1@2. 2@2. 1@3. 1@1. 2@3. 3@3}.
	self assert: tateti hasEnded.
	self deny: tateti xHasWon.
! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 14:20:35'!
test25CantAddAnXAtXBoardPositionBelow1
 	| tateti position |
	tateti _ TerniLapilli new.
	position _ 0@1. 
	self 
		should: [ tateti addXAt: position ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: (TerniLapilli invalidPositionExceptionMessage: position) equals: exception messageText ].
! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 14:20:39'!
test26CantAddAnXAtXBoardPositionOver3
 	| tateti position |
	tateti _ TerniLapilli new.
	position _ 4@1. 
	self 
		should: [ tateti addXAt: position ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: (TerniLapilli invalidPositionExceptionMessage: position) equals: exception messageText ].
! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 14:20:43'!
test27CantAddAnXAtYBoardPositionOutOfRange
 	| tateti position |
	tateti _ TerniLapilli new.
	position _ 3@-1. 
	self 
		should: [ tateti addXAt: position ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: (TerniLapilli invalidPositionExceptionMessage: position) equals: exception messageText ].
! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 14:20:48'!
test28CantAddAnOAtBoardPositionOutOfRange
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

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/22/2019 14:20:53'!
test29AddedPositionCoordinatesMustBeIntegers
 	| tateti position |
	tateti _ TerniLapilli new.
	position _ 1.5@3. 
	self 
		should: [ tateti addXAt: position ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: (TerniLapilli invalidPositionExceptionMessage: position) equals: exception messageText ].
! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/23/2019 01:45:02'!
test30XSlidingToValidPosition
 	| tateti newPosition oPositions xPositions |
	xPositions _ {1@2. 1@3. 2@3}.
	oPositions _ {2@2. 2@1. 3@3}.
	tateti _ self simulateGameWithXPositions: xPositions andOPositions: oPositions.
	"
	X | X | O      X | X | O
	- - - - -      - - - - - 
	X | O |    ->    | O |
	- - - - -      - - - - - 
	  | O |        X | O |   
	"
	newPosition _ 1@1.
	tateti slideFrom: 1@2 to: newPosition.

	xPositions at: 1 put: newPosition.
	self assert: tateti hasXAtPositions: xPositions andOAtPositions: oPositions. 
! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/23/2019 01:44:43'!
test31OSlidingToValidPosition
 	| tateti newOPosition oPositions xPositions newXPosition |
	xPositions _ {1@2. 1@3. 2@3}.
	oPositions _ {2@2. 2@1. 3@3}.
	tateti _ self simulateGameWithXPositions: xPositions andOPositions: oPositions.
	"
	X | X | O      X | X | O
	- - - - -      - - - - - 
	X | O |    ->    |   | O
	- - - - -      - - - - - 
	  | O |        X | O |   
	"
	newXPosition _ 1@1.
	tateti slideFrom: 1@2 to: newXPosition.
	newOPosition _ 3@2.
	tateti slideFrom: 2@2 to: newOPosition.
	
	oPositions at: 1 put: newOPosition.
	xPositions at: 1 put: newXPosition.
	self assert: tateti hasXAtPositions: xPositions andOAtPositions: oPositions.! !


!TerniLapilliTests methodsFor: 'assertions' stamp: 'EB 5/23/2019 01:49:15'!
assert: aCollection allSatisfy: aBlock
	aCollection do: [ :boardPosition |
		self assert: (aBlock value: boardPosition).	
	].! !

!TerniLapilliTests methodsFor: 'assertions' stamp: 'EB 5/23/2019 01:52:38'!
assert: aTerniLapilli hasXAtPositions: xBoardPositions andOAtPositions: oBoardPositions
	self assert: oBoardPositions allSatisfy: [ :boardPosition | aTerniLapilli isOAt: boardPosition]. 
	self assert: xBoardPositions allSatisfy: [ :boardPosition | aTerniLapilli isXAt: boardPosition]. 
	! !


!TerniLapilliTests methodsFor: 'game simulation' stamp: 'NSM 5/21/2019 20:07:32'!
simulateGame: plays 
	| tateti |
	tateti _ TerniLapilli new.
	plays withIndexDo: [ :play :index | index odd ifTrue: [ tateti addXAt: play ] ifFalse: [ tateti addOAt: play ]].
	^ tateti.! !

!TerniLapilliTests methodsFor: 'game simulation' stamp: 'EB 5/23/2019 01:40:47'!
simulateGameWithXPositions: xBoardPositions andOPositions: oBoardPositions
	| tateti |
	tateti _ TerniLapilli new.
	xBoardPositions with: oBoardPositions do: [ :xPosition :oPosition |
		tateti addXAt: xPosition.
		tateti addOAt: oPosition.
	].
	^tateti! !


!classDefinition: #LastPlayed category: #TerniLapilli!
Object subclass: #LastPlayed
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!LastPlayed methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 19:48:56'!
playO
	self subclassResponsibility.! !

!LastPlayed methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 19:48:44'!
playX
	self subclassResponsibility.! !


!LastPlayed methodsFor: 'initialization' stamp: 'EB 5/23/2019 02:01:03'!
initializeWithTerniLapilli: aTerniLapilli
	terniLapilli _ aTerniLapilli.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LastPlayed class' category: #TerniLapilli!
LastPlayed class
	instanceVariableNames: ''!

!LastPlayed class methodsFor: 'instance creation' stamp: 'EB 5/23/2019 02:04:44'!
withTerniLapilli: aTerniLapilli
	^self new initializeWithTerniLapilli: aTerniLapilli.! !


!classDefinition: #NoneLastPlayed category: #TerniLapilli!
LastPlayed subclass: #NoneLastPlayed
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!NoneLastPlayed methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 20:07:32'!
playO
	self error: TerniLapilli XMustStart.! !

!NoneLastPlayed methodsFor: 'as yet unclassified' stamp: 'EB 5/23/2019 02:04:12'!
playX
	^XLastPlayed withTerniLapilli: terniLapilli.! !


!classDefinition: #OLastPlayed category: #TerniLapilli!
LastPlayed subclass: #OLastPlayed
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!OLastPlayed methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 20:07:31'!
playO
	self error: TerniLapilli playersMustInterleave! !

!OLastPlayed methodsFor: 'as yet unclassified' stamp: 'EB 5/23/2019 02:03:41'!
playX
	^XLastPlayed withTerniLapilli: terniLapilli.! !

!OLastPlayed methodsFor: 'as yet unclassified' stamp: 'EB 5/23/2019 02:02:53'!
slideFrom: originalBoardPosition to: newBoardPosition
	terniLapilli slideXFrom: originalBoardPosition to: newBoardPosition.! !


!classDefinition: #XLastPlayed category: #TerniLapilli!
LastPlayed subclass: #XLastPlayed
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!XLastPlayed methodsFor: 'as yet unclassified' stamp: 'EB 5/23/2019 02:03:52'!
playO
	^OLastPlayed withTerniLapilli: terniLapilli.! !

!XLastPlayed methodsFor: 'as yet unclassified' stamp: 'NSM 5/21/2019 20:07:32'!
playX
	self error: TerniLapilli playersMustInterleave.! !

!XLastPlayed methodsFor: 'as yet unclassified' stamp: 'EB 5/23/2019 02:07:00'!
slideFrom: originalBoardPosition to: newBoardPosition
	terniLapilli slideOFrom: originalBoardPosition to: newBoardPosition.! !


!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'lastPlayed piecePositions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'initialization' stamp: 'EB 5/23/2019 02:05:21'!
initialize
	piecePositions _ Dictionary new.
	piecePositions add: #X -> Set new; add: #O -> Set new.
	lastPlayed _ NoneLastPlayed withTerniLapilli: self.! !


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

!TerniLapilli methodsFor: 'player actions' stamp: 'EB 5/23/2019 02:11:40'!
slide: aPlayer from: originalBoardPosition to: newBoardPosition
	piecePositions at: aPlayer :: remove: originalBoardPosition; add: newBoardPosition.! !

!TerniLapilli methodsFor: 'player actions' stamp: 'EB 5/23/2019 01:58:10'!
slideFrom: originalBoardPosition to: newBoardPosition 
	lastPlayed slideFrom: originalBoardPosition to: newBoardPosition. ! !

!TerniLapilli methodsFor: 'player actions' stamp: 'EB 5/23/2019 02:12:00'!
slideOFrom: originalBoardPosition to: newBoardPosition 
	self slide: #O from: originalBoardPosition to: newBoardPosition.! !

!TerniLapilli methodsFor: 'player actions' stamp: 'EB 5/23/2019 02:12:11'!
slideXFrom: originalBoardPosition to: newBoardPosition 
	self slide: #X from: originalBoardPosition to: newBoardPosition.
	lastPlayed _ lastPlayed playX.! !


!TerniLapilli methodsFor: 'evaluating' stamp: 'EB 5/23/2019 01:54:04'!
is: aPiece at: aBoardPosition 
	^piecePositions at: aPiece :: includes: aBoardPosition.! !

!TerniLapilli methodsFor: 'evaluating' stamp: 'EB 5/23/2019 01:53:56'!
isOAt: aBoardPosition 
	^self is: #O at: aBoardPosition.! !

!TerniLapilli methodsFor: 'evaluating' stamp: 'EB 5/23/2019 01:54:16'!
isXAt: aBoardPosition 
	^self is: #X at: aBoardPosition.! !


!TerniLapilli methodsFor: 'assertions' stamp: 'NSM 5/22/2019 02:14:25'!
assertPositionInsideBoard: aBoardPosition
	self isPositionInsideBoard: aBoardPosition :: ifFalse: [
		self raiseInvalidPositionError: aBoardPosition.].! !

!TerniLapilli methodsFor: 'assertions' stamp: 'EB 5/23/2019 00:21:14'!
assertPositionNotOccupied: aBoardPosition
	(self isPositionOccupied: aBoardPosition) ifTrue: [
		self raiseOccupiedError.].! !

!TerniLapilli methodsFor: 'assertions' stamp: 'EB 5/22/2019 13:53:30'!
isCoordinateInsideBoard: aCoordinate
	^aCoordinate >= 1 and: aCoordinate <= 3 and: aCoordinate isInteger.! !

!TerniLapilli methodsFor: 'assertions' stamp: 'NSM 5/22/2019 02:12:59'!
isPositionInsideBoard: aBoardPosition
	^(self isCoordinateInsideBoard: aBoardPosition x) and: 
		(self isCoordinateInsideBoard: aBoardPosition y).! !

!TerniLapilli methodsFor: 'assertions' stamp: 'EB 5/23/2019 00:19:39'!
isPositionOccupied: aBoardPosition
	^(self isXAt: aBoardPosition ) or: (self isOAt: aBoardPosition).! !


!TerniLapilli methodsFor: 'error raising' stamp: 'NSM 5/22/2019 02:13:55'!
raiseInvalidPositionError: aBoardPosition
	self error: (self class invalidPositionExceptionMessage: aBoardPosition).! !

!TerniLapilli methodsFor: 'error raising' stamp: 'NSM 5/20/2019 18:35:55'!
raiseOccupiedError
	self error: self class occupiedPositionExceptionMessage.! !


!TerniLapilli methodsFor: 'winning' stamp: 'EB 5/23/2019 01:23:45'!
allEqualsInSet: aSet by: aCollectingBlock
	^aSet collect: aCollectingBlock :: size = 1.! !

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

!TerniLapilli methodsFor: 'winning' stamp: 'EB 5/23/2019 01:24:32'!
positionsOccupyColumn: positionsToCheck
	^self allEqualsInSet: positionsToCheck by: [ :piecePosition | piecePosition y].! !

!TerniLapilli methodsFor: 'winning' stamp: 'NSM 5/20/2019 23:15:12'!
positionsOccupyDiagonal: positions
	^positions allSatisfy: [ :position | (position x + position y) = 4 ]. ! !

!TerniLapilli methodsFor: 'winning' stamp: 'NSM 5/20/2019 23:04:25'!
positionsOccupyInverseDiagonal: positions
	^positions allSatisfy: [ :position | position x = position y].! !

!TerniLapilli methodsFor: 'winning' stamp: 'EB 5/23/2019 01:24:57'!
positionsOccupyRow: positions.
	^self allEqualsInSet: positions by: [ :position | position x ].! !

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
