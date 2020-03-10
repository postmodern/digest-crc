require 'digest/crc'

module Digest
  #
  # Implements the CRC64 algorithm.
  #
  class CRC64 < CRC

    WIDTH = 64

    POLYNOMIAL = 0x000000000000001b

    INPUT_REFLECTED = true

    INIT_CRC = 0x0000000000000000

    XOR_MASK = 0x0000000000000000

    TABLE = build_table

    #
    # Packs the CRC64 checksum.
    #
    # @param [Integer] crc
    #   The checksum to pack.
    #
    # @return [String]
    #   The packed checksum.
    #
    def self.pack(crc)
      buffer = ''

      buffer << ((crc & 0xff00000000000000) >> 56).chr
      buffer << ((crc & 0xff000000000000) >> 48).chr
      buffer << ((crc & 0xff0000000000) >> 40).chr
      buffer << ((crc & 0xff00000000) >> 32).chr
      buffer << ((crc & 0xff000000) >> 24).chr
      buffer << ((crc & 0xff0000) >> 16).chr
      buffer << ((crc & 0xff00) >> 8).chr
      buffer << (crc & 0xff).chr

      buffer
    end

    #
    # Updates the CRC64 checksum.
    #
    # @param [String] data
    #   The data to update the checksum with.
    #
    def update(data)
      data.each_byte do |b|
        @crc = ((@table[(@crc ^ b) & 0xff] ^ (@crc >> 8)) & 0xffffffffffffffff)
      end

      return self
    end

  end
end
