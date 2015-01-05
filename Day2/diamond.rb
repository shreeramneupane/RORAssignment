def assignDiamond(diamonds)

  personalDiamond = Hash.new
  sum = diamonds.inject(0) { |sum, item| sum + item }
  diamondShare = sum/3

  if(sum%3 != 0 || diamonds.max > diamondShare)
    puts "Diamonds can't be distributed equally"
  else
    3.times do
      person = 'person ' << (personalDiamond.length+1).to_s
      personalDiamond[:"#{person}"] = []
      maxVal = diamonds.max
      personalDiamond[:"#{person}"] << maxVal
      pos = diamonds.index(maxVal)
      diamonds.delete_at(pos)
      if maxVal != diamondShare
        total = maxVal
        possibleDiamonds = (1..maxVal).to_a
        possibleDiamonds.reverse.inject(0) do
        |index,item|
          if(diamonds.include? item)
            count = (diamonds.size.times.select {|i| diamonds[i] == item}).size
            count.times do
              if(item + total <= diamondShare)
                personalDiamond[:"#{person}"] << item
                pos = diamonds.index(item)
                diamonds.delete_at(pos)
                total += item
                if(total == diamondShare)
                  break
                end
              else
                break
              end
            end
          end
        end
        diamonds.to_s
        if (total != diamondShare)
          puts "Diamonds can't be distributed equally"
          personalDiamond = []
          break
        end
      end
    end
    p personalDiamond.to_s
  end
end

diamonds = [3,2,2,2,2,2,1,1]
assignDiamond(diamonds)

assignDiamond([1,2,3,4,5,6,3,3,3,6])
# assignDiamond([1,2,3,4,5])
# assignDiamond([1,2,3,4,5,232,3243,23423])
