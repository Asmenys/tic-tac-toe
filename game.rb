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

class CREATE_BOARD
    def initialize ()
        temp_index=0
        @board = Array.new(3) {Array.new(3){temp_index+=1}}
    end
public
    def display_board
        puts "-------------"
        puts "| #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} |"   
        puts "+---+---+---+"
        puts "| #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} |"
        puts "+---+---+---+"
        puts "| #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]} |"
        puts "-------------"
    end
private
    def get_index(num)
        temp_index = @board.map {|arr| arr.include?(num)}
        temp_index = temp_index.index(true)
        temp_index = [temp_index, @board[temp_index].index(num)]
        #[TopArrayIndex,NestedArrayIndex]
        return temp_index
    end
private
    def check_square(num)
        temp_index = @board.map {|arr| arr.include?(num)}
        return temp_index.any?(true)
    end
private
    def update_square(player_symbol,temp_index)
        @board[temp_index[0]][temp_index[1]] = player_symbol
    end
public
    def commit_move(player_symbol,num)
        unless check_square(num) == false
            temp_index = get_index(num)
            update_square(player_symbol,temp_index)
            display_board()
        else puts "Please choose a square that is not yet taken"
        end
    end
private
    def check_rows_horizontal(board = @board)
        result=""
        board.each do |horizontal_row|
            temp_element = horizontal_row.sample
            result = horizontal_row.all? {|element| element == temp_element}
            if(result == true)
                return true
            end
        end
        return result
    end
private
    def vertical_to_horizontal
        vertical_horizontal_rows = Array.new(3){Array.new()}
        @board.each_index do |index|
            vertical_horizontal_rows[index] << @board[0][index]
            vertical_horizontal_rows[index] << @board[1][index]
            vertical_horizontal_rows[index] << @board[2][index]
        end
        return vertical_horizontal_rows
    end
private
    def check_rows_vertical
        check_rows_horizontal(vertical_to_horizontal())
    end
private
    def check_single_row(temp_row)
        temp_sample = temp_row.sample
        if(temp_row.all?{|element| element == temp_sample})
            return true
        else
            return false
        end
    end
private
    def check_for_x_top
        temp_row =[@board[0][0],@board[1][1],@board[2][2]]
        check_single_row(temp_row)
    end
private
    def check_for_x_bottom
        temp_row = [@board[2][0],@board[1][1],@board[0][2]]
        check_single_row(temp_row)
    end
private
    def check_for_cross
        if(check_for_x_top == true || check_for_x_top == true)
            return true
        else
            return false
        end
    end
public
    def check_for_win
        temp_results = [check_for_cross, check_rows_vertical, check_rows_horizontal]
        if(temp_results.any?(true))
            return true
        else 
            return false
        end
    end
end
    puts "Enter the name for player 1"
player_one = CREATE_PLAYER.new(gets.chomp)
    puts "Choose a player_symbol to represent you on the board"
player_one.assign_symbol(gets.chomp)
    puts "Enter the name for player 2"
player_two = CREATE_PLAYER.new(gets.chomp)
    puts "Choose a player_symbol to represent you on the board"
player_two.assign_symbol(gets.chomp)
game_board = CREATE_BOARD.new()
#binding.pry

turns = 0
while turns<=9
    game_board.display_board
    puts "#{player_one.player_name}'s move"
    game_board.commit_move(player_one.player_symbol, gets.chomp.to_i)  
     if (game_board.check_for_win == true)
        system "clear"
        game_board.display_board
        puts "#{player_one.player_name} has WON!"
        break
     end
    system "clear"
   game_board.display_board
    puts "#{player_two.player_name}'s move"
    game_board.commit_move(player_two.player_symbol, gets.chomp.to_i)  
    if (game_board.check_for_win == true)
        system "clear"
        game_board.display_board
        puts "#{player_two.player_name} has WON!"
        break
     end
    system "clear"
    game_board.display_board
    turns+=1
end



