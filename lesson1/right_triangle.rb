puts "What's side 'a' of the triangle?"
a = gets.chomp.to_f
puts "What's side 'b' of the triangle?"
b = gets.chomp.to_f
puts "What's side 'c' of the triangle?"
c = gets.chomp.to_f
a, b, c = *[a, b, c].sort

if a**2 + b**2 == c**2
  puts "It's a right triangle"
elsif a == b && a == c
  puts "It's an equilateral triangle"
elsif a == b || b == c
  puts "It's an isosceles triangle"
end
