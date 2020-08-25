months_days =
  [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

def leap_year?(year)
  ((year % 4).zero? && (year % 100).nonzero?) || (year % 400).zero?
end

print 'Enter the year: '
year = gets.to_i
print 'Enter the month number: '
month = gets.to_i
print 'Enter the day: '
day = gets.to_i

months_days[1] = 29 if leap_year?(year)
months_days.take(month - 1).sum + day
