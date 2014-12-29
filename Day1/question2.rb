num1, num2 = 1,1
puts num1
puts num2
for i in 1..18
  sum =num1+num2
  puts sum
  num1=num2
  num2 =sum
end