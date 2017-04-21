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
end
