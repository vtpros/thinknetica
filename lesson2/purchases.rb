purchases = {}

loop do
  puts 'Enter the information about your purchase'
  print 'Product name: '
  product = gets.chomp
  print 'Price for one item: '
  price = gets.chomp.to_f
  print 'Number of items purchased: '
  number = gets.chomp.to_f

  purchases[product] = { price: price, number: number }

  puts 'Type "exit" to finish or "Enter" to continue'
  break if gets.chomp == 'exit'
end

puts
p purchases
puts

total = 0
puts 'You have purchased the following products'
purchases.each do |product, details|
  payment = details[:price] * details[:number]
  puts "#{product} for #{payment}$"
  total += payment
end

puts "Total: #{total}$"
