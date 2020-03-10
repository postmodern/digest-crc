require 'digest/crc'

module Digest
  #
  # Implements the CRC15 algorithm.
  #
  # @since 0.5.0
  #
  class CRC15 < CRC

    WIDTH = 15

    POLYNOMIAL = 0x4599

    INPUT_REFLECTED = false

    TABLE = build_table

    #
    # Packs the CRC15 checksum.
    #
    # @param [Integer] crc
    #   The CRC15 checksum to pack.
    #
    # @return [String]
    #   The packed CRC15 checksum.
    #
    def self.pack(crc)
      buffer = ''

      buffer << ((crc & 0x7f00) >> 8).chr
      buffer << (crc & 0xff).chr

      buffer
    end

    #
    # Updates the CRC15 checksum.
    #
    # @param [String] data
    #   The data to update the checksum with.
    #
    def update(data)
      data.each_byte do |b|
        @crc = (@table[((@crc >> 7) ^ b) & 0xff] ^ (@crc << 8)) & 0x7fff
      end

      return self
    end

  end
end
