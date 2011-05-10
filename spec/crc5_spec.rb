require 'spec_helper'
require 'crc_examples'
require 'digest/crc5'

describe Digest::CRC5 do
  before(:all) do
    @crc_class = Digest::CRC5
    @string = '1234567890'
    @expected = '1'
  end

  pending "Implementation of CRC5 does not match pycrc.py" do
    it_should_behave_like "CRC"
  end
end
