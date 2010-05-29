require 'spec_helper'

shared_examples_for "CRC" do
  it "should calculate a checksum for text" do
    @crc_class.hexdigest(@string).should == @expected
  end

  it "should calculate a checksum for multiple data" do
    middle = (@string.length / 2)

    chunk1 = @string[0...middle]
    chunk2 = @string[middle..-1]

    crc = @crc_class.new
    crc << chunk1
    crc << chunk2

    crc.hexdigest.should == @expected
  end

  it "should provide direct access to the checksum value" do
    crc = @crc_class.new
    crc << @string

    crc.checksum.should == @expected.to_i(16)
  end
end
