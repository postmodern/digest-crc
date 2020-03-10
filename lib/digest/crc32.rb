require 'digest/crc'

module Digest
  #
  # Implements the CRC32 algorithm.
  #
  class CRC32 < CRC

    WIDTH = 32

    POLYNOMIAL = 0x04c11db7

    INPUT_REFLECTED = true

    INIT_CRC = 0xffffffff

    XOR_MASK = 0xffffffff

    TABLE = build_table

    #
    # Packs the CRC32 checksum.
    #
    # @param [Integer] crc
    #   The checksum to pack.
    #
    # @return [String]
    #   The packed checksum.
    #
    def self.pack(crc)
      buffer = ''

      buffer << ((crc & 0xff000000) >> 24).chr
      buffer << ((crc & 0xff0000) >> 16).chr
      buffer << ((crc & 0xff00) >> 8).chr
      buffer << (crc & 0xff).chr

      buffer
    end

    #
    # Updates the CRC32 checksum.
    #
    # @param [String] data
    #   The data to update the checksum with.
    #
    def update(data)
      data.each_byte do |b|
        @crc = @table[(@crc ^ b) & 0xff] ^ ((@crc >> 8) & 0xffffffff)
      end

      return self
    end

  end
end
