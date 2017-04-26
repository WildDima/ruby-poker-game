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
      ids = players.map(&:id)
      return players if ids.uniq.length == ids.length
      raise 'ids must be uniq'
    end

    def create_round
      PokerGame::Round.new(players: players, deck: PokerGame::Deck.new)
    end
  end
end
