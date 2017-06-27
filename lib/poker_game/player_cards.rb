module PokerGame
  # PlayerCards
  class PlayerCards
    attr_reader :player, :cards

    def initialize(player:, cards:)
      @player = player
      @cards = cards
    end

    def cards?
      cards.size == 2
    end

    def hand
      PokerHand.new cards
    end
  end
end
