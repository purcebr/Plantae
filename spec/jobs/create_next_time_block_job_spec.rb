require 'spec_helper'

describe CreateNextTimeBlockJob do
  describe :perform do 
    it "calls create_next_time_block" do 
      tryst = Tryst.new 
      expect(tryst).to receive(:create_next_time_block).once
      CreateNextTimeBlockJob.new.perform(tryst)
    end
  end

end