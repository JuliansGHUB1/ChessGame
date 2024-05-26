class Board

	## Produces a function gameBoard which returns the value of gameBoard
	attr reader :gameBoard

	def self.createSetUpBoard
		## Create an instance of the board
		gB = new Board()
		## Instantiate various pieces, and place them onto the correct squares

		## Return the set up board
		return gB
	end

	def initialize

		## This is ruby syntax: for each of the 8 slots made in the new array, that slot will be filled
		## with the result of what is in the "block". So each slot will be filled with an array of 8 elements (aka 8 x 8 array)
		@gameBoard = Array.new(8) {Array.new(8, nil)}
	
	end

	## Returns piece at provided location
	def pieceAt(location)
		x,y = location
		return gameBoard[x][y]

	end

	## Method places piece at location
	def placePiece(location, piece)
		x,y = location
		gameBoard[x,y] = piece
	end

	def isEmptySquare(location)
		x,y = location

		val = gameBoard[x][y]

		return val.nil?


	end

	## Will likely be used in the future for movement checks, e.x. can't move onto piece with friendly square
	def pieceColor(location)
		x,y = location

		piece = gameBoard[x][y]
		return piece.color

	end

	def inBounds(location)
		## Array destructuring to obtain first and second element
		x,y = location

		## Check if x coordinate is in bounds

		validX = x >= 0 && x <= 7

		## Check if y coordinate is in bounds
		validY = y >= 0 && y <= 7

		## Returns true only if both x and y are in bounds
		return validX && validY
	
	end


end
