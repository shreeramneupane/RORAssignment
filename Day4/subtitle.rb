class Subtitle
  attr_accessor :file_path, :time_to_adjust

  def initialize(file_path,time_to_adjust)
    @file_path = file_path
    @time_to_adjust = time_to_adjust
  end

  def create_new_srt
    begin
      old_srt = File.open(@file_path,'r')
      if @file_path.rindex('/')
        new_srt_name = 'new_' << @file_path.slice(@file_path.rindex('/')+1,@file_path.length-@file_path.rindex('/'))
      else
        new_srt_name = 'new_' << "#{@file_path}"
      end
      new_srt = File.new(new_srt_name,'w')
      error = false
      old_srt.each do |line|
        if line.include? '-->'
          from = line.split('-->').first
          begin
            new_srt.print adjust_time(from) << '-->'
            to = line.split('-->').last
            if to.include? ' '
              new_srt.print ' ' << adjust_time(to)
            else
              new_srt.print adjust_time(to)
            end
          rescue TypeError
            puts 'new srt file of this file with given time to adjust is not possible'
            File.delete(new_srt_name)
            error = true
            break
          end
        else
          new_srt.puts line
        end
      end
    rescue Errno::ENOENT
      puts "#{@file_path} file open error"
    end
    old_srt.close
    unless error
      new_srt.close
      puts "\'#{new_srt_name}\' named srt file is successfully created by adjusting time input in recent project location"
    end
  end

  def adjust_time(time_stamp)
    time_array = time_stamp.split(':')
    last_values = (time_array[time_array.length-1]).split(',')
    time_array.delete_at(time_array.length-1)
    time_array += last_values
    new_second = time_array[2].to_i + @time_to_adjust
    new_minute = time_array[1].to_i
    new_hour = time_array[0].to_i
    if new_second > 59
      new_minute = new_minute + new_second/60
      new_second = new_second%60
      if new_minute > 59
        new_hour = new_hour + new_minute/60
        new_minute = new_minute%60
      end
    elsif new_second < 0
      if -new_second < new_minute*60 + new_hour*3600
        p new_time = new_minute*60 + new_hour*3600 + new_second
        new_hour = new_time/3600
        new_minute = (new_time%3600)/60
        new_second = (new_time%3600)%60
      else
        return 0
      end
    end
    new_hour.to_s << ':' << new_minute.to_s << ':' << new_second.to_s << ',' << time_array[time_array.length-1]
  end
end

puts 'Enter the path to srt file in which time is to change'
file_path = gets.chomp
puts 'Enter the time in second to be adjusted'
time = gets
begin
  time_to_adjust = Integer(time)
rescue ArgumentError
  puts 'Please enter valid time in second'
  exit
end

subtitle = Subtitle.new file_path,time_to_adjust
subtitle.create_new_srt
