puts 'Enter quadratic coefficients'
puts "'a':"
a = gets.chomp.to_f
puts "'b':"
b = gets.chomp.to_f
puts "'c':"
c = gets.chomp.to_f

discriminant = b**2 - 4*a*c

if discriminant < 0
  puts 'There are no roots'
  return
end

d_sqrt = Math::sqrt( discriminant )
x1 = (-b + d_sqrt)/2*a
x2 = (-b - d_sqrt)/2*a

if discriminant > 0
  puts "Discriminant: #{discriminant}, x1: #{x1}, x2: #{x2}"
else #discriminant.zero?
  puts "Discriminant: #{discriminant}, x: #{x1}"
end
