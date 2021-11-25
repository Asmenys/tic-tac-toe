# frozen_string_literal: true

class CREATE_BOARD
  def initialize
    temp_index = 0
    @board = Array.new(3) { Array.new(3) { temp_index += 1 } }
  end

  def display_board
    puts '-------------'
    puts "| #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} |"
    puts '+---+---+---+'
    puts "| #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} |"
    puts '+---+---+---+'
    puts "| #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]} |"
    puts '-------------'
  end

  def check_square(num)
    temp_index = @board.map { |arr| arr.include?(num) }
    temp_index.any?(true)
  end

  def commit_move(player_symbol, player_input)
    if check_square(player_input) == false
      bad_input
      get_player_input(player_symbol)
    else
      temp_index = get_index(player_input)
      update_square(player_symbol, temp_index)

      display_board
    end
  end

  def get_player_input(player_symbol)
    player_input = gets.chomp.to_i
    commit_move(player_symbol, player_input)
  end

  def check_for_win
    temp_results = [check_for_cross, check_rows_vertical, check_rows_horizontal]
    if temp_results.any?(true)
      true
    else
      false
    end
  end

  private

  def get_index(num)
    temp_index = @board.map { |arr| arr.include?(num) }
    temp_index = temp_index.index(true)
    [temp_index, @board[temp_index].index(num)]
  end

  def update_square(player_symbol, temp_index)
    @board[temp_index[0]][temp_index[1]] = player_symbol
  end

  def bad_input
    puts 'Please enter a square that is available on the board'
  end

  def check_rows_horizontal(board = @board)
    result = ''
    board.each do |horizontal_row|
      temp_element = horizontal_row.sample
      result = horizontal_row.all? { |element| element == temp_element }
      return true if result == true
    end
    result
  end

  def vertical_to_horizontal
    vertical_horizontal_rows = Array.new(3) { [] }
    @board.each_index do |index|
      vertical_horizontal_rows[index] << @board[0][index]
      vertical_horizontal_rows[index] << @board[1][index]
      vertical_horizontal_rows[index] << @board[2][index]
    end
    vertical_horizontal_rows
  end

  def check_rows_vertical
    check_rows_horizontal(vertical_to_horizontal)
  end

  def check_single_row(temp_row)
    temp_sample = temp_row.sample
    if temp_row.all? { |element| element == temp_sample }
      true
    else
      false
    end
  end

  def check_for_x_top
    temp_row = [@board[0][0], @board[1][1], @board[2][2]]
    check_single_row(temp_row)
  end

  def check_for_x_bottom
    temp_row = [@board[2][0], @board[1][1], @board[0][2]]
    check_single_row(temp_row)
  end

  def check_for_cross
    if check_for_x_top == true || check_for_x_top == true
      true
    else
      false
    end
  end
end

