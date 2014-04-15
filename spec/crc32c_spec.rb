require 'spec_helper'
require 'crc_examples'
require 'digest/crc32c'

describe Digest::CRC32c do
  let(:string)   { '1234567890' }
  let(:expected) { 'f3dbd4fe' }

  it_should_behave_like "CRC"
end

describe 'Nested class from Digest::CRC32c' do
  include_context 'custom CRC classes', Digest::CRC32c, '1234567890', '6448cd9a'
end
