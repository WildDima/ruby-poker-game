require 'workflow'

module PokerGame
  class Card
    include Workflow

    workflow do
      state :in_deck do
        event :give_out, transition_to: :in_game
      end
      state :in_game
    end

    attr_accessor :value

    def initialize(value:)

      @value = create_card value
    end

    def to_s
      value.to_s
    end

    def state
      current_state.name
    end

    private

    def create_card(value)
      raise 'card must be from CARDS' unless PokerGame::CARDS.include? value
      value
    end
  end
end