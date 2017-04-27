require 'workflow'
require 'ruby-poker'

module PokerGame
  # Deck
  class Deck
    attr_accessor :deck

    def initialize(deck: PokerGame::CARDS)
      @deck = create_deck(deck)
    end

    def in_game
      @deck.select(&:in_game?)
    end

    def in_deck
      @deck.select(&:in_deck?)
    end

    def give_out(size = 2)
      give_out_cards = in_deck.sample(size)
      give_out_cards.map(&:give_out!)
      give_out_cards
    end

    private

    def create_deck(cards)
      cards.map do |card|
        Card.new(value: card)
      end
    end
  end
end
