require 'digest/crc'

module Digest
  #
  # Implements the CRC8 algorithm.
  #
  class CRC8 < CRC

    WIDTH = 8

    POLYNOMIAL = 0x07

    INPUT_REFLECTED = false

    INIT_CRC = 0x00

    TABLE = build_table

    #
    # Packs the CRC8 checksum.
    #
    # @param [Integer] crc
    #   The checksum to pack.
    #
    # @return [String]
    #   The packed checksum.
    #
    def self.pack(crc)
      (crc & 0xff).chr
    end

    #
    # Updates the CRC8 checksum.
    #
    # @param [String] data
    #   The data to update the checksum with.
    #
    def update(data)
      data.each_byte do |b|
        @crc = ((@table[(@crc ^ b) & 0xff] ^ (@crc << 8)) & 0xff)
      end

      return self
    end

  end
end
