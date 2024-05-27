class Rook < Piece
    attr_reader :rookHasMoved
    def initialize(position, color)
        ## Set up the position, color instance variables appropriately
        super(position, color)
        @rookHasMoved = false
    end

end