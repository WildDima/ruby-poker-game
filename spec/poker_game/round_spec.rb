require 'spec_helper'

RSpec.describe PokerGame::Round do
  let(:players) do
    Helpers::PlayerFactory.new.create(5) do
      { name: Faker::LordOfTheRings.character }
    end
  end
  let(:deck) { PokerGame::Deck.new }
  subject { described_class.new(deck: deck, players: players) }
  let(:current_deck) { subject.deck }
  let(:round_players) { subject.players }
  let(:round_deck) { subject.deck }

  context 'blind' do
    it 'should has state blind' do
      expect(subject.blinds?).to be_truthy
      expect(round_players.count).to eq(players.count)
    end

    it 'should gives out cards to each player' do
      expect(round_players.map(&:cards?)).not_to include(false)
    end
  end

  context 'flop' do
    subject { described_class.new(deck: deck, players: players) }
    let(:flop) { subject.preflop.flop }
    let(:in_game) { current_deck.in_game }
    let(:in_deck) { current_deck.in_deck }

    it 'should flop' do
      expect(flop.flop_cards).to be_an(Array)
      expect(flop.flop_cards.size).to eq(3)
      expect(subject.flop?).to be_truthy
      expect(current_deck.deck.map(&:state)).to include(:in_game)
      expect(in_game.size).to eq(15)
      expect(in_deck.size).to eq(37)
    end
  end

  context 'turn' do
    subject { described_class.new(deck: deck, players: players) }
    let(:turn) { subject.preflop.flop.turn }
    let(:in_game) { current_deck.in_game }
    let(:in_deck) { current_deck.in_deck }

    it 'should turn' do
      expect(turn.turn_cards).to be_an(Array)
      expect(turn.turn_cards.size).to eq(1)
      expect(subject.turn?).to be_truthy
      expect(current_deck.deck.map(&:state)).to include(:in_game)
      expect(in_game.size).to eq(16)
      expect(in_deck.size).to eq(36)
    end
  end

  context 'river' do
    subject { described_class.new(deck: deck, players: players) }
    let(:river) { subject.preflop.flop.turn.river }
    let(:in_game) { current_deck.in_game }
    let(:in_deck) { current_deck.in_deck }

    it 'should river' do
      expect(river.river_cards).to be_an(Array)
      expect(river.river_cards.size).to eq(1)
      expect(subject.river?).to be_truthy
      expect(current_deck.deck.map(&:state)).to include(:in_game)
      expect(in_game.size).to eq(17)
      expect(in_deck.size).to eq(35)
    end
  end

  context 'call river from flop' do
    subject { described_class.new(deck: deck, players: players) }
    let(:flop) { subject.preflop.flop }

    it 'should flop' do
      expect { flop.river }.to raise_error(Workflow::NoTransitionAllowed)
    end
  end

  context 'one round game' do
    it 'does game in one round' do
      expect(subject.players(&:cards?)).not_to include(false)
      expect(subject.table.cards?).to be_falsy
      expect(subject.blinds?).to be_truthy
      expect(subject.winner).to be_falsy

      subject.preflop
      expect(subject.table.cards?).to be_falsy
      expect(subject.preflop?).to be_truthy
      expect(subject.winner).to be_falsy

      subject.flop
      expect(subject.table.cards.count).to eq 3
      expect(subject.table.cards?).to be_truthy
      expect(subject.flop?).to be_truthy
      expect(subject.winner).to be_falsy

      subject.turn
      expect(subject.table.cards.count).to eq 4
      expect(subject.table.cards?).to be_truthy
      expect(subject.turn?).to be_truthy
      expect(subject.winner).to be_falsy

      subject.river
      expect(subject.table.cards.count).to eq 5
      expect(subject.table.cards?).to be_truthy
      expect(subject.river?).to be_truthy
      expect(subject.winner).to be_an(PokerGame::Player)
    end
  end
end
