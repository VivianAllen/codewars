# early version

def vowel_indices(word)
  indices_out = []
	word.split("").each_index { |i| indices_out.push(i+1) if /[aeiouy]/i =~ word[i] }
  indices_out
end

# later version
