class PmsController < ApplicationController
  
  def index
    @results = read_pms_results()
    @key_arr = []
    if @results.nil?
      @results = []
    else
      @key_arr = @results.keys
      @key_arr.each do |ikey|
        instance = @results[ikey]
        puts "INSATNCE: #{instance}"
        case (instance[:current_status])
        when -88
          instance[:status_string] = "ERROR"
        when -1
          instance[:status_string] = "FAILED"
        else
          formatted_time = format_mins(instance[:current_status])
          instance[:status_string] = "PASSED - #{formatted_time}"
        end
      end
      puts "FINAL #{@results}"
    end
  end
  
  private 
  
  def format_mins(min_count)
    rstr = "#{min_count} Minutes"
    if min_count >= 60
      hrs = min_count / 60
      mins = min_count % 60
      if hrs <= 1
        rstr = "#{hrs} Hour #{mins} Minutes"
      else
        rstr = "#{hrs} Hours #{mins} Minutes"
      end
    else
      if min_count == 1
        rstr = "#{min_count} Minute"
      end 
    end
    return rstr
  end
  
  def read_pms_results()
    uhome = ENV["HOME"]
    resfile = uhome + "\\Documents\\NewNav_FilesWebdriver\\AsperaAutomation\\Test_Suite_Web\\files_ui\\pmaker_results.yml"
    rhash = nil
    if File.exists?(resfile)
      rhash = YAML.load_file(resfile)
    end
    puts "RESULT: #{rhash}"
    return rhash
  end
  
end
