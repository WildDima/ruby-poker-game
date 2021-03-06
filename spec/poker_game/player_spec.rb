require 'spec_helper'

RSpec.describe PokerGame::Player do
  let(:name) { Faker::LordOfTheRings.character }
  let(:id) { 1 }
  let(:player) { described_class.new(id: id, name: name) }

  it 'should create new instance of Player with passed name and id' do
    expect(player.id).to eq(id)
    expect(player.name).to eq(name)
  end
end
