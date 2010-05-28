require 'digest'

module Digest
  class CRC

    include Digest::Instance

    INIT_CRC = 0xffffffff

    XOR_CRC = 0x000000

    CRC_LENGTH = 4

    def initialize
      @crc = self.class.const_get(:INIT_CRC)
    end

    def block_length
      1
    end

    def digest_length
      self.class.const_get(:CRC_LENGTH)
    end

    def update(data)
    end

    def <<(data)
      update(data)
      return self
    end

    def reset
      @crc = self.class.const_get(:INIT_CRC)
    end

    def checksum
      @crc
    end

    def self.pack(crc)
      ''
    end

    def finish
      self.class.pack(@crc ^ self.class.const_get(:XOR_CRC))
    end

  end
end
