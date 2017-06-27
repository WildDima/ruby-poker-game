module PokerGame
  # Players
  #
  # Contains list of players
  class Players
    extend Forwardable
    include Enumerable

    attr_reader :players

    delegate %i[each size <=>] => :players

    def initialize(players)
      raise 'ids must be uniq' unless uniq?(players)
      @players = players
    end

    private

    def uniq?(players)
      ids = players.map(&:id)
      ids.uniq.length == ids.length
    end
  end
end