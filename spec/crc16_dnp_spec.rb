require 'spec_helper'
require 'crc_examples'
require 'digest/crc16_dnp'

describe Digest::CRC16DNP do
  let(:string)   { '1234567890' }
  let(:expected) { 'bc1b' }

  it_should_behave_like "CRC"
end
