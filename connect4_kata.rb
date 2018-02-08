# a game of connect 4
class Connect4
  # spec
  # game grid is 6 row x 7 col, zero-based indices
  # players alternate 'dropping' discs on any none-full col, player 1 first
  # play is handled by a 'play' method
  # successful move returns "Player n has a turn!"
  # cols fill up as discs dropped
  # attempt on full col returns "Column full!"
  # four discs in horizontal or diagonal row is win condition, returns
  # "Player n wins!"
  # moves attempted after game won return "Game has finished!"

  def initalize
    @grid = Array.new(7) { Array.new(6) } # game grid
    @player = 1 # player designation, starts with 1
  end

  def fill_grid(col)
    return false if @grid[col].count(&:nil?).zero?
    # if grid column not full, add player token to first nil position
    i = grid[col].find_index(nil)
    @grid[col][i] = @player
    true
  end
end
