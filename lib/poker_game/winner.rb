require 'ruby-poker'

module PokerGame
  # Winner
  #
  # Class which determine the winner
  class Winner
    attr_accessor :table, :players

    def initialize(table:, players:)
      @table = table
      @players = players
    end

    def player
      winner[:player_cards].player
    end

    def hand
      winner[:hand]
    end

    private

    def winner
      players.map { |player| { player_cards: player, hand: player.hand + table.hand } }
             .sort_by { |cards| cards[:hand] }.reverse.first
    end
  end
end
