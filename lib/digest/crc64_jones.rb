require 'digest/crc64'

module Digest
  #
  # Implements the CRC64 Jones algorithm.
  #
  # @since 0.5.0
  #
  class CRC64Jones < CRC64

    POLYNOMIAL = 0xad93d23594c935a9

    INPUT_REFLECTED = true

    INIT_XOR = 0xffffffffffffffff

    INIT_CRC = 0x0 ^ INIT_XOR

    TABLE = build_table

  end
end
