months_days =
  [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

def leap_year?(year)
  leap = year % 4 == 0

  if year % 100 == 0
    leap = false
    if year % 400 == 0
      leap = true
    end
  end

  leap
end

print 'Enter the year: '
year = gets.to_i
print 'Enter the month number: '
month = gets.to_i
print 'Enter the day: '
day = gets.to_i

day_in_year = 0

0.upto(month-2) do |month|
  day_in_year += months_days[month]
  day_in_year += 1 if month == 1 && leap_year?(year)
end

day_in_year += day
