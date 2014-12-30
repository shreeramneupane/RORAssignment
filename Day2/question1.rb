def myMap(arr)
  for i in 0..arr.length-1
    yield arr[i]*2
  end
end
tempArr = Array.new
myMap([1,2,3,4,4]){|item| tempArr<<item}
puts tempArr