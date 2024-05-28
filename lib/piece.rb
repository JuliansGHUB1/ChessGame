class Piece
    attr_reader :position
    attr_writer :position
    attr_reader :color
    attr_reader :image

    ## Constructor
    def initialize(position, color, image)
        print "called constructor\n"
        @position = position
        @color = color
        @image = image
    end

    def pseudoLegalMoves(gameBoard, unit)

        print "OUR METHOD IS BEING CALLED\n"

        pseudoMovesSet = Set.new()

        ## For each direction, use checkLine to gather in the pseudoLegalMoves

        

        movementDir.each do |direction|
            print ("curr dir: " + direction[0].to_s + direction[1].to_s)
            ## Check line will tell us the pseudo-legal moves in a single direction 
            validMovesInDirection = checkLine(direction, unit, gameBoard)
            ## Add these pseudo-legal moves to our set
            validMovesInDirection.each do |pseudoMove|
                pseudoMovesSet.add(pseudoMove)

            end
        end




        ## Finally, return our pseudoMoves

        return pseudoMovesSet


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


  
    ## Needs to be implemented...
    def causesCheck(destLoc, gameBoard)
        ## Produce a board in which the piece is moved to destLoc. Check, using the functionality provided by the board class (some non-static function)
        ## to see if this board instance is producing a check 
        return false
    end

    ## A function that given a move will check if its pseudo-legal, and then check if its valid (does not play into check)
    def legalMove(destLoc, gameBoard)
        ## Check if this move is an element of the pseudolegal moves
        if(pseudoLegalMoves.include?(destLoc))
             ## Then, check if this move does not put us in check
             if(!causesCheck(destLoc, gameBoard))
                return true
             end

             ## If either of the conditions is false (not a pseudo legal, or causes a check) then this is not a valid move
            return false
        end

       


        
    end


    ## Reutrns all legal moves of this piece, in a hash-set where a move is defined as a pair of locations
    def allLegalMoves(gameBoard)
        ## Produce all pseudo legal moves

        ## For each pseudo legal moves call causesCheck. If the result is false, add this pseudolegal move to set of legal moves

        ## return the set of legal moves
    end






end