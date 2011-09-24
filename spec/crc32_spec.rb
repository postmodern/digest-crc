require 'spec_helper'
require 'crc_examples'
require 'digest/crc32'

describe Digest::CRC32 do
  before(:all) do
    @string = '1234567890'
    @expected = '261daee5'
  end

  it_should_behave_like "CRC"
end
