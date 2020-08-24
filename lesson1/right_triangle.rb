puts "Enter triangle's sides"
puts "Side 'a':"
a = gets.chomp.to_f
puts "Side 'b':"
b = gets.chomp.to_f
puts "Side 'c':"
c = gets.chomp.to_f
a, b, c = *[a, b, c].sort

if a**2 + b**2 == c**2
  puts "It's a right triangle"
elsif a == b && a == c
  puts "It's an equilateral triangle"
elsif a == b || b == c
  puts "It's an isosceles triangle"
else
  puts "It's an ordinary triangle"
end
