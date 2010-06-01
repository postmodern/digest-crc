require 'digest/crc'

module Digest
  class CRC1 < CRC

    TABLE = []
    CRC_MASK = 0x00

    def self.pack(crc)
      [crc].pack('c*')
    end

    def update(data)
      accum = 0
      data.each_byte { |b| accum += b }

      @crc += (accum % 256)

      return self
    end

  end
end
