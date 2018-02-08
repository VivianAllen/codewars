class SnakesLadders

  # spec:
  # - both players start at zero
  # - player 1 starts, then players alternate
  # - squares go from 1 to 100
  # - players roll two 6-sided die and sum score
  # - if players roll two of the same number they go again
  # - if players land on a snake they go down
  # - if players land on a ladder they go up
  # - player score of exactly 100 wins
  # - player score over 100 is reduced to 100 - the amount it's over by.

  def initialize
    @player_squares = [0, 0]
    @which_player = 0
  end

  def switch_players
    @which_player ==0 ? @which_player  = 1 : @which_player  = 0
  end

  def snake_ladder_mod(square)
    snakes = {
      16 => 6,
      46 => 25,
      49 => 11,
      62 => 19,
      64 => 60,
      74 => 53,
      89 => 68,
      92 => 88,
      95 => 75,
      99 => 80
      }
    ladders = {
      2  => 38,
      7  => 14,
      8  => 31,
      15 => 26,
      21 => 42,
      28 => 84,
      36 => 44,
      51 => 67,
      71 => 91,
      78 => 98,
      87 => 94
    }
   if snakes.merge(ladders).key?(square)
     return snakes.merge(ladders)[square]
   else
     return square
   end
  end

  def win_exactly_mod(square)
    if square > 100
      return 200 - square
    else
      return square
    end
  end

  def play(die1, die2)
    if @player_squares.any? { |x| x == 100 }
      out_message = "Game over!"
    else
      @player_squares[@which_player] += [die1, die2].reduce(:+)
      @player_squares[@which_player] = win_exactly_mod(@player_squares[@which_player])
      @player_squares[@which_player] = snake_ladder_mod(@player_squares[@which_player])
      if @player_squares[@which_player] == 100
        out_message = "Player #{@which_player + 1} Wins!"
      else
        out_message = "Player #{@which_player + 1} is on square #{@player_squares[@which_player]}"
      end
      if die1 != die2
       switch_players
      end
    end
    return out_message
  end

end
