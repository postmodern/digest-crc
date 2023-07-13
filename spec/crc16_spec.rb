require 'spec_helper'
require 'crc_examples'
require 'digest/crc16'

describe Digest::CRC16 do
  let(:string)   { '1234567890123456789' }
  let(:expected) { 'b6ea' }

  it_should_behave_like "CRC"
end
