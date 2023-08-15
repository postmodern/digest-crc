require 'spec_helper'
require 'crc_examples'
require 'digest/crc32'

describe Digest::CRC32 do
  let(:string) { '1234567890123456789' }
  let(:expected) { 'd36e1319' }

  it_should_behave_like "CRC"
end
