require 'spec_helper'

RSpec.describe PokerGame::TableCards do
  subject { described_class.new }

  it 'should has empty cards' do
    expect(subject.cards).to eq([])
    expect(subject.cards?).to be_falsy
  end

  describe 'adding cards to table' do
    let(:cards) { PokerGame::Deck.new.give_out(3) }

    it 'should push cards to cards' do
      expect { subject << cards }.to change { subject.cards }.from([]).to(cards)
      expect(subject.cards?).to be_truthy
      expect(subject.hand).to respond_to(:rank)
    end

    it 'does raise error if table if overflow' do
      expect { subject << (cards + cards) }.to raise_error(RuntimeError)
    end
  end
end
