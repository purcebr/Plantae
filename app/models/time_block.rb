class TimeBlock < ActiveRecord::Base
  belongs_to :tryst
  validates_presence_of :tryst_id
  has_many :pauses

  scope :ordered, -> { order("start_time asc") }

  def is_finished?
    return true if finished_at.present?
    return false if is_paused?
    if end_time <= Time.now
      self.update_attributes(finished_at: end_time)
      return true
    end
    false
  end

  def is_break
    !is_pom
  end

  def is_paused?
    pauses.any?{ |pause| pause.length_s.blank? }
  end

  def last_pause
    pauses.ordered.last
  end

  def end_time
    start_time + length_s + pauses_length
  end

  def remaining_s
    end_time.to_i - Time.now.to_i 
  end

  def pauses_length
    pauses.any? && pauses.pluck(:length_s).reduce(:+) || 0
  end

end