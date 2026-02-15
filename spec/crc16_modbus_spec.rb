require 'spec_helper'
require 'crc_examples'
require 'digest/crc16_modbus'

describe Digest::CRC16Modbus do
  let(:string)   { '1234567890123456789' }
  let(:expected) { '92ce' }

  it_should_behave_like "CRC"
end
