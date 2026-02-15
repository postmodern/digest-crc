require 'spec_helper'
require 'crc_examples'
require 'digest/crc16_x_25'

describe Digest::CRC16X25 do
  let(:string)   { '1234567890123456789' }
  let(:expected) { '7b60' }

  it_should_behave_like "CRC"
end
