class BoardRender
    attr_reader :board
    def initialize(board)
        @board = board
    end

    def render
        print("\n")
        board.gameBoard.each do |row|
            row.each do |piece|
                if(piece == nil)
                    print ". "
                else
                    print (piece.image + " ")
                end
            end
            print("\n")
        end
        print("\n")
    end



end