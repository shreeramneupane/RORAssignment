puts "Enter the year in AD"
=begin
rawYear = gets
if /^(?<year>\d+)$/ =~ rawYear
  year = year.to_i
  if((year%400 == 0) || ((year%400 != 0) && (year%100 != 0) && (year%4 == 0)))
    puts "#{year} is leap year"
  else
    puts "#{year} isn't leap year"
  end
else
  puts "Please enter valid year"
end
=end
rawYear = gets
begin
  year = Integer(rawYear)
    if(year<=0)
      puts "Please enter valid year"
    elsif((year%400 == 0) || ((year%400 != 0) && (year%100 != 0) && (year%4 == 0)))
      puts "#{year} is leap year"
    else
      puts "#{year} isn't leap year"
    end
rescue
  puts "Please enter valid year"
end
