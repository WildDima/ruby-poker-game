require 'spec_helper'

RSpec.describe PokerGame::Winner do
  let(:players) do
    Helpers::PlayerFactory.new.create(2) do
      { name: Faker::LordOfTheRings.character }
    end
  end

  subject do
    described_class.new(table: table_cards,
                        players: player_cards)
  end

  context 'winner is first player' do
    let(:table_cards) { PokerGame::TableCards.new cards: %w[Qc Qh Td 7c 3h] }

    let(:player_cards) do
      [
        PokerGame::PlayerCards.new(player: players[0], cards: %w[Qd 8c]),
        PokerGame::PlayerCards.new(player: players[1], cards: %w[3d Tc])
      ]
    end

    it 'does return first player as winner' do
      expect(subject.player).to eq(players[0])
      expect(subject.hand.rank).to eq('Three of a kind')
    end
  end

  context 'winner is second player' do
    let(:table_cards) { PokerGame::TableCards.new cards: %w[Qc Qh Td Tc 3h] }

    let(:player_cards) do
      [
        PokerGame::PlayerCards.new(player: players[0], cards: %w[Qd 8c]),
        PokerGame::PlayerCards.new(player: players[1], cards: %w[Ts Th])
      ]
    end

    it 'does return second player as winner' do
      expect(subject.player).to eq(players[1])

      expect(subject.hand.rank).to eq('Four of a kind')
    end
  end

  context 'winner is third player' do
    let(:players) do
      Helpers::PlayerFactory.new.create(5) do
        { name: Faker::LordOfTheRings.character }
      end
    end

    let(:table_cards) { PokerGame::TableCards.new cards: %w[Qc Qh Th 9c 3h] }

    let(:player_cards) do
      [
        PokerGame::PlayerCards.new(player: players[0], cards: %w[9d 8c]),
        PokerGame::PlayerCards.new(player: players[1], cards: %w[Ts 9d]),
        PokerGame::PlayerCards.new(player: players[2], cards: %w[2h Jh]),
        PokerGame::PlayerCards.new(player: players[3], cards: %w[3s 7h]),
        PokerGame::PlayerCards.new(player: players[4], cards: %w[4s 8h])
      ]
    end

    it 'does return second player as winner' do
      expect(subject.player).to eq(players[2])
      expect(subject.hand.rank).to eq('Flush')
    end
  end
end
