# puts "path to subtitle:"
# path=gets.chomp
# puts "time to adjust - for negative"
# adjustTime=gets.to_i
timeFlag=true
path="interview.srt"
adjustTime = -32
file = File.new(path,'r')
dest = File.new('final.srt','w')
rawTime=Array.new
def timeAdd(hh,mm,ss,adjustTime)
  ss = ss + adjustTime
  if ss > 60
    mm += ss/60
    ss = ss%60
  end
  if mm > 60
    hh += mm/60
    mm = mm%60
  end
  p "#{hh}:#{mm}:#{ss}"
  "#{hh}:#{mm}:#{ss}"
end
  file.each do
    |line|
    if line.include? "-->"
      #time change code goes here
      p line
      rawTime = line.split" --> "
      p rawTime
      time = []
      rawTime.each {|item| time.push(item.split",")}
      newTime = Array.new
      2.times do
        |i|
        h,m,s = time[i][0].split(":")
        if timeFlag == true #run the chech only once
          timeFlag = false
          if((adjustTime.to_i).abs>s.to_i)
            p "cannot change"
            file.close
            dest.close
            File.delete("final.srt")
            exit
          end
        end
        newTime.push("#{timeAdd(h.to_i,m.to_i,s.to_i,adjustTime)},#{time[i][1].to_i}")
      end
      p newTime
      dest.puts("#{newTime[0]} --> #{newTime[1]}\n")
    else
      dest.puts(line)
    end
  end
file.close
dest.close
