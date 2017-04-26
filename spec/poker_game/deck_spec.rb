require 'spec_helper'

RSpec.describe PokerGame::Deck do
  context 'deck' do
    subject { described_class.new }
    let(:deck) { subject.deck }

    it 'should countain 52 cards' do
      expect(deck.size).to eq(48)
      expect(deck.map(&:state)).to include(:in_deck)
      expect(deck.map(&:state)).not_to include(:in_game)
    end
  end

  context 'give out cards' do
    subject { described_class.new }

    it 'should return 2 cards' do
      expect(subject.give_out).to be_an(Array)
      expect(subject.give_out.size).to be(2)
      expect(subject.give_out(3).size).to be(3)
      expect(subject.give_out(10).map(&:state)).not_to include(:in_deck)
    end
  end
end
