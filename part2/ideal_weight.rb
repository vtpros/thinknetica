puts "Hi! What's your name?"
name = gets.chomp
puts "And what's your height (in cm)?"
height = gets.chomp.to_i
ideal_weight = (height - 110) * 1.15
if ideal_weight <= 0
  puts "#{name}, your weight is ok"
else
  puts "#{name}, your ideal weight will be #{ideal_weight}"
end
