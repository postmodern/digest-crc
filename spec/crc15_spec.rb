require 'spec_helper'
require 'crc_examples'
require 'digest/crc15'

describe Digest::CRC15 do
  let(:string)   { '1234567890123456789' }
  let(:expected) { '38d0' }

  it_should_behave_like "CRC"
end
