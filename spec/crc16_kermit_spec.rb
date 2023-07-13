require 'spec_helper'
require 'crc_examples'
require 'digest/crc16_kermit'

describe Digest::CRC16Kermit do
  let(:string)   { '1234567890123456789' }
  let(:expected) { '0252' }

  it_should_behave_like "CRC"
end
