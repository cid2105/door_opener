class Alarm < ActiveRecord::Base
  require 'securerandom'

  after_initialize :generate_key
  validates :hour, :presence => { :if => lambda { self.active } }, :inclusion =>  0..23, :allow_nil => true
  validates :minute, :presence => {:if => lambda { self.active }}, :inclusion => 0..59, :allow_nil => true
  validates :key, :length => {:is => 8}, :on => :create
  

  attr_accessible :active, :hour, :key, :minute

  def to_s
  	"#{hour}:#{minute} " + ((hour > 12)? "AM" : "PM")
  end

  def beep
  	active and Time.now.in_time_zone("America/New_York").hour >= hour and Time.now.in_time_zone("America/New_York").minute >= minute
  end

  def generate_key(random_str = SecureRandom.hex(4))
  	random_str = SecureRandom.hex(4) until Alarm.find_by_key(random_str).nil?	
  	self.key = random_str;
  end

end
