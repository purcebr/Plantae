class AlreadyInTimeBlockError < StandardError
end

class Tryst < ActiveRecord::Base
  has_many :time_blocks
  belongs_to :user
  validates_presence_of :user_id

  def create_next_time_block
    if time_blocks.present?
      raise AlreadyInTimeBlockError unless last_time_block.is_finished?
      is_pom = !last_time_block.is_pom
      start_time = last_time_block.end_time + 1
    else
      is_pom = true
      start_time = Time.now
    end

    if is_pom
      length_s = pom_length_s
    else
      length_s = break_length_s
    end
    schedule_recreate(length_s)
    TimeBlock.create(:is_pom => is_pom, :tryst_id => id, :start_time => start_time, :length_s => length_s)
  end

  def schedule_recreate(length_s=last_time_block.remaining_s)
    CreateNextTimeBlockJob.set(wait: length_s.seconds).perform_later(self)
  end

  def last_time_block
    time_blocks.ordered.last
  end
end