require 'digest/crc16'

module Digest
  #
  # Implements the CRC16 X25 algorithm.
  #
  class CRC16X25 < CRC16

    POLYNOMIAL = 0x1021

    INPUT_REFLECTED = true

    INIT_XOR = 0xffff

    INIT_CRC = 0x0 ^ INIT_XOR

    XOR_MASK = 0xffff

    TABLE = build_table

  end
end
