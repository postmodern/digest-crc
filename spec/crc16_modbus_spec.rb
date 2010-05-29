require 'spec_helper'
require 'crc_examples'
require 'digest/crc16_modbus'

describe Digest::CRC16Modbus do
  before(:all) do
    @crc_class = Digest::CRC16Modbus
    @string = '1234567890'
    @expected = 'c20a'
  end

  it_should_behave_like "CRC"
end
