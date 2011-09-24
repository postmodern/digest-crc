require 'spec_helper'
require 'crc_examples'
require 'digest/crc16_xmodem'

describe Digest::CRC16XModem do
  before(:all) do
    @string = '1234567890'
    @expected = 'd321'
  end

  it_should_behave_like "CRC"
end
