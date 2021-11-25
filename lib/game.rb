require_relative 'board_class'
require_relative 'player_class'
# creates the players
puts 'Enter the name for player 1'
player_one = CREATE_PLAYER.new(gets.chomp)
puts 'Choose a player_symbol to represent you on the board'
player_one.assign_symbol(gets.chomp)
puts 'Enter the name for player 2'
player_two = CREATE_PLAYER.new(gets.chomp)
puts 'Choose a player_symbol to represent you on the board'
player_two.assign_symbol(gets.chomp)
game_board = CREATE_BOARD.new

# Number of turns
turns = 0
# GAME LOOP
while turns <= 9
  if turns == 9
    puts 'The game has come to a tie'
    break
  end
  game_board.display_board

  puts "#{player_one.player_name}'s move"
  game_board.get_player_input(player_one.player_symbol)
  if game_board.check_for_win == true
    puts "#{player_one.player_name} has won the game!"
    break
  end
  turns += 1
  if turns == 9
    puts 'The game has come to a tie'
    break
  end

  puts "#{player_two.player_name}'s move"
  game_board.get_player_input(player_two.player_symbol)
  if game_board.check_for_win == true
    puts "#{player_two.player_name} has won the game!"
    break
  end
  turns += 1
  if turns == 9
    puts 'The game has come to a tie'
    break
  end

end