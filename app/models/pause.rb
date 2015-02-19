class Pause < ActiveRecord::Base
  belongs_to :time_block
  scope :ordered, -> { order("start_time asc") }

end