require 'pry-byebug'
#TIC-TAC-TOE
#a game loop?
#create players, with a factory class maybe
#maybe also create the board with a class, how though?
#how would I check for victory?
class CREATE_PLAYER
    attr_reader :player_name, :player_symbol
    def initialize(player_name)
        @player_name = player_name
    end
    def assign_symbol(player_symbol)
        @player_symbol = player_symbol
    end
end
#somehow create the objects, then call assign_symbol on them
#puts "Enter the name for player 1"
first_player = CREATE_PLAYER.new("P1")
#puts "Choose a player_symbol to represent you on the board"
first_player.assign_symbol("Y")
#puts "Enter the name for player 2"
second_player = CREATE_PLAYER.new("P2")
#puts "Choose a player_symbol to represent you on the board"
second_player.assign_symbol("X")
class CREATE_BOARD
    def initialize
        temp_index=0
        @board = Array.new(3) {Array.new(3){temp_index+=1}}
    end

    def display_board
        puts "| #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} |"   
        puts "+-----------+"
        puts "| #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} |"
        puts "+-----------+"
        puts "| #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]} |"
    
    end
    def get_index(num)
        temp_index = @board.map {|arr| arr.include?(num)}
        temp_index = temp_index.index(true)
        temp_index = [temp_index, @board[temp_index].index(num)]
        return temp_index
    end

end
game_board = CREATE_BOARD.new
game_board.display_board

binding.pry
p "something"