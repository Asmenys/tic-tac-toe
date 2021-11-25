# A class that initializes the players
class CREATE_PLAYER
    attr_reader :player_name, :player_symbol
  
    def initialize(player_name)
      @player_name = player_name
    end
  
    def assign_symbol(player_symbol)
      @player_symbol = player_symbol
    end
  end
  