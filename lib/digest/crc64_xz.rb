require 'digest/crc64'

module Digest
  #
  # Implements the CRC64 XZ algorithm.
  #
  # @since 0.5.0
  #
  class CRC64XZ < CRC64

    POLYNOMIAL = 0x42f0e1eba9ea3693

    INPUT_REFLECTED = true

    INIT_XOR = 0xffffffffffffffff

    INIT_CRC = 0x0 ^ INIT_XOR

    XOR_MASK = 0xffffffffffffffff

    TABLE = build_table

  end
end
