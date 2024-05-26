class Piece
    attr_reader :position
    attr_writer :position
    attr_reader :color

    ## Constructor
    def initialize(position, color)
        @position = position
        @color = color
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




        ## Finally, return our pseudoMoves

        return pseduoMoveSet


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



    ## Returns an array of all movement directions of this piece
    def movementDir 
    
    end


    ## We will call this function in pseudo-legal moves. For each direction or way a piece can move
    ## We will check along that line for as many units as that piece permits. 
    def checkLine(direction, unit)

    end

    def pseudoLegalMoves(gameBoard)
        ## Use our position and the gameBoard to determine the pseudo legal moves of this piece
        ## Return a hashmap of these moves. 

    end

    def causesCheck(destLoc, gameBoard)
        ## Produce a board in which the piece is moved to destLoc. Check, using the functionality provided by the board class (some non-static function)
        ## to see if this board instance is producing a check 
    end

    ## A function that given a move will check if its pseudo-legal, and then check if its valid (does not play into check)
    def legalMove(destLoc, gameBoard)
        ## Check if this move is an element of the pseudolegal moves

        ## Then, check if this move does not put us in check


        ## If both of the above conditions are satisfied, return true.
    end


    ## Reutrns all legal moves of this piece, in a hash-set where a move is defined as a pair of locations
    def allLegalMoves(gameBoard)
        ## Produce all pseudo legal moves

        ## For each pseudo legal moves call causesCheck. If the result is false, add this pseudolegal move to set of legal moves

        ## return the set of legal moves
    end






end