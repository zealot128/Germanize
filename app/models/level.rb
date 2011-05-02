class Level < ActiveRecord::Base
  belongs_to :word
  belongs_to :exercise
  
  def correct
    self.level = [self.level+1,8].min
    set_time
  end
  
  def wrong
    self.level = [self.level-1,0].max
    set_time
  end
  
  def set_time
    new_time = Level.level_time(self.level)
    self.next_visit = new_time
  end

  def self.level_time(level)
    time = case level
      when 0 then lambda {5.minutes}
      when 1 then lambda {20.minutes }
      when 2 then lambda {1.hour }
      when 3 then lambda {12.hours }
      when 4 then lambda {1.day}
      when 5 then lambda {5.days}
      when 6 then lambda {15.days}
      when 7 then lambda {30.days}
      when 8 then lambda {6.months}
    else raise "Error"
    end
    time.call.from_now
  end
    
end
