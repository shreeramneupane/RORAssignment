puts "Enter the year in AD"
year = gets.to_i
if((year%400==0) | ((year%400 != 0) & (year%100 != 0) & (year%4 == 0)))
  puts "#{year} is leap year"
else
  puts "#{year} isn't leap year"
end