require 'spec_helper'

module Helpers
  class PlayerFactory
    def create(number = 0)
      return unless block_given?
      (0..number).map do |n|
        opts = yield
        PokerGame::Player.new(id: opts[:id] || n, name: opts[:name])
      end
    end
  end
end