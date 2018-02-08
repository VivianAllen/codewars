def combos(n)

  # (exhaustive) assess every n digit combination of numbers? maybe too long
  # yeah exhaustive search takes way too long, ugh

  # first solution is always just n
  combo_output = [[n]]

  # iterate through combo lengths up to n (which will be array of 1's)
  (2..n).each do |combo_l|

    # maximum value of any single number in the array will be
    # n - combo_l + 1, (e.g. if combo_l = 3 and n = 10, max possible single
    # value will be 8 in combo [1, 1, 8]) so limit numbers to search through
    # to this max
    numbers = (1..n - combo_l + 1).to_a

    # assess all possible combinations of length combo_l with numbers from
    # 1 to max value as above, store if they sum to n.
    numbers.repeated_combination(combo_l).each do |combo|
        if combo.reduce(:+) == n then combo_output.push(combo) end
      end
  end

  return combo_output

end
