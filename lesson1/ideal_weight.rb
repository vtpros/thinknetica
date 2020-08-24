puts "Hi! What's your name?"
name = gets.chomp
puts "And what is your height (in cm)?"
height = gets.chomp.to_i
puts "#{name}, your ideal weight will be #{(height - 110) * 1.15}"
