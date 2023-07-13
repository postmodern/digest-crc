require 'spec_helper'
require 'crc_examples'
require 'digest/crc16_xmodem'

describe Digest::CRC16XModem do
  let(:string)   { '1234567890123456789' }
  let(:expected) { '93a9' }

  it_should_behave_like "CRC"
end
