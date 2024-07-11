require 'spec_helper'
require 'crc_examples'
require 'digest/crc32_xfer'

describe Digest::CRC32XFER do
  let(:string) { '1234567890123456789' }
  let(:expected) { 'a7326a3b' }

  it_should_behave_like "CRC"
end
