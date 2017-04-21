module PokerGame
  # Class which implenets TexasHoldem
  class TexasHoldem
    attr_reader :players

    def initialize(players:)
      @players = create_players(players)
    end

    private

    def create_players(players)
      ids = players.map(&:id)
      return players if ids.uniq.length == ids.length
      raise 'ids must be uniq'
    end
  end
end
