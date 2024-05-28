require_relative 'lib/board'
require_relative 'lib/king'
require_relative 'lib/rook'
require_relative 'lib/boardrender'

## Test,  lets make a board. Then, we will make a king, and try  to see how it moves up the board.

b = Board.new()

k = King.new([7,1], :Black)

b.placePiece([7, 1], k)

r = Rook.new([0,7], :Black)

r1 = Rook.new([0,0], :Black)

##r2 = Rook.new([3, 5], :White)

##b.placePiece([3,5], r2)

p1 = Pawn.new([6, 0], :White)

 b.placePiece([6,0], p1)

b.placePiece([0,7], r)

b.placePiece([0,0], r1)


iterable = r1.pseudoLegalMoves(b, 8)


print("\n print the valid moves \n")
iterable.each do |sudo|
    print sudo[0].to_s + " " + sudo[1].to_s + "\n"
end


print ("\n is the king in check? " + k.isCheck(b).to_s)

render = BoardRender.new(b)
render.render()








