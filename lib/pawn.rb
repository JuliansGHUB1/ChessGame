
class Pawn < Piece
    @@pawnUnit = 1
    attr_reader :pawnHasMoved
    attr_reader :enPassantCapturable
    attr_writer :pawnHasMoved
    attr_writer :enPassantCapturable

    def initialize(position, color)
        if(color == :White)
            image = "♙"
        else
            image = "♟"
        end

       super(position, color, image)

       ## Will be updated by the game
       @enPassantCapturable = false

       ## Will be updated by the game
       @pawnHasMoved = false

    end

    def movementDir

        if(color == :White)
            movementDirections = [1, 0]
            return movementDirections
        else
            movementDirections = [-1, 0]
            return movementDirections
        end

    end

    def pseudoLegalMoves(gameBoard)
        print "position[0] " + position[0].to_s + "\n"
        ## Data structure containing the pseudoLegalMoves
        pseudoMovesSet = Set.new()

        ## Is pawn forward legal? If so, add it in. 
        currX, currY = position
        ## Var representing how the pawn advances, +1 in row or -1 in row
        rowIncrementor = movementDir[0]
        ## Then, the location of the next forward square is
        nextSquare = [currX + rowIncrementor, currY]
        ## Check if this square will produce out-of-bounds (i.e. is it on our board?)
        isInBounds = gameBoard.inBounds(nextSquare)
        ## Pawn forward is legal if the next square is empty
        if(isInBounds && gameBoard.isEmptySquare(nextSquare))
            print ("The next square is " + nextSquare[0].to_s + " " + nextSquare[1].to_s)
            pseudoMovesSet.add(nextSquare)
            ## Moving two forward is only valid if (1) we can legally move 1 forward and (2) our pawn has not been moved yet 
            ## (3) The square two-forward is empty
            if(!pawnHasMoved && gameBoard.isEmptySquare([currX + 2 * rowIncrementor, currY]))
                ## Here, no need to check if this square is in-bounds
                pseudoMovesSet.add([currX + 2 * rowIncrementor, currY])
            end
        end


        ## Are the diagonals containing enemy pieces? If so add these captures

        ## First obtain the diagonal squares this pawn is attacking

        ## Conceptually, the squares a pawn controls are the squares to the right and left of the square should we advance the pawn forward by 1
        firstDiagonal = [currX + rowIncrementor, currY + 1]
        secondDiagonal = [currX + rowIncrementor, currY - 1]

        firstDiagonalInBounds = gameBoard.inBounds(firstDiagonal)
        secondDiagonalInBounds = gameBoard.inBounds(secondDiagonal)

        ## If the diagonal is on the board, and theres an enemy piece on it, the pawn is attacking the enemy piece and threatening to take
        if(firstDiagonalInBounds && !gameBoard.isEmptySquare(firstDiagonal) && gameBoard.pieceColor(firstDiagonal) != color)
            pseudoMovesSet.add(firstDiagonalInBounds)
        end

        if(secondDiagonalInBounds && !gameBoard.isEmptySquare(secondDiagonal) && gameBoard.pieceColor(secondDiagonal) != color)
            pseudoMovesSet.add(firstDiagonalInBounds)
        end
        


        ## Is the pawn white and on the 5th rank? Black and on the 4th rank? Check the squares on the neighbouring rows.
        ## If the en-passant capturable flag is true for these squares, then these are valid moves as well. 
        if( (color == :White && position[0] = 4) || (color == :Black && position[0]== 3))
            print "\n Here for piece with color " + color.to_s + " and position " + position[0].to_s + "\n"
            ## Get squares to right and left
            rightSquare = [currX, currY + 1]
            leftSquare = [currX, currY - 1]

            ## You can't en pasant if the square is out of bounds
            rightSquareInBounds = gameBoard.inBounds(rightSquare)
            leftSquareInBounds = gameBoard.inBounds(leftSquare)

            ## You can en-pasant if there is an enemy PAWN AND the enemy PAWN is enpasant capturable

            if(!gameBoard.isEmptySquare(rightSquare) && gameBoard.pieceColor(rightSquare) != color && gameBoard.pieceAt(rightSquare).is_a?(Pawn) && gameBoard.pieceAt(rightSquare).enPassantCapturable = true)
                pseudoMovesSet.add([currX + rowIncrementor, currY + 1])
            end

            if(!gameBoard.isEmptySquare(leftSquare) && gameBoard.pieceColor(leftSquare) != color && gameBoard.pieceAt(leftSquare).is_a?(Pawn) && gameBoard.pieceAt(leftSquare).enPassantCapturable = true)
                pseudoMovesSet.add([currX + rowIncrementor, currY - 1])
            end

            

        end

        return pseudoMovesSet

    end

    def calculateValidMoves(gameBoard)
        
        
    
    

    end


end