class Clock < ApplicationRecord
  belongs_to :user

  def sort_by_sleep_duration
    (self.clock_out_time - self.clock_in_time)/3600
  end
end
