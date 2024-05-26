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
        ## Call the super-classes's implementation which checks all the "regular" straight line moves
        pseudoLegalMovesSet = super()

        ## Then, check castling and add if necessary

        castlingPseudoLegal(gameBoard).each do |castlingMove|
            pseudoLegalMovesSet.add(castlingMove)
        end


        ## Return the pseduoLegalMoves
        return pseudoLegalMoves

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

            if(!firstPossibleRook.isNil? && firstPossibleRook.is_a?(Rook) && !firstPossibleRook.rookHasMoved)
                if(spaceBetweenEmpty(firstPossibleRook.position, gameBoard))
                    ## Castling towards rook on 1st file with 0 column index, so subtract from kings index
                  pseudoLegalCastles.push([kingRow, kingCol - 2])


                end
            end

            ## Remember, the order of these checks matter, first we check if the obtained value at where the rook should
            ## be is nil(i.e. no piece there). If there is a piece there, we should verify if its a rook, and then verify
            ## if it has been moved. The order matters - for example if you try to check if it hasMoved, nil has no property
            ## rookHasMoved

            if(!secondPossibleRook.isNil? && secondPossibleRook.is_a?(Rook) && !secondPossibleRook.rookHasMoved)
                if(spaceBetweenEmpty(secondPossibleRook.position, gameBoard))
                    ## Castling towards rook on 8th file with 7 column index, so add to king's col
                    pseudoLegalCastles.push([kingRow, kingCol + 2])
                end
            end

            ## Return array of castling moves that are pseudo legal
            return pseduoLegalCastles


        
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

        ## Iterate over the columns between the king and the rook
        for value in min..max
            if(!gameBoard.isEmptySquare([rank, value]))
                return false
            end
        
        end

        ## If we check every square and all of  them are empty

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