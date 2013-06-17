class AlarmsController < ApplicationController

  def validate
    render :json => Alarm.exists?(key: params["key"])
  end

  def set
  	if Alarm.exists?(key: params["key"])
      @alarm = Alarm.find_by_key(params["key"])
      if @set and params.has_key?("hour") && params.has_key?("minute") 
        @hour, @minute = params["hour"], params["minute"]
        @alarm.update_attributes(:active => @set, :hour => @hour, :minute => @minute)
      else
        @alarm.update_attributes(:active => false)
      end
    end
  end

  def status
  	if Alarm.exists?(key: params["key"])
  		@alarm = Alarm.find(params["key"])  		
      @response = (@alarm.beep)? "beep" : "don't beep"
  	else
  		@response = "Invalid alarm token"
  	end
    render :json => @response
  end

end
