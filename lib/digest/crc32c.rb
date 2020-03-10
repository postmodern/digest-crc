require 'digest/crc32'

module Digest
  #
  # Implements the CRC32c algorithm.
  #
  class CRC32c < CRC32

    POLYNOMIAL = 0x1edc6f41

    INPUT_REFLECTED = true

    TABLE = build_table

  end
end
