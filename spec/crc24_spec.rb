require 'spec_helper'
require 'crc_examples'
require 'digest/crc24'

describe Digest::CRC24 do
  before(:all) do
    @string = '1234567890'
    @expected = '8c0072'
  end

  it_should_behave_like "CRC"
end
