require 'spec_helper'
require 'crc_examples'
require 'digest/crc64'

describe Digest::CRC64 do
  before(:all) do
    @crc_class = Digest::CRC64
    @string = '1234567890'
    @expected = 'bc66a5a9388a5bef'
  end

  it_should_behave_like "CRC"
end
