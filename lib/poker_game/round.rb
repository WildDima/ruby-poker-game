require 'workflow'
require 'ruby-poker'

module PokerGame
  # Round
  class Round
    include Workflow

    attr_accessor :deck, :players, :table, :flop_cards, :turn_cards, :river_cards

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

    def initialize(deck:, players:)
      @deck = deck
      @players = create_players players
      @table = table_cards.new
    end

    def preflop
      to_preflop!
      self
    end

    def flop
      to_flop!
      self.flop_cards = give_out(3)
      table << flop_cards
      self
    end

    def turn
      to_turn!
      self.turn_cards = give_out(1)
      table << turn_cards
      self
    end

    def river
      to_river!
      self.river_cards = give_out(1)
      table << river_cards
      self
    end

    def winner
      return unless river?

      players.map { |p| { player: p, hand: PokerHand.new(p.cards + table.cards) } }
             .sort_by { |p| p[:hand] }.first[:player].player
    end

    private

    def create_players(players)
      players.map do |player|
        player_cards.new(player: player, cards: give_out)
      end
    end

    def give_out(count = 2)
      deck.give_out(count)
    end

    def player_cards
      PokerGame::PlayerCards
    end

    def table_cards
      PokerGame::TableCards
    end
  end
end
