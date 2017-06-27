module PokerGame
  # Class which implenets TexasHoldem
  class TexasHoldem
    attr_reader :players, :round

    def initialize(players:)
      @players = create_players(players)
      @round = create_round
    end

    def preflop
      round.preflop
    end

    def flop
      round.flop
    end

    private

    def create_players(players)
      Players.new(players)
    end

    def create_round
      Round.new(players: players, deck: Deck.new)
    end
  end
end
