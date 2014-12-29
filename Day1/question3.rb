puts "Enter any number"
num = gets.to_i
isprime = true
for i in 2..num-1
  if(num%i == 0)
    isprime = false
    break
  end
end
if(isprime == true)
  puts "#{num} is prime"
else
  puts "#{num} is composite"
end