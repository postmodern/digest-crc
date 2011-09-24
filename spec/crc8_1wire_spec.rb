require 'spec_helper'
require 'crc_examples'
require 'digest/crc8_1wire'

describe Digest::CRC81Wire do
  before(:all) do
    @crc_class = Digest::CRC81Wire
    @string = '1234567890'
    @expected = '4f'
  end

  it_should_behave_like "CRC"
end