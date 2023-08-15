require 'spec_helper'
require 'crc_examples'
require 'digest/crc32_jam'

describe Digest::CRC32Jam do
  let(:string) { '1234567890123456789' }
  let(:expected) { '2c91ece6' }

  it_should_behave_like "CRC"
end
