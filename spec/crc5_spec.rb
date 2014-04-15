require 'spec_helper'
require 'crc_examples'
require 'digest/crc5'

describe Digest::CRC5 do
  let(:string)   { '1234567890' }
  let(:expected) { '1' }

  pending "Implementation of CRC5 does not match pycrc.py" do
    it_should_behave_like "CRC"
  end
end

describe 'Nested class from Digest::CRC5' do
  pending 'Implementation of CRC5 does not match pycrc.py' do
    include_context 'custom CRC classes', Digest::CRC5, '1234567890', '1'
  end
end
