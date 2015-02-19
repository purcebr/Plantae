require 'spec_helper'

describe Pause do
  describe :validations do
    it { should belong_to :time_block }
  end

end
