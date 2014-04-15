require 'spec_helper'
require 'crc_examples'
require 'digest/crc64'

describe Digest::CRC64 do
  let(:string)   { '1234567890' }
  let(:expected) { 'bc66a5a9388a5bef' }

  it_should_behave_like "CRC"
end

describe 'Nested class from Digest::CRC64' do
  include_context 'custom CRC classes', Digest::CRC64, '1234567890', '1e3eb22c0ea4afab'
end
