require 'digest/crc32'

module Digest
  #
  # Implements the CRC32 POSIX algorithm.
  #
  class CRC32POSIX < CRC32

    POLYNOMIAL = 0x04c11db7

    INPUT_REFLECTED = false

    INIT_CRC = 0x00000000

    TABLE = build_table

    #
    # Updates the CRC32 POSIX checksum.
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
