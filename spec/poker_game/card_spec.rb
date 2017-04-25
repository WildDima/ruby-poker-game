require 'spec_helper'

RSpec.describe PokerGame::Card do
  let(:value) { 'As' }
  let(:card) { described_class.new(value: value) }

  it 'should return self value and state' do
    expect(card.value).to eq(value)
    expect(card.in_deck?).to be_truthy
  end

  it 'should transfer to state in_game' do
    expect { card.give_out! }.to change { card.current_state.name }
                                  .from(:in_deck)
                                  .to(:in_game)
  end

  it 'should raise error' do
    expect { described_class.new(value: 'qwe') }.to raise_error(RuntimeError)
  end
end