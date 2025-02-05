require 'spec_helper'
require 'crc_examples'
require 'digest/crc64'

describe Digest::CRC64 do
  let(:string)   { '1234567890123456789' }
  let(:expected) { 'e6c8b671184bb966' }

  it_should_behave_like "CRC"
end
