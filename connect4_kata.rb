class Connect4
  # spec
  # game grid is 6 row x 7 col, zero-based indices
  # players alternate 'dropping' discs on any none-full col, player 1 first
  # play is handled by a 'play' method
  # successful move returns "Player n has a turn!"
  # cols fill up as discs dropped
  # attempt on full col returns "Column full!"
  # four discs in horizontal or diagonal row is win condition, returns "Player n wins!"
  # moves attempted after game won return "Game has finished!"

  def initialize
    @game = true
    @grid = Array.new(7) { Array.new(6, 0) }
    @player = 1
    @win_type = "None"
    @win_l = 4
  end

  def switch_player
    @player == 1 ? @player = 2 : @player = 1
  end

  def fill_col(col)
    if @grid[col].count { |x| x > 0 } < 6
       i = @grid[col].detect { |x| x == 0 }
       @grid[col][i] = @player
      return true
    else
      return false
    end
  end

  def diagonalise_grid(grid)
    # pad grid to all same length
    max_l = grid.map { |x| x.length }.max
    grid.map! { |x| x.concat(Array.new(max_l - x.length, 0)) }
    # get diagonals along horizontal axis
    diagonals = []
    (0..grid.length - 1).to_a.each do |i|
      curr_diagonal = []
      (0..max_l-1).to_a.each do |i1|
        unless grid[i+i1].nil? || grid[i+i1][i1].nil?
          curr_diagonal.push(grid[i+i1][i1])
        end
      end
      diagonals.push(curr_diagonal)
    end
    # get 'spare' diagonals along first column
    (1..max_l - 1).to_a.each do |i|
      curr_diagonal = []
      (0..max_l-1).to_a.each do |i1|
        unless grid[i1][i+i1].nil?
          # puts "#{i1} #{i+i1}"
          curr_diagonal.push(grid[i1][i+i1])
        end
      end
      diagonals.push(curr_diagonal)
    end
    return diagonals
  end

  def check_win
    win = Proc.new do |col|
      col.each.with_index.count { |x,i| col[i+1]==x } >= @win_l - 1
    end
    if @grid.any? { |col| win.call(col) }
      @win_type = "Horizontal"
      @game = false
    elsif @grid.transpose.any? { |col| win.call(col) }
      @win_type = "Vertical"
      @game = false
    elsif diagonalise_grid(@grid).any? { |col| win.call(col) }
      @win_type = "Diagonal"
      @game = false
    end
  end

  def play(col)
    if @game
      if fill_col(col)
        check_win
        if @game
          return "Player #{@player} has a turn"
          switch_player
        else
          return "Player #{@player} wins!"
        end
      else
        return "Column full!"
      end
    else
      return "Game has finished!"
    end
  end

end
