alphabet = ('a'..'z').to_a
vowels = %w[a e i o u]
result = {}

alphabet.each.with_index(1) do |letter, index|
  result[letter] = index if vowels.include?(letter)
end

result
