require_relative 'lib/board'
require_relative 'lib/king'
require_relative 'lib/rook'

## Test,  lets make a board. Then, we will make a king, and try  to see how it moves up the board.

b = Board.new()

k = King.new([0,5], :Black)

b.placePiece([0,5], k)

r = Rook.new([0,7], :Black)

r1 = Rook.new([0,0], :Black)

b.placePiece([0,7], r)

b.placePiece([0,0], r1)


iterable = k.pseudoLegalMoves(b)


print("\n print the valid moves \n")
iterable.each do |sudo|
    print sudo[0].to_s + " " + sudo[1].to_s + "\n"
end






