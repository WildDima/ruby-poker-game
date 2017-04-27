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
  let(:round_players) { subject.player_cards }
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
      expect(subject.table_cards.cards?).to be_falsy
      expect(subject.blinds?).to be_truthy
      expect(subject.winner).to be_falsy

      subject.preflop
      expect(subject.table_cards.cards?).to be_falsy
      expect(subject.preflop?).to be_truthy
      expect(subject.winner).to be_falsy

      subject.flop
      expect(subject.table_cards.cards.count).to eq 3
      expect(subject.table_cards.cards?).to be_truthy
      expect(subject.flop?).to be_truthy
      expect(subject.winner).to be_falsy

      subject.turn
      expect(subject.table_cards.cards.count).to eq 4
      expect(subject.table_cards.cards?).to be_truthy
      expect(subject.turn?).to be_truthy
      expect(subject.winner).to be_falsy

      subject.river
      expect(subject.table_cards.cards.count).to eq 5
      expect(subject.table_cards.cards?).to be_truthy
      expect(subject.river?).to be_truthy
      expect(subject.winner).to be_truthy
    end
  end

  context 'one round game' do
    let(:players) do
      Helpers::PlayerFactory.new.create(2) do
        { name: Faker::LordOfTheRings.character }
      end
    end

    subject do
      described_class.new(deck: deck,
                          players: players,
                          table_cards: table_cards,
                          player_cards: player_cards)
    end

    let(:round) do
      subject.to_preflop!
      subject.to_flop!
      subject.to_turn!
      subject.to_river!
      subject
    end

    context 'winner is first player' do
      let(:table_cards) { PokerGame::TableCards.new cards: %w[Qc Qh Td 7c 3h] }

      let(:player_cards) do
        [
          PokerGame::PlayerCards.new(player: players[0], cards: %w[Qd 8c]),
          PokerGame::PlayerCards.new(player: players[1], cards: %w[3d Tc])
        ]
      end

      it 'does return first player as winner' do
        expect(round.winner[:player].player).to eq(players[0])
        expect(round.winner[:hand].rank).to eq('Three of a kind')
      end
    end

    context 'winner is second player' do
      let(:table_cards) { PokerGame::TableCards.new cards: %w[Qc Qh Td Tc 3h] }

      let(:player_cards) do
        [
          PokerGame::PlayerCards.new(player: players[0], cards: %w[Qd 8c]),
          PokerGame::PlayerCards.new(player: players[1], cards: %w[Ts Th])
        ]
      end

      it 'does return second player as winner' do
        expect(round.winner[:player].player).to eq(players[1])

        expect(round.winner[:hand].rank).to eq('Four of a kind')
      end
    end

    context 'winner is third player' do
      let(:players) do
        Helpers::PlayerFactory.new.create(5) do
          { name: Faker::LordOfTheRings.character }
        end
      end

      let(:table_cards) { PokerGame::TableCards.new cards: %w[Qc Qh Th 9c 3h] }

      let(:player_cards) do
        [
          PokerGame::PlayerCards.new(player: players[0], cards: %w[9d 8c]),
          PokerGame::PlayerCards.new(player: players[1], cards: %w[Ts 9d]),
          PokerGame::PlayerCards.new(player: players[2], cards: %w[2h Jh]),
          PokerGame::PlayerCards.new(player: players[3], cards: %w[3s 7h]),
          PokerGame::PlayerCards.new(player: players[4], cards: %w[4s 8h])
        ]
      end

      it 'does return second player as winner' do
        expect(round.winner[:player].player).to eq(players[2])
        expect(round.winner[:hand].rank).to eq('Flush')
      end
    end
  end
end
