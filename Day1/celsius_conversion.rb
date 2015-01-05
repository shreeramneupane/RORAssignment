puts 'Enter the temperature in celsius'
value_input = gets
begin
  celsius = Integer(value_input)
  fahrenheit = 1.8*celsius+32
  puts 'fahrenheit value is ' << fahrenheit.round(2).to_s
rescue
  puts 'Please enter valid celsius temperature'
end
