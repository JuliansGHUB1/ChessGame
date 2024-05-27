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