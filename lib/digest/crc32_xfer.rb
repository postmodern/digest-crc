require 'digest/crc32'

module Digest
  #
  # Implements the CRC32 XFER algorithm.
  #
  class CRC32XFER < CRC32

    POLYNOMIAL = 0x000000af

    INPUT_REFLECTED = false

    INIT_CRC = 0x00000000

    XOR_MASK = 0x00000000

    TABLE = build_table

    #
    # Updates the CRC32 XFER checksum.
    #
    # @param [String] data
    #   The data to update the checksum with.
    #
    def update(data)
      data.each_byte do |b|
        @crc = (@table[((@crc >> 24) ^ b) & 0xff] ^ (@crc << 8)) & 0xffffffff
      end

      return self
    end

  end
end
