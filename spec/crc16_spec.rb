require 'spec_helper'
require 'crc_examples'
require 'digest/crc16'

describe Digest::CRC16 do
  before(:all) do
    @crc_class = Digest::CRC16
    @string = '1234567890'
    @expected = 'c57a'
  end

  it_should_behave_like "CRC"
end
