require 'spec_helper'
require 'crc_examples'
require 'digest/crc16_usb'

describe Digest::CRC16USB do
  before(:all) do
    @string = '1234567890'
    @expected = '3df5'
  end

  it_should_behave_like "CRC"
end
