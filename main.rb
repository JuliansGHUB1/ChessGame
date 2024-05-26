require_relative 'lib/board'
require_relative 'lib/king'

## Test,  lets make a board. Then, we will make a king, and try  to see how it moves up the board.

b = Board.new()

k = King.new([0,0], :black)

k1 = King.new([6,0], :White)

b.placePiece([5,5], k1)

arr = k.checkLine([1, 1], 8, b)

arr.each do |position|
    puts position[0].to_s + " " + position[1].to_s
end

