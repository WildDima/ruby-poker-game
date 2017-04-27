require 'workflow'
require 'ruby-poker'

module PokerGame
  # Round
  class Round
    include Workflow

    attr_accessor :deck, :players, :player_cards, :table_cards,
                  :flop_cards, :turn_cards, :river_cards

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

    def initialize(deck:, players:, player_cards: nil, table_cards: nil)
      @deck = deck
      @players = players
      @player_cards = player_cards || create_player_cards
      @table_cards = table_cards || table_cards_klass.new
    end

    def preflop
      to_preflop!
      self
    end

    def flop
      to_flop!
      self.flop_cards = give_out(3)
      table_cards << flop_cards
      self
    end

    def turn
      to_turn!
      self.turn_cards = give_out(1)
      table_cards << turn_cards
      self
    end

    def river
      to_river!
      self.river_cards = give_out(1)
      table_cards << river_cards
      self
    end

    def winner
      return unless river?

      player_cards.map { |p| { player: p, hand: PokerHand.new(p.cards + table_cards.cards) } }
                  .sort_by { |p| p[:hand] }.reverse.first
    end

    private

    def create_player_cards
      players.map do |player|
        player_cards_klass.new(player: player, cards: give_out)
      end
    end

    def give_out(count = 2)
      deck.give_out(count)
    end

    def player_cards_klass
      PokerGame::PlayerCards
    end

    def table_cards_klass
      PokerGame::TableCards
    end
  end
end
