require 'digest/crc16'

module Digest
  #
  # Implements the CRC16 Modbus algorithm.
  #
  class CRC16Modbus < CRC16

    POLYNOMIAL = 0x8005

    INPUT_REFLECTED = true

    INIT_CRC = 0xffff

    TABLE = build_table

  end
end
