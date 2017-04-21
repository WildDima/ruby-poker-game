require 'spec_helper'

RSpec.describe PokerGame do
  it 'has a version number' do
    expect(PokerGame::VERSION).not_to be nil
  end
end
