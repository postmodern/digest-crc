require 'digest/crc16'

module Digest
  #
  # Implements the CRC16 Genibus algorithm.
  #
  # @since 0.5.0
  #
  class CRC16Genibus < CRC16

    POLYNOMIAL = 0x1021

    INPUT_REFLECTED = false

    INIT_XOR = 0xffff

    INIT_CRC = 0x0000 ^ INIT_XOR

    XOR_MASK = 0xffff

    TABLE = build_table

    #
    # Updates the CRC16 Genibus checksum.
    #
    # @param [String] data
    #   The data to update the checksum with.
    #
    def update(data)
      data.each_byte do |b|
        @crc = (@table[((@crc >> 8) ^ b) & 0xff] ^ (@crc << 8)) & 0xffff
      end

      return self
    end

  end
end
