class Pawn < Piece
    def initialize(position, color)
       super(position, color)
    end

    def movementDir

        if(color == "White")
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