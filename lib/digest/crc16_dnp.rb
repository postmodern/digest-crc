require 'digest/crc16'

module Digest
  #
  # Implements the CRC16 DNP algorithm.
  #
  class CRC16DNP < CRC16

    POLYNOMIAL = 0x3d65

    INPUT_REFLECTED = true

    INIT_CRC = 0

    TABLE = build_table

    #
    # Updates the CRC16 DNP checksum.
    #
    # @param [String] data
    #   The data to update the checksum with.
    #
    def update(data)
      data.each_byte do |b|
        @crc = ((@crc >> 8) ^ @table[(@crc ^ b) & 0xff])
      end

      return self
    end

    def finish
      self.class.pack(~@crc)
    end

  end
end
