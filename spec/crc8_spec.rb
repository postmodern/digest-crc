require 'spec_helper'
require 'crc_examples'
require 'digest/crc8'

describe Digest::CRC8 do
  let(:string)   { '1234567890' }
  let(:expected) { '52' }

  it_should_behave_like "CRC"
end

describe 'Nested class from Digest::CRC8' do
  include_context 'custom CRC classes', Digest::CRC8, '1234567890', '4f'
end
