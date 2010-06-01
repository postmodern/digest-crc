require 'digest/crc'

module Digest
  class CRC1 < CRC

    TABLE = []
    CRC_MASK = 0x00

    def self.pack(crc);   [crc].pack('c*');   end

    def update(data)
      @crc += data.unpack('c*').reduce(0){|i,s| i+s} % 256
      self
    end

  end
end
