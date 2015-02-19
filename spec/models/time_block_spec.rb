require 'spec_helper'

describe TimeBlock do
  describe :validations do
    it { should have_many :pauses }
    it { should belong_to :tryst }
    it { should validate_presence_of :tryst_id }
  end

  describe :is_break do 
    it "is break if it isn't pom" do 
      time_block = TimeBlock.new
      expect(time_block.is_break).to be_true
    end
  end

  describe :is_finished? do 
    it "returns true if end_time present" do 
      time_block = TimeBlock.new(finished_at: Time.now)
      expect(time_block.is_finished?).to be_true
      expect(time_block.is_paused?).to be_false 
    end

    it "should return false if its paused" do
      time_block = FactoryGirl.create(:time_block) 
      pause = FactoryGirl.create(:pause, time_block: time_block)
      expect(time_block.is_finished?).to be_false
    end

    it "should not be finished if it isnt finished" do
      time_block = FactoryGirl.create(:time_block) 
      pause = FactoryGirl.create(:pause, time_block: time_block, length_s: 500)
      expect(time_block.is_finished?).to be_false
    end

    it "should be finished if end_time is done and should set finished at" do
      time_block = FactoryGirl.create(:time_block, start_time: Time.now - 1.day)
      expect(time_block.is_finished?).to be_true
      time_block.reload
      expect(time_block.finished_at).to be_present
    end

    it "should be finished if end_time is done and should set finished at with pauses" do
      time_block = FactoryGirl.create(:time_block, start_time: Time.now - 1.day)
      pause = FactoryGirl.create(:pause, time_block: time_block, length_s: 500)
      expect(time_block.is_finished?).to be_true
      time_block.reload
      expect(time_block.finished_at).to be_present
    end
  end
end
