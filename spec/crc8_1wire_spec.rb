require 'spec_helper'
require 'crc_examples'
require 'digest/crc8_1wire'

describe Digest::CRC81Wire do
  let(:string)   { '1234567890' }
  let(:expected) { '4f' }

  it_should_behave_like "CRC"
end

describe 'Nested class from Digest::CRC81Wire' do
  include_context 'custom CRC classes', Digest::CRC81Wire, '1234567890', '52'
end
