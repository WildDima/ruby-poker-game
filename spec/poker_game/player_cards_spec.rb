require 'spec_helper'

RSpec.describe PokerGame::PlayerCards do
  let(:player) { PokerGame::Player.new(id: 0, name: Faker::LordOfTheRings.character) }
  let(:cards) { PokerGame::Deck.new.give_out(2) }

  subject { described_class.new(player: player, cards: cards) }

  it 'should create new player cards bound' do
    expect(subject.player).to eq player
    expect(subject.cards).to eq cards
    expect(subject.cards?).to be_truthy
  end
end
