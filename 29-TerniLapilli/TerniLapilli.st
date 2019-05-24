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

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/23/2019 13:00:32'!
test06CantAddOOnPositionOccupiedByX
 	| tateti jugada |
	tateti _ TerniLapilli new.
	jugada _ 1@3.
	tateti addXAt: jugada.
	self 
		should: [tateti addOAt: jugada]
		raise: Error 
		withMessageText: TerniLapilli occupiedPositionExceptionMessage.
! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/23/2019 13:00:53'!
test07CantAddXOnPositionOccupiedByX
 	| tateti jugada jugada2 |
	tateti _ TerniLapilli new.
	jugada _ 1@3.
	tateti addXAt: jugada.
	jugada2 _ 3@3.
	tateti addOAt: jugada2.
	self 
		should: [tateti addXAt: jugada]
		raise: Error 
		withMessageText: TerniLapilli occupiedPositionExceptionMessage.
	! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/23/2019 13:01:11'!
test08CantAddXOnPositionOccupiedByO
 	| tateti jugada jugada2 |
	tateti _ TerniLapilli new.
	jugada _ 1@3.
	jugada2 _ 2@3.
	tateti addXAt: jugada.
	tateti addOAt:  jugada2 .
	self 
		should: [tateti addXAt: jugada2]
		raise: Error 
		withMessageText: TerniLapilli occupiedPositionExceptionMessage.
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

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/23/2019 19:53:53'!
test12CantAddOTwice
 	| tateti jugada jugada2 jugada3 |
	tateti _ TerniLapilli new.
	jugada _ 1@3.
	jugada2 _ 2@3.
	jugada3 _ 3@3.
	tateti addXAt: jugada.
	tateti addOAt:  jugada2 .
	self should: [tateti addOAt: jugada3] 
		raise: Error 
		withMessageText: (TerniLapilli exceptionMessageCurrentPlayerIs: #X andNot: #O).
! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/23/2019 19:57:00'!
test13CantAddXTwice
 	| tateti jugada jugada2 |
	tateti _ TerniLapilli new.
	jugada _ 1@3.
	jugada2 _ 1@2.
	tateti addXAt: jugada.
	self should: [tateti addXAt: jugada2] 
		raise: Error 
		withMessageText: (TerniLapilli exceptionMessageCurrentPlayerIs: #O andNot: #X).
	! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/23/2019 19:58:08'!
test14XShouldBeFirstPlayer
 	| tateti jugada |
	tateti _ TerniLapilli new.
	jugada _ 1@3.
	self should: [tateti addOAt: jugada] 
		raise: Error 
		withMessageText: (TerniLapilli exceptionMessageCurrentPlayerIs: #X andNot: #O).
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

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/23/2019 13:00:03'!
test25CantAddAnXAtXBoardPositionBelow1
 	| tateti position |
	tateti _ TerniLapilli new.
	position _ 0@1. 
	self 
		should: [ tateti addXAt: position ]
		raise: Error
		withMessageText: (TerniLapilli invalidPositionExceptionMessage: position).
! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/23/2019 13:01:53'!
test26CantAddAnXAtXBoardPositionOver3
 	| tateti position |
	tateti _ TerniLapilli new.
	position _ 4@1. 
	self 
		should: [ tateti addXAt: position ]
		raise: Error
		withMessageText: (TerniLapilli invalidPositionExceptionMessage: position).
! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/23/2019 13:02:10'!
test27CantAddAnXAtYBoardPositionOutOfRange
 	| tateti position |
	tateti _ TerniLapilli new.
	position _ 3@-1. 
	self 
		should: [ tateti addXAt: position ]
		raise: Error
		withMessageText: (TerniLapilli invalidPositionExceptionMessage: position).
! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/23/2019 13:02:28'!
test28CantAddAnOAtBoardPositionOutOfRange
 	| tateti position |
	tateti _ TerniLapilli new.
	position _ -2@5.
	tateti addXAt: 1@3. 
	self 
		should: [ tateti addOAt: position ]
		raise: Error
		withMessageText: (TerniLapilli invalidPositionExceptionMessage: position).
! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/23/2019 13:02:43'!
test29AddedPositionCoordinatesMustBeIntegers
 	| tateti position |
	tateti _ TerniLapilli new.
	position _ 1.5@3. 
	self 
		should: [ tateti addXAt: position ]
		raise: Error
		withMessageText: (TerniLapilli invalidPositionExceptionMessage: position).
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

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/23/2019 13:31:39'!
test32XSlidingAfterOSliding
 	| tateti newOPosition oPositions xPositions |
	xPositions _ {1@2. 1@3. 2@3}.
	oPositions _ {2@2. 2@1. 3@3}.
	tateti _ self simulateGameWithXPositions: xPositions andOPositions: oPositions.
	"
	X | X | O      X | X | O
	- - - - -      - - - - - 
	X | O |    ->  X |   | O
	- - - - -      - - - - - 
	  | O |          | O |   
	"
	tateti slideFrom: 1@2 to: 1@1.
	newOPosition _ 3@2.
	tateti slideFrom: 2@2 to: newOPosition.
	tateti slideFrom: 1@1 to: 1@2.
	
	oPositions at: 1 put: newOPosition.
	self assert: tateti hasXAtPositions: xPositions andOAtPositions: oPositions.! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/23/2019 13:03:26'!
test33CantSlideFromUnoccupiedPosition
 	| tateti unoccupiedPosition |
	tateti _ self simulateGame: {1@1. 1@2. 1@3. 2@1. 2@2. 2@3}.
	unoccupiedPosition _ 3@1.
	self 
		should: [tateti slideFrom: unoccupiedPosition to: 3@2]
		raise: Error
		withMessageText: (TerniLapilli unoccupiedPositionExceptionMessage: unoccupiedPosition).! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/23/2019 13:31:50'!
test34CantSlideToPositionOutsideBoard
 	| tateti oPositions xPositions newXPosition |
	xPositions _ {1@2. 1@3. 2@3}.
	oPositions _ {2@2. 2@1. 3@3}.
	tateti _ self simulateGameWithXPositions: xPositions andOPositions: oPositions.
	newXPosition _ 0@2.
	self 
		should: [tateti slideFrom: 1@2 to: newXPosition]
		raise: Error
		withMessageText: (TerniLapilli invalidPositionExceptionMessage: newXPosition).! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/23/2019 18:09:38'!
test35CantSlideToNotNeighboringPositionInFirstCoordinate
 	| tateti oPositions xPositions newXPosition originalXPosition |
	xPositions _ {1@2. 1@3. 2@3}.
	oPositions _ {2@2. 2@1. 3@3}.
	tateti _ self simulateGameWithXPositions: xPositions andOPositions: oPositions.
	originalXPosition _ 1@2.
	newXPosition _ 3@2.
	self 
		should: [tateti slideFrom: originalXPosition to: newXPosition]
		raise: Error
		withMessageText: (TerniLapilli notNeighboringPositionsExceptionMessageWith: originalXPosition and: newXPosition).! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/23/2019 18:18:52'!
test36CantSlideToNotNeighboringPositionInSecondCoordinate
 	| tateti newXPosition originalXPosition |
	tateti _ self simulateGame: {1@1. 1@2. 1@3. 2@1. 3@3. 2@3}.
	originalXPosition _ 3@3.
	newXPosition _ 3@1.
	self 
		should: [tateti slideFrom: originalXPosition to: newXPosition]
		raise: Error
		withMessageText: (TerniLapilli notNeighboringPositionsExceptionMessageWith: originalXPosition and: newXPosition).! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/23/2019 19:13:43'!
test37CantSlideToOccupiedPosition
 	| tateti oPositions xPositions |
	xPositions _ {1@2. 1@3. 2@3}.
	oPositions _ {2@2. 2@1. 3@3}.
	tateti _ self simulateGameWithXPositions: xPositions andOPositions: oPositions.
	self 
		should: [tateti slideFrom: 1@2 to: 2@2]
		raise: Error
		withMessageText: (TerniLapilli occupiedPositionExceptionMessage).! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/23/2019 19:23:09'!
test38CantSlideWhenStarting
 	| tateti |
	tateti _ TerniLapilli new.
	self 
		should: [tateti slideFrom: 1@2 to: 2@2]
		raise: Error
		withMessageText: (TerniLapilli shouldAddAllBeforeSlidingExceptionMessage).! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/23/2019 19:27:53'!
test39CantSlideBeforeAddingAllPieces
 	| tateti |
	tateti _ self simulateGame: {1@2. 2@3.}.
	self 
		should: [tateti slideFrom: 1@2 to: 2@2]
		raise: Error
		withMessageText: (TerniLapilli shouldAddAllBeforeSlidingExceptionMessage).! !


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

!TerniLapilliTests methodsFor: 'assertions' stamp: 'EB 5/23/2019 12:57:16'!
should: aBlock raise: anExceptionClass withMessageText: anErrorMessageText
	self should: aBlock 
		raise: Error
		withExceptionDo: [ :exception |
			self assert: anErrorMessageText equals: exception messageText.
		].! !


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


!classDefinition: #CurrentPlayer category: #TerniLapilli!
Object subclass: #CurrentPlayer
	instanceVariableNames: 'gamePhase terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!CurrentPlayer methodsFor: 'player actions' stamp: 'NSM 5/21/2019 19:48:56'!
playO
	self subclassResponsibility.! !

!CurrentPlayer methodsFor: 'player actions' stamp: 'NSM 5/21/2019 19:48:44'!
playX
	self subclassResponsibility.! !

!CurrentPlayer methodsFor: 'player actions' stamp: 'EB 5/23/2019 12:18:16'!
slideFrom: originalBoardPosition to: newBoardPosition
	self subclassResponsibility.! !


!CurrentPlayer methodsFor: 'initialization' stamp: 'EB 5/23/2019 20:41:03'!
initializeWithTerniLapilli: aTerniLapilli
	terniLapilli _ aTerniLapilli.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CurrentPlayer class' category: #TerniLapilli!
CurrentPlayer class
	instanceVariableNames: ''!

!CurrentPlayer class methodsFor: 'instance creation' stamp: 'EB 5/23/2019 20:50:26'!
withTerniLapilli: aTerniLapilli
	^self new initializeWithTerniLapilli: aTerniLapilli.! !


!classDefinition: #OCurrentPlayer category: #TerniLapilli!
CurrentPlayer subclass: #OCurrentPlayer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!OCurrentPlayer methodsFor: 'player actions' stamp: 'EB 5/23/2019 19:58:53'!
playO
	^XCurrentPlayer withTerniLapilli: terniLapilli.! !

!OCurrentPlayer methodsFor: 'player actions' stamp: 'EB 5/23/2019 19:57:40'!
playX
	self error: (terniLapilli class exceptionMessageCurrentPlayerIs: #O andNot: #X).! !

!OCurrentPlayer methodsFor: 'player actions' stamp: 'EB 5/23/2019 02:07:00'!
slideFrom: originalBoardPosition to: newBoardPosition
	terniLapilli slideOFrom: originalBoardPosition to: newBoardPosition.! !


!classDefinition: #XCurrentPlayer category: #TerniLapilli!
CurrentPlayer subclass: #XCurrentPlayer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!XCurrentPlayer methodsFor: 'player actions' stamp: 'EB 5/23/2019 19:56:26'!
playO
	self error: (terniLapilli class exceptionMessageCurrentPlayerIs: #X andNot: #O).! !

!XCurrentPlayer methodsFor: 'player actions' stamp: 'EB 5/23/2019 19:59:03'!
playX
	^OCurrentPlayer withTerniLapilli: terniLapilli.! !

!XCurrentPlayer methodsFor: 'player actions' stamp: 'EB 5/23/2019 02:02:53'!
slideFrom: originalBoardPosition to: newBoardPosition
	terniLapilli slideXFrom: originalBoardPosition to: newBoardPosition.! !


!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'lastPlayed piecePositions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'initialization' stamp: 'EB 5/23/2019 19:58:53'!
initialize
	piecePositions _ Dictionary new.
	piecePositions add: #X -> Set new; add: #O -> Set new.
	lastPlayed _ XCurrentPlayer withTerniLapilli: self.! !


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

!TerniLapilli methodsFor: 'player actions' stamp: 'EB 5/23/2019 12:50:35'!
inCollection: aCollection replace: originalObject with: aNewObject ifAbsent: aBlock
	^aCollection remove: originalObject ifAbsent: aBlock; add: aNewObject.! !

!TerniLapilli methodsFor: 'player actions' stamp: 'EB 5/23/2019 12:54:15'!
slide: aPlayer from: originalBoardPosition to: newBoardPosition
	self inCollection: (piecePositions at: aPlayer)
		replace: originalBoardPosition
		with: newBoardPosition
		ifAbsent: [ self raiseUnoccupiedError: originalBoardPosition ].! !

!TerniLapilli methodsFor: 'player actions' stamp: 'EB 5/23/2019 19:42:02'!
slideFrom: originalBoardPosition to: newBoardPosition 
	self assertPositionInsideBoard: newBoardPosition.
	self assert: newBoardPosition isNeighborOf: originalBoardPosition.
	self assertPositionNotOccupied: newBoardPosition.
	self assertAddingPhaseFinished.
	lastPlayed slideFrom: originalBoardPosition to: newBoardPosition. ! !

!TerniLapilli methodsFor: 'player actions' stamp: 'EB 5/23/2019 13:30:39'!
slideOFrom: originalBoardPosition to: newBoardPosition 
	self slide: #O from: originalBoardPosition to: newBoardPosition.
	lastPlayed _ lastPlayed playO.! !

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


!TerniLapilli methodsFor: 'assertions' stamp: 'EB 5/23/2019 19:42:50'!
areAllPiecesAddedForPlayer: aPlayer
	^(piecePositions at: aPlayer) size = 3.! !

!TerniLapilli methodsFor: 'assertions' stamp: 'EB 5/23/2019 18:43:12'!
assert: aNeighborBoardPosition isNeighborOf: anOriginalBoardPosition
	self is: aNeighborBoardPosition aNeighborOf: anOriginalBoardPosition :: ifFalse: [
		self raiseNotNeighboringPositionsErrorWith: anOriginalBoardPosition and: aNeighborBoardPosition
	].! !

!TerniLapilli methodsFor: 'assertions' stamp: 'EB 5/23/2019 19:43:24'!
assertAddingPhaseFinished
	(self areAllPiecesAddedForPlayer: #X) and: (self areAllPiecesAddedForPlayer: #O) :: ifFalse: [
		self raiseShouldAddAllBeforeSlidingError.
	].! !

!TerniLapilli methodsFor: 'assertions' stamp: 'NSM 5/22/2019 02:14:25'!
assertPositionInsideBoard: aBoardPosition
	self isPositionInsideBoard: aBoardPosition :: ifFalse: [
		self raiseInvalidPositionError: aBoardPosition.].! !

!TerniLapilli methodsFor: 'assertions' stamp: 'EB 5/23/2019 00:21:14'!
assertPositionNotOccupied: aBoardPosition
	(self isPositionOccupied: aBoardPosition) ifTrue: [
		self raiseOccupiedError.].! !

!TerniLapilli methodsFor: 'assertions' stamp: 'EB 5/23/2019 18:42:53'!
is: aNeighboringBoardPosition aNeighborOf: anOriginalBoardPosition
	^(self is: aNeighboringBoardPosition x aNeighboringCoordinateOf: anOriginalBoardPosition x) and: 
	(self is: aNeighboringBoardPosition y aNeighboringCoordinateOf: anOriginalBoardPosition y).! !

!TerniLapilli methodsFor: 'assertions' stamp: 'EB 5/23/2019 18:36:49'!
is: aNeighboringCoordinate aNeighboringCoordinateOf: anOriginalCoordinate
	^(aNeighboringCoordinate - anOriginalCoordinate) abs <= 1.! !

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

!TerniLapilli methodsFor: 'error raising' stamp: 'EB 5/23/2019 18:28:10'!
raiseNotNeighboringPositionsErrorWith: anOriginalBoardPosition and: aNeighborBoardPosition
	self error: (
		self class 
			notNeighboringPositionsExceptionMessageWith: anOriginalBoardPosition 
			and: aNeighborBoardPosition
	).! !

!TerniLapilli methodsFor: 'error raising' stamp: 'NSM 5/20/2019 18:35:55'!
raiseOccupiedError
	self error: self class occupiedPositionExceptionMessage.! !

!TerniLapilli methodsFor: 'error raising' stamp: 'EB 5/23/2019 19:34:56'!
raiseShouldAddAllBeforeSlidingError
	self error: self class shouldAddAllBeforeSlidingExceptionMessage.! !

!TerniLapilli methodsFor: 'error raising' stamp: 'EB 5/23/2019 12:54:15'!
raiseUnoccupiedError: aBoardPosition
	self error: (self class unoccupiedPositionExceptionMessage: aBoardPosition).! !


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

!TerniLapilli class methodsFor: 'exception messages' stamp: 'EB 5/23/2019 19:55:31'!
exceptionMessageCurrentPlayerIs: aCurrentPlayer andNot: aNonCurrentPlayer 
	^aNonCurrentPlayer asString, ' can''t, play; it''s ', aCurrentPlayer asString, '''s turn.'.! !

!TerniLapilli class methodsFor: 'exception messages' stamp: 'NSM 5/22/2019 01:58:44'!
invalidPositionExceptionMessage: anInvalidBoardPosition
	^'There''s no position in the board at ', anInvalidBoardPosition asString.! !

!TerniLapilli class methodsFor: 'exception messages' stamp: 'EB 5/23/2019 17:23:12'!
notNeighboringPositionsExceptionMessageWith: originalBoardPosition and: newBoardPosition 
	^newBoardPosition asString, ' is not a neighboring position of ', originalBoardPosition asString.! !

!TerniLapilli class methodsFor: 'exception messages' stamp: 'NSM 5/20/2019 18:35:55'!
occupiedPositionExceptionMessage
	^'The position is already occupied by another piece'! !

!TerniLapilli class methodsFor: 'exception messages' stamp: 'NSM 5/20/2019 19:07:14'!
playersMustInterleave
	^'Players must go one after another interleaving'! !

!TerniLapilli class methodsFor: 'exception messages' stamp: 'EB 5/23/2019 19:19:23'!
shouldAddAllBeforeSlidingExceptionMessage
	^'Can''t slide pieces before adding all pieces to the board.'! !

!TerniLapilli class methodsFor: 'exception messages' stamp: 'EB 5/23/2019 12:41:58'!
unoccupiedPositionExceptionMessage: aBoardPosition 
	^'There''s no piece at position ', aBoardPosition asString, '.'.! !
