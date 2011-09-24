require 'spec_helper'
require 'crc_examples'
require 'digest/crc32_mpeg'

describe Digest::CRC32Mpeg do
  before(:all) do
    @string = '1234567890'
    @expected = 'af97ac49'
  end

  it_should_behave_like "CRC"
end
