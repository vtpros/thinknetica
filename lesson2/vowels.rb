alphabet = ('a'..'z').to_a
vowels = ['a', 'e', 'i', 'o', 'u']
result = {}

alphabet.each_with_index do |letter, index|
  result[letter] = (index+1) if vowels.include?(letter)
end

result
