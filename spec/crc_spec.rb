require 'spec_helper'
require 'digest/crc'

describe Digest::CRC do
  it "should define block_length of 1" do
    crc = Digest::CRC.new

    crc.block_length.should == 1
  end

  it "should pack to an empty String by default" do
    Digest::CRC.pack(0).should be_empty
  end
end
