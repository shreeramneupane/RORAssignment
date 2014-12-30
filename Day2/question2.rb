def distribute(diamondArray)
  sum = 0
  personalDiamond = Array.new
  for i in 0..diamondArray.length-1
    sum += diamondArray[i]
  end
  diamondShare = sum/3 #number of diamond to share to each person
  if (sum%3 != 0 || diamondArray.length < 3)
    puts "diamonds cannot be distributed equally"
  else
    for i in 0..2
      personalDiamond << ["person#{personalDiamond.length+1}"]
      assignDiamond(diamondShare,personalDiamond,diamondArray)
    end
  end
  puts personalDiamond
end

def assignDiamond(diamondShare,personalDiamond,diamondArray)
  maxValue = diamondArray.max
  personalDiamond[personalDiamond.length-1] << maxValue
  pos = diamondArray.find_index(maxValue)
  diamondArray.delete_at(pos)
  if(diamondShare != maxValue)
    diff = diamondShare-maxValue
      if (diamondArray.include? diff)
        personalDiamond[personalDiamond.length-1] << diff
        pos2 = diamondArray.find_index(diff)
        diamondArray.delete_at(pos2)
      else
        assignDiamond(diff,personalDiamond,diamondArray)
    end
  end
end
distribute ([1,2,3,4,5,6,3,3,3,6])
#distribute ([1,2,3,4,5])