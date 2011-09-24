require 'spec_helper'
require 'crc_examples'
require 'digest/crc32c'

describe Digest::CRC32c do
  before(:all) do
    @string = '1234567890'
    @expected = 'f3dbd4fe'
  end

  it_should_behave_like "CRC"
end
