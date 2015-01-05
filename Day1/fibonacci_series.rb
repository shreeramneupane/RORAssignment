num1, num2 = 0,1
sum = 0
for i in 1..20
  puts num1
  sum =num1+num2
  num1=num2
  num2 =sum
end