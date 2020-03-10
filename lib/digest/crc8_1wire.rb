require 'digest/crc8'

module Digest
  #
  # Implements the CRC8 1-Wire algorithm.
  #
  class CRC8_1Wire < CRC8

    POLYNOMIAL = 0x31

    INPUT_REFLECTED = true

    TABLE = build_table

  end

  # @deprecated Please use {CRC8_1Wire} instead.
  CRC81Wire = CRC8_1Wire
end
