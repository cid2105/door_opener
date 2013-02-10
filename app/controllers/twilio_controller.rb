class TwilioController < ApplicationController

  def process_sms
  	message_body, from_number = params["Body"], params["From"]
    @unauthorized = (from_number != "+15169967037")
    @wrong_pass = (params["Body"] != "boblsaget")
    Door.first.update_attribute("open", true) unless @unauthorized or @wrong_pass
    render 'process_sms.xml.erb', :content_type => 'text/xml'
  end

  def check_door_status
  	if Door.first.open
  		Door.first.update_attribute("open", false)
  		render :text => 'success'
  	else
  		render :text => 'failure'
  	end
  end

end
