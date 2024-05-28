class Rook < Piece
    attr_reader :rookHasMoved
    @@rookUnit
    def initialize(position, color)
        ## Set up the position, color instance variables appropriately
        if(color == :White)
            image = "♖"
        else
            image = "♜"

        end

        super(position, color, image)
        @rookHasMoved = false

    end

    def movementDir
        return [
            [0, 1],
            [1, 0],
            [0, -1],
            [-1, 0]
        ]
    end

end