require 'spec_helper'

shared_examples_for "CRC" do
  it "should calculate a checksum for text" do
    expect(described_class.hexdigest(string)).to be == expected
  end

  it "should calculate a checksum for multiple data" do
    middle = (string.length / 2)

    chunk1 = string[0...middle]
    chunk2 = string[middle..-1]

    crc = subject
    crc << chunk1
    crc << chunk2

    expect(crc.hexdigest).to be == expected
  end

  it "should provide direct access to the checksum value" do
    crc = subject
    crc << string

    expect(crc.checksum).to be == expected.to_i(16)
  end

  it "should be the length of the result of pack, based on width, and expressed in big endian" do
    code = 0xf0f1f2f3f4f5f6f7f8f9fafbfcfdfeff

    case described_class::WIDTH
    when 1
      # NOTE: The current Digest::CRC1 is an 8-bit checksum, so this code may change in the future
      digest = "\xff".b
    when 5
      digest = "\x1f".b
    when 8
      digest = "\xff".b
    when 15
      digest = "\x7e\xff".b
    when 16
      digest = "\xfe\xff".b
    when 24
      digest = "\xfd\xfe\xff".b
    when 32
      digest = "\xfc\xfd\xfe\xff".b
    when 64
      digest = "\xf8\xf9\xfa\xfb\xfc\xfd\xfe\xff".b
    else
      raise "Need to enhance specs for unanticipated number of bits (for WIDTH is #{described_class::WIDTH})"
    end

    expect(described_class.pack(code)).to be == digest
  end

  if defined?(Ractor)
    it "should calculate CRC inside ractor" do
      digest = Ractor.new(described_class, string) do |klass, string|
        klass.hexdigest(string)
      end.take

      expect(digest).to eq expected
    end
  end
end
