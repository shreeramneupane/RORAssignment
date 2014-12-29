puts "Enter any number"
=begin
num = gets.to_i
isPrime = true
sqNum = Math.sqrt(num).ceil
for i in 2..sqNum
  if(num % i == 0)
    isPrime = false
    break
  end
end
if(isPrime == true)
  puts "#{num} is prime"
else
  puts "#{num} is composite"
end
=end

rawNum = gets
begin
  num = Integer(rawNum)
  if(num<=0)
    puts "Negative number can't be prime"
  else
    isPrime = true
    sqNum = Math.sqrt(num).ceil
    for i in 2..sqNum
      if(num % i == 0)
        isPrime = false
        break
      end
    end
    if(isPrime == true)
      puts "#{num} is prime"
    else
      puts "#{num} is composite"
    end
  end
rescue
  puts "Please enter valid number"
end