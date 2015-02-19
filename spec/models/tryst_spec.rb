require 'spec_helper'

describe Tryst do
  describe :validations do
    it { should have_many :time_blocks }
    it { should belong_to :user }
    it { should validate_presence_of :user_id }
  end

  describe :create_next_time_block do 
    it "creates the first pomodoro" do
      # pp FactoryGirl.create(:user)
      tryst = FactoryGirl.create(:tryst)
      expect(tryst.valid?).to be_true
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

end
