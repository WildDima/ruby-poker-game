require 'spec_helper'

RSpec.describe PokerGame::Deck do
  context 'deck' do
    subject { described_class.new }
    let(:deck) { subject.deck }

    it 'should countain 50 deck' do
      expect(deck.size).to eq(52)
      expect(deck.map(&:state)).to include(:in_deck)
      expect(deck.map(&:state)).not_to include(:in_game)
    end
  end

  context 'flop' do
    subject { described_class.new }
    let(:flop) { subject.preflop.flop }
    let(:deck) { subject.deck }
    let(:in_game) { subject.in_game }
    let(:in_deck) { subject.in_deck }

    it 'should flop' do
      expect(flop.flop_cards).to be_an(Array)
      expect(flop.flop_cards.size).to eq(3)
      expect(subject.flop?).to be_truthy
      expect(deck.map(&:state)).to include(:in_game)
      expect(in_game.size).to eq(3)
      expect(in_deck.size).to eq(49)
    end
  end

  context 'turn' do
    subject { described_class.new }
    let(:turn) { subject.preflop.flop.turn }
    let(:deck) { subject.deck }
    let(:in_game) { subject.in_game }
    let(:in_deck) { subject.in_deck }

    it 'should turn' do
      expect(turn.turn_cards).to be_an(Array)
      expect(turn.turn_cards.size).to eq(1)
      expect(subject.turn?).to be_truthy
      expect(deck.map(&:state)).to include(:in_game)
      expect(in_game.size).to eq(4)
      expect(in_deck.size).to eq(48)
    end
  end

  context 'river' do
    subject { described_class.new }
    let(:river) { subject.preflop.flop.turn.river }
    let(:deck) { subject.deck }
    let(:in_game) { subject.in_game }
    let(:in_deck) { subject.in_deck }

    it 'should river' do
      expect(river.river_cards).to be_an(Array)
      expect(river.river_cards.size).to eq(1)
      expect(subject.river?).to be_truthy
      expect(deck.map(&:state)).to include(:in_game)
      expect(in_game.size).to eq(5)
      expect(in_deck.size).to eq(47)
    end
  end
end
