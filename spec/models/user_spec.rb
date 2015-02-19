require 'spec_helper'

describe User do
  describe :validations do
    it { should have_many :trysts }
  end
  
end
