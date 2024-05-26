class Piece
    
    ## Constructor
    def initialize(position, color)
        @position = position
        @color = color
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