require 'spec_helper'

RSpec.describe PokerGame::Players do
  let(:players) do
    Helpers::PlayerFactory.new.create(2) do
      { name: Faker::LordOfTheRings.character }
    end
  end

  subject { described_class.new(players) }

  it 'does contain 2 players' do
    expect(subject.size).to eq(2)
  end
end
