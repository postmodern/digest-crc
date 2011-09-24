require 'spec_helper'
require 'crc_examples'
require 'digest/crc16_ccitt'

describe Digest::CRC16CCITT do
  before(:all) do
    @string = '1234567890'
    @expected = '3218'
  end

  it_should_behave_like "CRC"
end
