require 'spec_helper'
require 'crc_examples'
require 'digest/crc64_xz'

describe Digest::CRC64XZ do
  let(:string)   { '1234567890123456789' }
  let(:expected) { '6eecc5f3f4c26bd9' }

  it_should_behave_like "CRC"
end
