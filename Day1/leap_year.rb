puts 'Enter the year in AD'
rawYear = gets
begin
  year = Integer(rawYear)
    if year<=0
      puts "Please enter valid year"
    elsif((year%400 == 0) || ((year%400 != 0) && (year%100 != 0) && (year%4 == 0)))
      puts "#{year} is leap year"
    else
      puts "#{year} isn't leap year"
    end
rescue
  puts 'Please enter valid year'
end
