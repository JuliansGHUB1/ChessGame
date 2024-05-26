require_relative 'Piece'
require 'set'
class King < Piece

    ## Unit of movement for king
    @@kingUnit = 1

    ## Attribute reader for kingHasMoved instance var
    attr_reader :kingHasMoved

    def initialize(position, color)
        super(position, color)
        @kingHasMoved = false
    end

    def pseudoLegalMoves(gameBoard)

        pseudoMovesSet = Set.new()

        ## For each direction, use checkLine to gather in the pseudoLegalMoves

        movementDir.each do |direction|
            ## Check line will tell us the pseudo-legal moves in a single direction 
            validMovesInDirection = checkLine(direction, @@kingUnit, gameBoard)
            ## Add these pseudo-legal moves to our set
            validMovesInDirection.each do |pseudoMove|
                pseudoMovesSet.add(pseudoMove)

            end
        end


        ## Then, check castling move if conditions for pseudo legal have been met, and add in as well
        ## We only have to save two numbers: column of rook, column of other rook and same for both colors
        ## We only have to check, taking this piece's position, and check [piece's row, rook column] and check
        ## if the piece there is a rook, and also check if  the piece there is unmoved.
        ## Probably, we should first check if king unmoved, then if piece there is a rook, and if its unmoved
        ## then, do costlier check of checking space in between 




        ## Finally, return our pseudoMoves

        return pseduoMoveSet


    end


    def castlingPseudoLegal(gameBoard)

        ## The column value for both rooks (regardless if white or black)
        firstFileRookCol = 0
        eighthFileRookCol = 7

        ## If the king has not moved, then castling is still valid. King is sitting on same row as rooks
        if(!kingHasMoved)
            kingRow = position[0]

            ## Obtain the piece at the position both kingside and queenside rook should be at
            firstPossibleRook  = gameBoard.pieceAt([kingRow, firstFileRookCol])
            secondPossibleRook = gameBoard.pieceAt([kingRow, eighthFileRookCol])

            ## Check if these pieces are rooks, and if they are, check if 1) rook has moved and 2) the squares in between king and rook are empty.
            ## If the squares between king and rook are empty, and has not moved then castling is pseudo-legal

            if(!firstPossibleRook.isNil? && firstPossibleRook.is_a?(Rook) && !firstPossibleRook.rookHasMoved)
                
            end


        
        end

        def spaceBetweenEmpty(kingPos, rookPos)




    
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

    def checkLine(direction, unit, gameBoard)
        movesFromLine = Array.new()
        
        directionX, directionY = direction

        nextX = position[0]
        nextY = position[1]

        unit.times do
            nextX = nextX + directionX
            nextY = nextY + directionY
            ## First check if this square is in bounds
            if(gameBoard.inBounds([nextX, nextY]))
                ## Next, obtain the piece (or nil) at the square. If theres no piece we can move there
                if(gameBoard.isEmptySquare([nextX, nextY]))
                    movesFromLine.push([nextX, nextY])
                ## Else case is if the next square to be examined contains a piece. If the piece is an enemy, add it in
                ## and we are done checking this line, if the piece is friendly (do nothing - aka dont add it in) and we are done
                ## checking this line. 
                else
                    if(gameBoard.pieceColor([nextX, nextY]) != color)
                        movesFromLine.push([nextX, nextY])
                    end

                    break
                end
            else
                break
        
            end
        end

        return movesFromLine

    end


end