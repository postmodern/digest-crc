require 'spec_helper'
require 'crc_examples'
require 'digest/crc16_xmodem'

describe Digest::CRC16XModem do
  let(:string)   { '1234567890' }
  let(:expected) { 'd321' }

  it_should_behave_like "CRC"
end

describe 'Nested class from Digest::CRC16XModem' do
  include_context 'custom CRC classes', Digest::CRC16XModem, '1234567890', '6aa7'
end
