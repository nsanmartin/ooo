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

!TerniLapilliTests methodsFor: 'tests' stamp: 'nsm 5/25/2019 17:04:32'!
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
	tateti slideXFrom: 1@2 to: newPosition.

	xPositions at: 1 put: newPosition.
	self assert: tateti hasXAtPositions: xPositions andOAtPositions: oPositions. 
! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'nsm 5/25/2019 17:04:55'!
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
	tateti slideXFrom: 1@2 to: newXPosition.
	newOPosition _ 3@2.
	tateti slideOFrom: 2@2 to: newOPosition.
	
	oPositions at: 1 put: newOPosition.
	xPositions at: 1 put: newXPosition.
	self assert: tateti hasXAtPositions: xPositions andOAtPositions: oPositions.! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'nsm 5/25/2019 17:05:26'!
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
	tateti slideXFrom: 1@2 to: 1@1.
	newOPosition _ 3@2.
	tateti slideOFrom: 2@2 to: newOPosition.
	tateti slideXFrom: 1@1 to: 1@2.
	
	oPositions at: 1 put: newOPosition.
	self assert: tateti hasXAtPositions: xPositions andOAtPositions: oPositions.! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'nsm 5/25/2019 17:05:35'!
test33CantSlideFromUnoccupiedPosition
 	| tateti unoccupiedPosition |
	tateti _ self simulateGame: {1@1. 1@2. 1@3. 2@1. 2@2. 2@3}.
	unoccupiedPosition _ 3@1.
	self 
		should: [tateti slideXFrom: unoccupiedPosition to: 3@2]
		raise: Error
		withMessageText: (TerniLapilli unoccupiedPositionExceptionMessage: unoccupiedPosition).! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'nsm 5/25/2019 17:05:43'!
test34CantSlideToPositionOutsideBoard
 	| tateti oPositions xPositions newXPosition |
	xPositions _ {1@2. 1@3. 2@3}.
	oPositions _ {2@2. 2@1. 3@3}.
	tateti _ self simulateGameWithXPositions: xPositions andOPositions: oPositions.
	newXPosition _ 0@2.
	self 
		should: [tateti slideXFrom: 1@2 to: newXPosition]
		raise: Error
		withMessageText: (TerniLapilli invalidPositionExceptionMessage: newXPosition).! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'nsm 5/25/2019 17:08:35'!
test35CantSlideToNotNeighboringPositionInFirstCoordinate
 	| tateti oPositions xPositions newXPosition originalXPosition |
	xPositions _ {1@2. 1@3. 2@3}.
	oPositions _ {2@2. 2@1. 3@3}.
	tateti _ self simulateGameWithXPositions: xPositions andOPositions: oPositions.
	originalXPosition _ 1@2.
	newXPosition _ 3@2.
	self 
		should: [tateti slideXFrom: originalXPosition to: newXPosition]
		raise: Error
		withMessageText: (TerniLapilli notNeighboringPositionsExceptionMessageWith: originalXPosition and: newXPosition).! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'nsm 5/25/2019 17:08:51'!
test36CantSlideToNotNeighboringPositionInSecondCoordinate
 	| tateti newXPosition originalXPosition |
	tateti _ self simulateGame: {1@1. 1@2. 1@3. 2@1. 3@3. 2@3}.
	originalXPosition _ 3@3.
	newXPosition _ 3@1.
	self 
		should: [tateti slideXFrom: originalXPosition to: newXPosition]
		raise: Error
		withMessageText: (TerniLapilli notNeighboringPositionsExceptionMessageWith: originalXPosition and: newXPosition).! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'nsm 5/25/2019 17:08:55'!
test37CantSlideToOccupiedPosition
 	| tateti oPositions xPositions |
	xPositions _ {1@2. 1@3. 2@3}.
	oPositions _ {2@2. 2@1. 3@3}.
	tateti _ self simulateGameWithXPositions: xPositions andOPositions: oPositions.
	self 
		should: [tateti slideXFrom: 1@2 to: 2@2]
		raise: Error
		withMessageText: (TerniLapilli occupiedPositionExceptionMessage).! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'nsm 5/25/2019 17:09:00'!
test38CantSlideWhenStarting
 	| tateti |
	tateti _ TerniLapilli new.
	self 
		should: [tateti slideXFrom: 1@2 to: 2@2]
		raise: Error
		withMessageText: (TerniLapilli shouldAddAllBeforeSlidingExceptionMessage).! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'nsm 5/25/2019 17:09:06'!
test39CantSlideBeforeAddingAllPieces
 	| tateti |
	tateti _ self simulateGame: {1@2. 2@3.}.
	self 
		should: [tateti slideXFrom: 1@2 to: 2@2]
		raise: Error
		withMessageText: (TerniLapilli shouldAddAllBeforeSlidingExceptionMessage).! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/24/2019 01:09:49'!
test40CantAddAfterAddingAllPieces
 	| tateti |
	tateti _ self simulateGame: {1@1. 1@2. 1@3. 2@1. 2@2. 2@3.}.
	self 
		should: [tateti addXAt: 3@3]
		raise: Error
		withMessageText: (TerniLapilli cantAddMoreThanThreePiecesExceptionMessage).! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'EB 5/24/2019 01:13:46'!
test41CantAddAfterFinishingGame
 	| tateti |
	tateti _ self simulateGame: {1@1. 1@2. 2@2. 2@3. 3@3}.
	self 
		should: [tateti addOAt: 2@1]
		raise: Error
		withMessageText: TerniLapilli cantPlayAfterFinishingGameExceptionMessage.! !

!TerniLapilliTests methodsFor: 'tests' stamp: 'nsm 5/25/2019 17:09:14'!
test42CantSlideAfterFinishingGame
 	| tateti |
	tateti _ self simulateGame: {1@1. 1@2. 1@3. 2@2. 2@3. 3@2.}.
	self 
		should: [tateti slideXFrom: 1@1 to: 2@1]
		raise: Error
		withMessageText: TerniLapilli cantPlayAfterFinishingGameExceptionMessage.! !


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


!classDefinition: #GamePhase category: #TerniLapilli!
Object subclass: #GamePhase
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!GamePhase methodsFor: 'sliding' stamp: 'nsm 5/25/2019 17:44:11'!
slideOFrom: originalBoardPosition to: newBoardPosition
	self subclassResponsibility.! !

!GamePhase methodsFor: 'sliding' stamp: 'nsm 5/25/2019 17:23:04'!
slideXFrom: originalBoardPosition to: newBoardPosition
	self subclassResponsibility.! !


!GamePhase methodsFor: 'initialization' stamp: 'nsm 5/25/2019 16:47:07'!
initializeFor: aTerniLapilli
	terniLapilli _ aTerniLapilli.! !


!GamePhase methodsFor: 'adding' stamp: 'nsm 5/25/2019 17:02:19'!
addOAt: aBoardPosition
	self subclassResponsibility.! !

!GamePhase methodsFor: 'adding' stamp: 'nsm 5/25/2019 17:01:56'!
addXAt: aBoardPosition
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GamePhase class' category: #TerniLapilli!
GamePhase class
	instanceVariableNames: ''!

!GamePhase class methodsFor: 'instance creation' stamp: 'nsm 5/25/2019 16:51:34'!
for: aTerniLapilli
	^self new initializeFor: aTerniLapilli.! !


!GamePhase class methodsFor: 'phase selection' stamp: 'nsm 5/25/2019 16:46:30'!
phaseFor: aTerniLapilli
	^(self subclasses detect: [ :subclass | subclass canHandle: aTerniLapilli ]) for: aTerniLapilli.! !


!classDefinition: #AddingGamePhase category: #TerniLapilli!
GamePhase subclass: #AddingGamePhase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!AddingGamePhase methodsFor: 'sliding' stamp: 'nsm 5/25/2019 17:39:37'!
slideOFrom: originalBoardPosition to: newBoardPosition
	terniLapilli slideOOnAddingPhaseFrom: originalBoardPosition to: newBoardPosition.! !

!AddingGamePhase methodsFor: 'sliding' stamp: 'nsm 5/25/2019 17:18:05'!
slideXFrom: originalBoardPosition to: newBoardPosition
	terniLapilli slideXOnAddingPhaseFrom: originalBoardPosition to: newBoardPosition.! !


!AddingGamePhase methodsFor: 'adding' stamp: 'nsm 5/25/2019 16:47:14'!
addOAt: aBoardPosition
	terniLapilli addOOnAddingPhaseAt: aBoardPosition.! !

!AddingGamePhase methodsFor: 'adding' stamp: 'nsm 5/25/2019 16:57:59'!
addXAt: aBoardPosition
	terniLapilli addXOnAddingPhaseAt: aBoardPosition.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AddingGamePhase class' category: #TerniLapilli!
AddingGamePhase class
	instanceVariableNames: ''!

!AddingGamePhase class methodsFor: 'phase selection' stamp: 'nsm 5/25/2019 17:25:21'!
canHandle: aTerniLapilli
	^aTerniLapilli oPositions size < 3 and: aTerniLapilli hasEnded not.! !


!classDefinition: #EndedGamePhase category: #TerniLapilli!
GamePhase subclass: #EndedGamePhase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!EndedGamePhase methodsFor: 'sliding' stamp: 'nsm 5/25/2019 17:39:19'!
slideOFrom: originalBoardPosition to: newBoardPosition 
	terniLapilli slideOOnEndedPhaseFrom: originalBoardPosition to: newBoardPosition.! !

!EndedGamePhase methodsFor: 'sliding' stamp: 'nsm 5/25/2019 17:23:53'!
slideXFrom: originalBoardPosition to: newBoardPosition 
	terniLapilli slideXOnEndedPhaseFrom: originalBoardPosition to: newBoardPosition.! !


!EndedGamePhase methodsFor: 'adding' stamp: 'nsm 5/25/2019 17:26:52'!
addOAt: aBoardPosition
	terniLapilli addOOnEndedPhaseAt: aBoardPosition.	! !

!EndedGamePhase methodsFor: 'adding' stamp: 'nsm 5/25/2019 17:43:36'!
addXAt: aBoardPosition
	terniLapilli addXOnEndedPhaseAt: aBoardPosition.	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EndedGamePhase class' category: #TerniLapilli!
EndedGamePhase class
	instanceVariableNames: ''!

!EndedGamePhase class methodsFor: 'phase selection' stamp: 'nsm 5/25/2019 17:24:32'!
canHandle: aTerniLapilli
	^aTerniLapilli hasEnded.! !


!classDefinition: #SlidingGamePhase category: #TerniLapilli!
GamePhase subclass: #SlidingGamePhase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!SlidingGamePhase methodsFor: 'sliding' stamp: 'nsm 5/25/2019 17:31:15'!
slideOFrom: originalBoardPosition to: newBoardPosition 
	terniLapilli slideOOnSlidingPhaseFrom: originalBoardPosition to: newBoardPosition.! !

!SlidingGamePhase methodsFor: 'sliding' stamp: 'nsm 5/25/2019 17:15:01'!
slideXFrom: originalBoardPosition to: newBoardPosition 
	terniLapilli slideXOnSlidingPhaseFrom: originalBoardPosition to: newBoardPosition.! !


!SlidingGamePhase methodsFor: 'adding' stamp: 'nsm 5/25/2019 17:43:58'!
addOAt: aBoardPosition
	^terniLapilli addOOnSlidingPhaseAt: aBoardPosition.! !

!SlidingGamePhase methodsFor: 'adding' stamp: 'nsm 5/25/2019 16:57:13'!
addXAt: aBoardPosition
	^terniLapilli addXOnSlidingPhaseAt: aBoardPosition.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SlidingGamePhase class' category: #TerniLapilli!
SlidingGamePhase class
	instanceVariableNames: ''!

!SlidingGamePhase class methodsFor: 'phase selection' stamp: 'nsm 5/25/2019 17:25:08'!
canHandle: aTerniLapilli
	^aTerniLapilli oPositions size = 3 and: aTerniLapilli hasEnded not.! !


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


!TerniLapilli methodsFor: 'adding' stamp: 'nsm 5/25/2019 16:53:30'!
addOAt: aBoardPosition
	self phase addOAt: aBoardPosition.! !

!TerniLapilli methodsFor: 'adding' stamp: 'nsm 5/25/2019 16:53:48'!
addOOnAddingPhaseAt: aBoardPosition
	lastPlayed _ lastPlayed playO.
	self addPieceType: #O at: aBoardPosition. ! !

!TerniLapilli methodsFor: 'adding' stamp: 'nsm 5/25/2019 17:41:59'!
addOOnEndedPhaseAt: aBoardPosition
	self addOnEndedPhaseAt: aBoardPosition.! !

!TerniLapilli methodsFor: 'adding' stamp: 'nsm 5/25/2019 17:42:28'!
addOOnSlidingPhaseAt: aBoardPosition
	self addOnSlidingPhaseAt: aBoardPosition.! !

!TerniLapilli methodsFor: 'adding' stamp: 'nsm 5/25/2019 17:41:42'!
addOnEndedPhaseAt: aBoardPosition
	self raiseCantPlayAfterFinishingGameError.! !

!TerniLapilli methodsFor: 'adding' stamp: 'nsm 5/25/2019 17:42:14'!
addOnSlidingPhaseAt: aBoardPosition
	self raiseCantAddMoreThanThreePiecesError.! !

!TerniLapilli methodsFor: 'adding' stamp: 'nsm 5/25/2019 17:38:06'!
addPieceType: aPieceType at: aBoardPosition
	self assertPositionInsideBoard: aBoardPosition.
	self assertPositionNotOccupied: aBoardPosition.
	(piecePositions at: aPieceType) add: aBoardPosition.! !

!TerniLapilli methodsFor: 'adding' stamp: 'nsm 5/25/2019 16:59:04'!
addXAt: aBoardPosition
	self phase addXAt: aBoardPosition.! !

!TerniLapilli methodsFor: 'adding' stamp: 'nsm 5/25/2019 16:59:13'!
addXOnAddingPhaseAt: aBoardPosition 
	lastPlayed _ lastPlayed playX.
	self addPieceType: #X at: aBoardPosition.! !

!TerniLapilli methodsFor: 'adding' stamp: 'nsm 5/25/2019 17:42:05'!
addXOnEndedPhaseAt: aBoardPosition
	self addOnEndedPhaseAt: aBoardPosition.! !

!TerniLapilli methodsFor: 'adding' stamp: 'nsm 5/25/2019 17:42:33'!
addXOnSlidingPhaseAt: aBoardPosition
	self addOnSlidingPhaseAt: aBoardPosition.! !


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

!TerniLapilli methodsFor: 'assertions' stamp: 'nsm 5/25/2019 17:33:26'!
assertCanSlideFrom: originalBoardPosition to: newBoardPosition
	self assert: newBoardPosition isNeighborOf: originalBoardPosition.
	self assertPositionInsideBoard: newBoardPosition.
	self assertPositionNotOccupied: newBoardPosition.

! !

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


!TerniLapilli methodsFor: 'error raising' stamp: 'EB 5/24/2019 01:06:36'!
raiseCantAddMoreThanThreePiecesError
	self error: self class cantAddMoreThanThreePiecesExceptionMessage.! !

!TerniLapilli methodsFor: 'error raising' stamp: 'EB 5/24/2019 01:19:11'!
raiseCantPlayAfterFinishingGameError
	self error: self class cantPlayAfterFinishingGameExceptionMessage.! !

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


!TerniLapilli methodsFor: 'accessing' stamp: 'nsm 5/25/2019 16:49:46'!
oPositions
	^piecePositions at: #O.! !

!TerniLapilli methodsFor: 'accessing' stamp: 'nsm 5/25/2019 16:52:49'!
phase
	^GamePhase phaseFor: self.! !


!TerniLapilli methodsFor: 'sliding' stamp: 'EB 5/23/2019 12:50:35'!
inCollection: aCollection replace: originalObject with: aNewObject ifAbsent: aBlock
	^aCollection remove: originalObject ifAbsent: aBlock; add: aNewObject.! !

!TerniLapilli methodsFor: 'sliding' stamp: 'EB 5/23/2019 12:54:15'!
slide: aPlayer from: originalBoardPosition to: newBoardPosition
	self inCollection: (piecePositions at: aPlayer)
		replace: originalBoardPosition
		with: newBoardPosition
		ifAbsent: [ self raiseUnoccupiedError: originalBoardPosition ].! !

!TerniLapilli methodsFor: 'sliding' stamp: 'nsm 5/25/2019 17:32:36'!
slideOFrom: originalBoardPosition to: newBoardPosition 
	self phase slideOFrom: originalBoardPosition to: newBoardPosition.! !

!TerniLapilli methodsFor: 'sliding' stamp: 'nsm 5/25/2019 17:36:03'!
slideOOnAddingPhaseFrom: originalBoardPosition to: newBoardPosition
	self slideOnAddingPhaseFrom: originalBoardPosition to: newBoardPosition.! !

!TerniLapilli methodsFor: 'sliding' stamp: 'nsm 5/25/2019 17:36:24'!
slideOOnEndedPhaseFrom: originalBoardPosition to: newBoardPosition
	self slideOnEndedPhaseFrom: originalBoardPosition to: newBoardPosition.! !

!TerniLapilli methodsFor: 'sliding' stamp: 'nsm 5/25/2019 17:33:57'!
slideOOnSlidingPhaseFrom: originalBoardPosition to: newBoardPosition
	self assertCanSlideFrom: originalBoardPosition to: newBoardPosition.

	self slide: #O from: originalBoardPosition to: newBoardPosition.
	lastPlayed _ lastPlayed playO.	! !

!TerniLapilli methodsFor: 'sliding' stamp: 'nsm 5/25/2019 17:35:11'!
slideOnAddingPhaseFrom: originalBoardPosition to: newBoardPosition
	self raiseShouldAddAllBeforeSlidingError.! !

!TerniLapilli methodsFor: 'sliding' stamp: 'nsm 5/25/2019 17:35:22'!
slideOnEndedPhaseFrom: originalBoardPosition to: newBoardPosition
	self raiseCantPlayAfterFinishingGameError.! !

!TerniLapilli methodsFor: 'sliding' stamp: 'nsm 5/25/2019 17:20:29'!
slideXFrom: originalBoardPosition to: newBoardPosition 
	self phase slideXFrom: originalBoardPosition to: newBoardPosition.! !

!TerniLapilli methodsFor: 'sliding' stamp: 'nsm 5/25/2019 17:35:44'!
slideXOnAddingPhaseFrom: originalBoardPosition to: newBoardPosition
	self slideOnAddingPhaseFrom: originalBoardPosition to: newBoardPosition.! !

!TerniLapilli methodsFor: 'sliding' stamp: 'nsm 5/25/2019 17:36:40'!
slideXOnEndedPhaseFrom: originalBoardPosition to: newBoardPosition
	self slideOnEndedPhaseFrom: originalBoardPosition to: newBoardPosition.! !

!TerniLapilli methodsFor: 'sliding' stamp: 'nsm 5/25/2019 17:33:47'!
slideXOnSlidingPhaseFrom: originalBoardPosition to: newBoardPosition
	self assertCanSlideFrom: originalBoardPosition to: newBoardPosition.

	self slide: #X from: originalBoardPosition to: newBoardPosition.
	lastPlayed _ lastPlayed playX.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #TerniLapilli!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'exception messages' stamp: 'EB 5/24/2019 01:02:27'!
cantAddMoreThanThreePiecesExceptionMessage
	^'Can''t add more than three pieces per player.'.! !

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


!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'EB 5/24/2019 01:14:26'!
cantPlayAfterFinishingGameExceptionMessage
	^'Game has already finished.'.! !
