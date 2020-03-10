require 'digest/crc32'

module Digest
  #
  # Implements the CRC32 Mpeg algorithm.
  #
  class CRC32MPEG < CRC32

    INPUT_REFLECTED = false

    XOR_MASK = 0x00000000

    TABLE = build_table

    #
    # Updates the CRC32 Mpeg checksum.
    #
    # @param [String] data
    #   The data to update the checksum with.
    #
    def update(data)
      data.each_byte do |b|
        @crc = ((@table[((@crc >> 24) ^ b) & 0xff] ^ (@crc << 8)) & 0xffffffff)
      end

      return self
    end

  end

  # @deprecated Please use {CRC32MPEG}.
  CRC32Mpeg = CRC32MPEG
end
