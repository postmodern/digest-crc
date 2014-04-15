require 'spec_helper'
require 'crc_examples'
require 'digest/crc16'

describe Digest::CRC16 do
  let(:string)   { '1234567890' }
  let(:expected) { 'c57a' }

  it_should_behave_like "CRC"
end

describe 'Nested class from Digest::CRC16' do
  include_context 'custom CRC classes', Digest::CRC16, '1234567890', '01fc'
end
