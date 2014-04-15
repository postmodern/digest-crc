require 'spec_helper'
require 'crc_examples'
require 'digest/crc24'

describe Digest::CRC24 do
  let(:string) { '1234567890' }
  let(:expected) { '8c0072' }

  it_should_behave_like "CRC"
end

describe 'Nested class from Digest::CRC24' do
  include_context 'custom CRC classes', Digest::CRC24, '1234567890', '943999'
end
