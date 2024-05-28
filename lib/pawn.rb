class Pawn < Piece
    def initialize(position, color)
        if(color == :White)
            image = "♙"
        else
            image = "♟"
        end

       super(position, color, image)
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

    def calculateValidMoves(gameBoard)
        
        
    
    

    end


end