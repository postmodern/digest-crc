require 'spec_helper'
require 'crc_examples'
require 'digest/crc24'

describe Digest::CRC24 do
  let(:string) { '1234567890123456789' }
  let(:expected) { 'e4bcb9' }

  it_should_behave_like "CRC"
end
