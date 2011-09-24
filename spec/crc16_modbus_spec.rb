require 'spec_helper'
require 'crc_examples'
require 'digest/crc16_modbus'

describe Digest::CRC16Modbus do
  before(:all) do
    @string = '1234567890'
    @expected = 'c20a'
  end

  it_should_behave_like "CRC"
end
