require_relative 'Piece'
require 'set'
require_relative 'Rook'
class King < Piece

    ## Unit of movement for king
    @@kingUnit = 1

    ## Attribute reader for kingHasMoved instance var
    attr_reader :kingHasMoved

    def initialize(position, color)
        super(position, color)
        @kingHasMoved = false
    end

    ## Checks if the board is currently in a check
	## Check in all directional patterns from the king (i.e. vertical, horinzontally, diagonally, and also L shaped)
	## Look across all patterns infinitely until you hit A) a friendly piece B) an enemy piece (at which point you must verify it is not giving check)
	## or C) until you fall off the board. The edge case here is horses, do not check L shaped infinitely, just a unit of 1. 
	def isCheck(gameBoard)
		## Iterate over all directions from the king
        movementDir.each do |direction|
            possibleAttackingPiece = enemyPieceOnLine(direction, gameBoard)
            if(possibleAttackingPiece != nil)
                
                if(possibleAttackingPiece.is_a(Knight))
                ## Horses can't attack from any of the king's movement dirs (horizontal, vertically, diagonally)
                next
                
                elsif(possibleAttackingPiece.is_a(King))
                ## Here, we can quickly just check if the x difference and y difference are both at most 1 away
                enemyX,enemyY = possibleAttackingPiece.position
                currX, currY = position

                xDist = (currX - enemyX).abs
                yDist = (currY - enemyY).abs

                    ## We have found a check, so no need to look further
                    if(xDist <=1 && yDist <= 1)
                        return true

                    end



                elsif(possibleAttackPiece.is_a(Pawn))  
                    ## Here, we can just rapidly check if we are diagonally forward to thsi pawn
                    directionArr = Pawn.movementDir
                    ## Either each move it adds +1 to its x or -1 to its x
                    forwardVector = directionArr[0]

                    ## Get the diagonal squares of the pawn
                    pawnPos = pawn.position

                    pawnX,pawnY = pawnPos

                    ## If pawn is advancing in a way that +1 to row each time, then, the diagonal square it attacks
                    ## have the row current row + 1. If the pawn is advancing in a way that  - 1 to its row each time,
                    ## then, the diagonal square it attacks have row current row - 1. Of course, the column of the squares
                    ## the pawn attacks are simply to the left and right of the current column
                    diagonal1 = [pawnX + forwardVector, pawnY + 1]
                    diagonal2 = [pawnx + forwardVector, pawny - 1]

                    ## If the king's position is the same as the squares this pawn is attacking, then we are in check
                    if(position == diagonal1 || position == diagonal2)
                        return true
                    end
                
                
                ## Handles all sliding pieces - there is a direct line to enemy rook,queen,bishop
                else
                    ## Invert the direction
                    dirFromEnemyPerspective = [direction[0] * -1, direction[1] * -1]

                    ## Check if this is an element of the piece's movementDir (i.e. can the piece move down this line towards the king)
                    possibleAttackingPiece.movementDir.include?(dirFromEnemyPerspective)
                    ## At this point you know the pieces can (1) see eachother accross this line (2) The other piece can slide accross the line (this else case only contains sliding pieces), so we are in check
                    return true


                end


            end

        end

        ## Now, since the ways horses attack lay outside of the 8 directions into the king, we will check those separately.
        ## (I.e. checking horzitonal, vertical, and diagonals to the king do not include the places horses can check from)
        horseAttacks = [
            [2,1],
            [1,2],
            [1,-2],
            [2,-1],
            [-1, -2],
            [-1, 2],
            [-2, -1],
            [-2, 1]
        ]

        horseAttacks.each do |attack|
            ## Add the vector to kings current position and see if theres a enemy horse there
            containsHorse = [position[0] + attack[0], position[1] + attack[1]]
            ## First verify that this square is valid so we don't index out of bounds, and then check if theres a piece there
            if(gameBoard.inBounds(containsHorse) && gameBoard.pieceAt(containsHorse) != nil)
                ## Now, check if theres a enemy horse. If there is, we are in check
                if(gameBoard.pieceAt(containsHorse).is_a(Knight) && gameBoard.pieceAt(containsHorse).color != color)
                    return true

                end

            end
        end



        ## If none of those checks yield that we are in check, then we are not in check

        return false



	end

    ## Return the piece 
    def enemyPieceOnLine(direction, gameBoard)
        movesFromLine = Array.new()
        
        directionX, directionY = direction

        nextX = position[0]
        nextY = position[1]

        7.times do
            nextX = nextX + directionX
            nextY = nextY + directionY
            ## First check if this square is in bounds
            if(gameBoard.inBounds([nextX, nextY]))
                ## Next, obtain the piece (or nil) at the square. If theres no piece, we will keep looking along line
                if(gameBoard.isEmptySquare([nextX, nextY]))
                    next
                ## Else case is if the next square to be examined contains a piece. If the piece is an enemy, then we have
                ## encountered the first enemy piece on the line, so return it. If the piece is friendly, just return because
                ## there is no check along this line, as the first piece encountered is friendly. 
                else
                    if(gameBoard.pieceColor([nextX, nextY]) != color)
                        return gameBoard.pieceAt([nextX, nextY])
                    else
                        return nil
                    end
                    
                end
            else
                ## If we hit an out of bounds, we will break out of the loop, because we have checked accross the line and couldn't find a piece
                ## so, we will break out of the loop and return nil, as there is no pieces on this line 
                break
        
            end
        end

        return nil
    

    end

    def pseudoLegalMoves(gameBoard)
        ## Call the super-classes's implementation which checks all the "regular" straight line moves
        print "Calling the super classes implementation of pseduo legal moves\n"
        
        pseudoLegalMovesSet = super(gameBoard, @@kingUnit)

        print "Is the returned set nil?: " + pseudoLegalMovesSet.nil?.to_s

        ## Then, check castling and add if necessary

        castlingPseudoLegal(gameBoard).each do |castlingMove|
            pseudoLegalMovesSet.add(castlingMove)
        end


        ## Return the pseduoLegalMoves
        return pseudoLegalMovesSet

    end


    def legalMove(destLoc, gameBoard)
        

    end

    ## Overriden from superclass, special case where if it is a castling move we must check two boards
    def causesCheck(destLoc, gameBoard)
        ## If a pseudo legal move of the king moves more than a square along the x-axis, the pseudo legal move in question is castling
        isCastlingMove = (destLoc[x] - position[x]).abs > 1

        if(isCastlingMove)
            ## Check two boards
        else
            ## Check one board
        end

    end

    


    def castlingPseudoLegal(gameBoard)

        pseudoLegalCastles = Array.new()

        ## The column value for both rooks (regardless if white or black)
        firstFileRookCol = 0
        eighthFileRookCol = 7

        ## If the king has not moved, then castling is still valid. King is sitting on same row as rooks
        if(!kingHasMoved)
            kingRow = position[0]
            kingCol = position[1]

            ## Obtain the piece at the position both kingside and queenside rook should be at
            firstPossibleRook  = gameBoard.pieceAt([kingRow, firstFileRookCol])
            secondPossibleRook = gameBoard.pieceAt([kingRow, eighthFileRookCol])

            ## Check if these pieces are rooks, and if they are, check if 1) rook has moved and 2) the squares in between king and rook are empty.
            ## If the squares between king and rook are empty, and has not moved then castling is pseudo-legal

            print ("\n\nis the condition true " + (!secondPossibleRook.nil? && secondPossibleRook.is_a?(Rook) && !secondPossibleRook.rookHasMoved).to_s)
            if(!firstPossibleRook.nil? && firstPossibleRook.is_a?(Rook) && !firstPossibleRook.rookHasMoved)
                if(spaceBetweenEmpty(firstPossibleRook.position, gameBoard))
                    ## Castling towards rook on 1st file with 0 column index, so subtract from kings index
                  pseudoLegalCastles.push([kingRow, kingCol - 2])


                end
            end

            ## Remember, the order of these checks matter, first we check if the obtained value at where the rook should
            ## be is nil(i.e. no piece there). If there is a piece there, we should verify if its a rook, and then verify
            ## if it has been moved. The order matters - for example if you try to check if it hasMoved, nil has no property
            ## rookHasMoved

            if(!secondPossibleRook.nil? && secondPossibleRook.is_a?(Rook) && !secondPossibleRook.rookHasMoved)
                if(spaceBetweenEmpty(secondPossibleRook.position, gameBoard))
                    ## Castling towards rook on 8th file with 7 column index, so add to king's col
                    pseudoLegalCastles.push([kingRow, kingCol + 2])
                end
            end
            
            print("\n Printing pseudo legal castles\n")
            pseudoLegalCastles.each do |move|
                print (move[0].to_s + " " + move[1].to_s + "\n")
            end
            print "\n"
            ## Return array of castling moves that are pseudo legal
            return pseudoLegalCastles


        
        end

       




    
    end


    ## Note that the method operates as follows: it does not care which color or which way your castling,
    ## It simply determines the rook your looking to castle with's column, and then iterates from
    ## the min(kingsCol, rooksCol) to max(kingsCol, rooksCol)
    def spaceBetweenEmpty(rookPos, gameBoard)

        ## Get col of both king and rook
        kingCol = position[1]
        rookCol = rookPos[1]

        ## King's rank is same as rooks rank, sitting on same row since neither has moved
        rank = position[0]

        ## No need to worry about equals case, will never be equal as rook and kings column never same if both haven't moved
        ## Here, we don't really know beforehand if the rook is to the right of the king or vice-versa, so we will figure out
        ## Which one is to the left, and then iterate over columns from left  to right. 
        max = kingCol > rookCol ? kingCol : rookCol
        min = kingCol > rookCol ? rookCol: kingCol

        ## Whatever piece is at the min location, start looking at one to right till one to left of the piece at max
        ## (all spaces between, but not including, the rook and king)
        min = min + 1
        max = max - 1

        print (min.to_s + " " + max.to_s)
        ## Iterate over the columns between the king and the rook
        for value in min..max
            if(!gameBoard.isEmptySquare([rank, value]))
                puts "rank and value: " + rank.to_s + " " + value.to_s
                return false
            end
        
        end

        ## If we check every square and all of  them are empty

        puts "reached the end, spaces are all empty"

        return true



    end

    def movementDir 
        return [
            [1,0],
            [-1,0],
            [0,1],
            [0,-1],
            [1,1],
            [1,-1],
            [-1,1],
            [-1,-1]
        ]
    end

   


end