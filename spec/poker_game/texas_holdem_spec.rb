require 'spec_helper'

RSpec.describe PokerGame::TexasHoldem do
  let(:players) do
    Helpers::PlayerFactory.new.create(5) do
      { name: Faker::LordOfTheRings.character }
    end
  end

  let(:duplicated_players) do
    Helpers::PlayerFactory.new.create(2) do
      { id: 1, name: Faker::LordOfTheRings.character }
    end
  end

  it 'should create new instance' do
    expect(described_class.new(players: players)).to be_an(described_class)
  end

  it 'should raise error' do
    expect { described_class.new(players: duplicated_players) }.to raise_error(RuntimeError)
  end

  context 'new game' do
    subject { described_class.new(players: players) }

    it 'should start new game' do
      # expect(subject.round.players(&:cards?)).not_to include(false)
      # expect(subject.round.table.cards?).to be_falsy
      # expect(subject.round.blinds?).to be_truthy

      # subject.preflop
      # expect(subject.round.table.cards?).to be_falsy
      # expect(subject.round.preflop?).to be_truthy

      # subject.flop
      # expect(subject.round.table.cards.count).to eq 3
      # expect(subject.round.table.cards?).to be_truthy
      # expect(subject.round.flop?).to be_truthy

      # subject.turn
      # expect(subject.round.table.cards.count).to eq 4
      # expect(subject.round.table.cards?).to be_truthy
      # expect(subject.round.turn?).to be_truthy

      # subject.river
      # expect(subject.round.table.cards.count).to eq 5
      # expect(subject.round.table.cards?).to be_truthy
      # expect(subject.round.river?).to be_truthy
    end
  end
end
