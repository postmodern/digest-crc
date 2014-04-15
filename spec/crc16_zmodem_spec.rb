require 'spec_helper'
require 'crc_examples'
require 'digest/crc16_zmodem'

describe Digest::CRC16ZModem do
  let(:string) { '1234567890' }
  let(:expected) { 'd321' }

  it_should_behave_like "CRC"
end

describe 'Nested class from Digest::CRC16ZModem' do
  include_context 'custom CRC classes', Digest::CRC16ZModem, '1234567890', '6aa7'
end
