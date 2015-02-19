class CreateNextTimeBlockJob < ActiveJob::Base
  queue_as :timeblocker

  def perform(tryst)
    tryst.create_next_time_block
  end
end
