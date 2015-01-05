def myMap(arr)
  for i in 0..arr.length-1
    yield arr[i]
  end
end
myMap([1,2,3,4,4]){|item| puts item*2}
