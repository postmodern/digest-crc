require 'spec_helper'
require 'crc_examples'
require 'digest/crc5'

describe Digest::CRC5 do
  before { pending }
  before(:all) do
    @crc_class = Digest::CRC5
    @string = '1234567890'
    @expected = '1'
  end

  it_should_behave_like "CRC"
end
