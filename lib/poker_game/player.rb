module PokerGame
  # Class which implenets Player
  class Player
    attr_reader :id, :name

    def initialize(id:, name:)
      @id = id
      @name = name
    end
  end
end
