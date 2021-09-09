
#TIC-TAC-TOE
#A class that initializes the players
class CREATE_PLAYER
    attr_reader :player_name, :player_symbol
    def initialize(player_name)
        @player_name = player_name
    end
    def assign_symbol(player_symbol)
        @player_symbol = player_symbol
    end
end
#this creates the board with methods to move on it and check for win conditions
class CREATE_BOARD
    def initialize ()
        temp_index=0
        @board = Array.new(3) {Array.new(3){temp_index+=1}}
    end
public
#displays the board
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
#The board squares are displayed with numbers assigned to them
#This takes the number as users input and gets the squares location
    def get_index(num)
        temp_index = @board.map {|arr| arr.include?(num)}
        temp_index = temp_index.index(true)
        temp_index = [temp_index, @board[temp_index].index(num)]
        #[TopArrayIndex,NestedArrayIndex]
        return temp_index
    end
private
#This checks whether the users input corresponds to a square
    def check_square(num)
        temp_index = @board.map {|arr| arr.include?(num)}
        return temp_index.any?(true)
    end
private
#This updates the square with users input
    def update_square(player_symbol,temp_index)
        @board[temp_index[0]][temp_index[1]] = player_symbol
    end
public
#This calls the update_square method with the players input and the corresponding symbol
#then displays the board unless the players input did not correspond to a proper square
    def commit_move(player_symbol,num)
        unless check_square(num) == false
            temp_index = get_index(num)
            update_square(player_symbol,temp_index)
            display_board()
        else puts "Please choose a square that is not yet taken"
        end
    end
private
#checks for a win condition horizontally
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
#convers the vertical row values into a horizontal so that i can reuse check_rows_horizontal
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
#This checks for win conditions vertically
    def check_rows_vertical
        check_rows_horizontal(vertical_to_horizontal())
    end
private
#This is used by checking for win conditions in an X manner, converts
#the values to a single row and returns the appropriate answer
    def check_single_row(temp_row)
        temp_sample = temp_row.sample
        if(temp_row.all?{|element| element == temp_sample})
            return true
        else
            return false
        end
    end
private
#Converts the values of \ members into a single row for use in check_single_row
    def check_for_x_top
        temp_row =[@board[0][0],@board[1][1],@board[2][2]]
        check_single_row(temp_row)
    end
private
#Converts the values of / members into a single row for use in check_single_row
    def check_for_x_bottom
        temp_row = [@board[2][0],@board[1][1],@board[0][2]]
        check_single_row(temp_row)
    end
private
#a bundle for check_for_x_bottom, top, and check_single_row
    def check_for_cross
        if(check_for_x_top == true || check_for_x_top == true)
            return true
        else
            return false
        end
    end
#checks for win conditions using all the previous win condition methods
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

#creates the players
    puts "Enter the name for player 1"
player_one = CREATE_PLAYER.new(gets.chomp)
    puts "Choose a player_symbol to represent you on the board"
player_one.assign_symbol(gets.chomp)
    puts "Enter the name for player 2"
player_two = CREATE_PLAYER.new(gets.chomp)
    puts "Choose a player_symbol to represent you on the board"
player_two.assign_symbol(gets.chomp)
game_board = CREATE_BOARD.new()

#Number of turns
turns = 0
#GAME LOOP
while turns<=9
    game_board.display_board
    puts "#{player_one.player_name}'s move"
    #updates the board with players move
    game_board.commit_move(player_one.player_symbol, gets.chomp.to_i)  
    #if the current moves amount to a win condition - breaks the loop
     if (game_board.check_for_win == true)
        system "clear"
        game_board.display_board
        puts "#{player_one.player_name} has WON!"
        break
     end
    system "clear"
   game_board.display_board
    puts "#{player_two.player_name}'s move"
         #updates the board with players move
    game_board.commit_move(player_two.player_symbol, gets.chomp.to_i) 
      #if the current moves amount to a win condition - breaks the loop
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



