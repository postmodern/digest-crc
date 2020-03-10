require 'digest/crc'

module Digest
  #
  # Implements the CRC16 algorithm.
  #
  class CRC16 < CRC

    WIDTH = 16

    POLYNOMIAL = 0x8005

    INPUT_REFLECTED = true

    INIT_CRC = 0x0000

    TABLE = build_table

    #
    # Packs the CRC16 checksum.
    #
    # @param [Integer] crc
    #   The CRC16 checksum to pack.
    #
    # @return [String]
    #   The packed CRC16 checksum.
    #
    def self.pack(crc)
      buffer = ''

      buffer << ((crc & 0xff00) >> 8).chr
      buffer << (crc & 0xff).chr

      buffer
    end

    #
    # Updates the CRC16 checksum.
    #
    # @param [String] data
    #   The data to update the checksum with.
    #
    def update(data)
      data.each_byte do |b|
        @crc = ((@table[(@crc ^ b) & 0xff] ^ (@crc >> 8)) & 0xffff)
      end

      return self
    end

  end
end
