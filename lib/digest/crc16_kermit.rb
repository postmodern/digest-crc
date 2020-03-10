require "digest/crc16"

module Digest
  #
  # Implements Kermit's CRC16 function.
  #
  # @since 0.5.0
  #
  class CRC16Kermit < CRC16

    POLYNOMIAL = 0x1021

    INPUT_REFLECTED = true

    TABLE = build_table

    #
    # Updates the CRC16 Kermit checksum.
    #
    # @param [String] data
    #   The data to update the checksum with.
    #
    def update(data)
      data.each_byte do |b|
        @crc = (@table[(@crc ^ b) & 0xff] ^ (@crc >> 8)) & 0xffff
      end

      return self
    end

  end
end
