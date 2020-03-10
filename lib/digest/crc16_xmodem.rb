require 'digest/crc16'

module Digest
  #
  # Implements the CRC16 XMmodem algorithm.
  #
  class CRC16XModem < CRC16

    POLYNOMIAL = 0x1021

    INPUT_REFLECTED = false

    TABLE = build_table

    #
    # Updates the CRC16 XModem checksum.
    #
    # @param [String] data
    #   The data to update the checksum with.
    #
    def update(data)
      data.each_byte do |b|
        @crc = ((@table[((@crc >> 8) ^ b) & 0xff] ^ (@crc << 8)) & 0xffff)
      end

      return self
    end

  end
end
