require 'spec_helper'

describe Tryst do
  describe :validations do
    it { should have_many :time_blocks }
    it { should belong_to :user }
    it { should validate_presence_of :user_id }
  end

  describe :create_next_time_block do 
    it "creates the first pomodoro and schedules it recreation" do
      tryst = FactoryGirl.create(:tryst)
      expect(tryst).to receive(:schedule_recreate).once 
      tryst.create_next_time_block
      tryst.reload
      expect(tryst.time_blocks.count).to eq(1)
      time_block = tryst.time_blocks.first
      expect(time_block.is_pom).to eq(true)
      expect(time_block.length_s).to be_present
    end

    it "doesn't create second timeblock if currently in a timeblock" do
      tryst = FactoryGirl.create(:tryst)
      expect(tryst.valid?).to be_true
      tryst.create_next_time_block
      tryst.reload
      expect(tryst.time_blocks.count).to eq(1)
      expect{tryst.create_next_time_block}.to raise_error(AlreadyInTimeBlockError)
      tryst.reload
      expect(tryst.time_blocks.count).to eq(1)
    end
  end

  describe :schedule_recreate  do 
    it "creates a schedule_recreate job" do
      tryst = Tryst.new
      expect{tryst.schedule_recreate(100)}.to change{ActiveJob::Base.queue_adapter.enqueued_jobs.count}.by(1)
      job = ActiveJob::Base.queue_adapter.enqueued_jobs.last
      expect(job[:job]).to eq(CreateNextTimeBlockJob)
      expect(job[:args].first).to eq(tryst)
    end
    it "schedules a recreate at the last block end_time" do
      time_block = FactoryGirl.create(:time_block)
      tryst = time_block.tryst
      pause = FactoryGirl.create(:pause, time_block: time_block, length_s: 500)
      remaining_s = tryst.last_time_block.remaining_s
      tryst.schedule_recreate
      expect(ActiveJob::Base.queue_adapter.enqueued_jobs.last[:at].to_i).to eq(time_block.end_time.to_i)
    end

  end

end
