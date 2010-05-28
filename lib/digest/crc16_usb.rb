require 'digest/crc16'

module Digest
  class CRC16USB < CRC16

    INIT_CRC = 0xffff

    XOR_CRC = 0xffff

  end
end
