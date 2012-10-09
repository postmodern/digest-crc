require 'digest/crc16_ccitt'

module Digest
  #
  # Implements the CRC16_CCITT algorithm used in QT algorithms.
  #
  # @author Matthew Bednarski
  #
  class CRC16QT < CRC16CCITT
    FINAL_XOR = 0xffff
    REVERSE_CRC_RESULT = true
    REVERSE_DATA = true

    #
    # Packs the CRC16 checksum.
    #
    # @param [Integer] crc
    #   The CRC16 checksum to pack.
    #
    # @return [String]
    #   The packed CRC16 checksum.
    #
    def self.pack(crc)
      crc ^= FINAL_XOR if FINAL_XOR
      crc = revert_bits crc if REVERSE_CRC_RESULT

      buffer = ''

      buffer << ((crc & 0xff00) >> 8).chr
      buffer << (crc & 0xff).chr

      buffer
    end

    #
    # Updates the CRC16 checksum.
    #
    # @param [String] data
    #   The data to update the checksum with.
    #
    def update(data)
      data.each_byte do |b|
        b = revert_byte b if REVERSE_DATA
        @crc = ((TABLE[((@crc >> 8) ^ b) & 0xff] ^ (@crc << 8)) & 0xffff)
      end

      return self
    end

    private
    def self.revert_bits(cc)
      ob = 0
      b = (1 << 15)
      16.times do |t|
        ob |= (1 << t) if (cc & b) != 0
        b >>= 1
      end
      ob
    end

    def revert_byte(cc)
      ob = 0
      b = (1 << 7)
      8.times do |t|
        ob |= (1 << t) if (cc & b) != 0
        b >>= 1
      end
      ob
    end
  end
end

