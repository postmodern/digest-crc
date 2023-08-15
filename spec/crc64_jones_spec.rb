require 'spec_helper'
require 'crc_examples'
require 'digest/crc64_jones'

describe Digest::CRC64Jones do
  let(:string)   { '1234567890123456789' }
  let(:expected) { 'c5b27dfe868bb180' }

  it_should_behave_like "CRC"
end
