require 'digest/crc'

module Digest
  #
  # Implements the CRC24 algorithm.
  #
  class CRC24 < CRC

    WIDTH = 24

    POLYNOMIAL = 0x864cfb

    INPUT_REFLECTED = false

    INIT_CRC = 0xb704ce

    TABLE = build_table

    #
    # Packs the CRC24 checksum.
    #
    # @param [Integer] crc
    #   The checksum to pack.
    #
    # @return [String]
    #   The packed checksum.
    #
    def self.pack(crc)
      buffer = ''

      buffer << ((crc & 0xff0000) >> 16).chr
      buffer << ((crc & 0x00ff00) >> 8).chr
      buffer << (crc & 0x0000ff).chr

      buffer
    end

    #
    # Updates the CRC24 checksum.
    #
    # @param [String] data
    #   The data to update the checksum with.
    #
    def update(data)
      data.each_byte do |b|
        @crc = ((@table[((@crc >> 16) ^ b) & 0xff] ^ (@crc << 8)) & 0xffffff)
      end

      return self
    end

  end
end
