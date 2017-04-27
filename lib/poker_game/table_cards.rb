require 'ruby-poker'

module PokerGame
  # TableCards
  class TableCards
    attr_accessor :cards

    TABLE_SIZE = 5

    def initialize(cards: [])
      @cards = cards
    end

    def cards?
      cards.any?
    end

    def <<(new_cards)
      raise 'table overflow' if cards.size + new_cards.size > TABLE_SIZE
      cards << new_cards
      cards.flatten!
      self
    end

    alias push <<

    def hand
      PokerHand.new cards
    end
  end
end
