require 'workflow'

module PokerGame
  class Deck
    include Workflow

    attr_accessor :deck, :flop_cards, :turn_cards, :river_cards

    workflow do
      state :blinds do
        event :to_preflop, transition_to: :preflop
      end
      state :preflop do
        event :to_flop, transition_to: :flop
      end
      state :flop do
        event :to_turn, transition_to: :turn
      end
      state :turn do
        event :to_river, transition_to: :river
      end
      state :river
    end

    def initialize(deck: PokerGame::CARDS)
      @deck = create_deck(deck)
    end

    def shuffle
      @deck.shuffle
    end

    def in_game
      @deck.select { |card| card.in_game? }
    end

    def in_deck
      @deck.select { |card| card.in_deck? }
    end

    def preflop
      to_preflop!
      self
    end

    def flop
      to_flop!
      self.flop_cards = in_deck.shuffle.first(3).map(&:give_out!)
      self
    end

    def turn
      to_turn!
      self.turn_cards = in_deck.shuffle.first(1).each(&:give_out!)
      self
    end

    def river
      to_river!
      self.river_cards = in_deck.shuffle.first(1).each(&:give_out!)
      self
    end

    private

    def create_deck(cards)
      cards.map do |card|
        Card.new(value: card)
      end
    end
  end
end