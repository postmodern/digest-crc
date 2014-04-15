require 'spec_helper'
require 'crc_examples'
require 'digest/crc16_usb'

describe Digest::CRC16USB do
  let(:string)   { '1234567890' }
  let(:expected) { '3df5' }

  it_should_behave_like "CRC"
end

describe 'Nested class from Digest::CRC16USB' do
  include_context 'custom CRC classes', Digest::CRC16USB, '1234567890', '7c0c'
end
