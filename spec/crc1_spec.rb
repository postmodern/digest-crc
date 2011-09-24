require 'spec_helper'
require 'crc_examples'
require 'digest/crc1'

describe Digest::CRC1 do
  before(:all) do
    @string = '1234567890'
    @expected = '0d'
  end

  it_should_behave_like "CRC"
end
