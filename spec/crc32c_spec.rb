require 'spec_helper'
require 'crc_examples'
require 'digest/crc32c'

describe Digest::CRC32c do
  let(:string)   { '1234567890123456789' }
  let(:expected) { '8d155cb9' }

  it_should_behave_like "CRC"
end
