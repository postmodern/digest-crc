require 'spec_helper'
require 'crc_examples'
require 'digest/crc16_ccitt'

describe Digest::CRC16CCITT do
  let(:string)   { '1234567890' }
  let(:expected) { '3218' }

  it_should_behave_like "CRC"
end

describe 'Nested class from Digest::CRC16CCITT' do
  include_context 'custom CRC classes', Digest::CRC16CCITT, '1234567890', '6447'
end
