require 'digest'

module Digest
  class CRC < Digest::Class

    include Digest::Instance

    INIT_CRC = 0x00

    XOR_MASK = 0x00

    WIDTH = 0

    def self.checksum(data)
      crc = self.new
      crc << data

      return crc.checksum
    end

    def initialize
      @crc = self.class.const_get(:INIT_CRC)
    end

    def block_length
      1
    end

    def digest_length
      (self.class.const_get(:WIDTH) / 8.0).ceil
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
      @crc ^ self.class.const_get(:XOR_MASK)
    end

    def self.pack(crc)
      ''
    end

    def finish
      self.class.pack(checksum)
    end

  end
end
