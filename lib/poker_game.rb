# PokerGame
#
# Library implements poker game
module PokerGame
  require 'ruby-poker'
  require 'poker_game/card'
  require 'poker_game/deck'
  require 'poker_game/players'
  require 'poker_game/player'
  require 'poker_game/player_cards'
  require 'poker_game/table_cards'
  require 'poker_game/round'
  require 'poker_game/winner'

  CARDS = %w[Ac Ah Ad As Kc Kh Kd Ks
             Qc Qh Qd Qs Jc Jh Jd Js
             Tc Th Td Ts 9c 9h 9d 9s
             8c 8h 8d 8s 7c 7h 7d 7s
             6c 6h 6d 6s 5c 5h 5d 5s
             4c 4h 4d 4s 3c 3h 3d 3s
             2c 2h 2d 2s].freeze
end
