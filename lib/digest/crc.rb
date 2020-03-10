require 'digest'

module Digest
  #
  # Base class for all CRC algorithms.
  #
  class CRC < Digest::Class

    include Digest::Instance

    # The initial value of the CRC checksum
    INIT_CRC = 0x00

    # The XOR mask to apply to the resulting CRC checksum
    XOR_MASK = 0x00

    # The bit width of the CRC checksum
    WIDTH = 0

    # The polynomial code of the CRC checksum (required if use build_table)
    POLYNOMIAL = nil

    # Default place holder CRC table
    TABLE = [].freeze

    # Is the input code bit-reflected? (required if use build_table)
    INPUT_REFLECTED = nil

    #
    # Build a CRC table.
    #
    # @param [Integer] width
    #   The CRC bit width.
    #
    # @param [Integer] polynomial
    #   The CRC polynomial code.
    #
    # @param [true,false] reflected
    #   The CRC bit width.
    #
    # @param [Integer] slice
    #   The CRC multiplier slices.
    #   Give 1 if you want to the "standard table" algorithm.
    #   Give 8 if you want to the "slicing by 8" algorithm.
    #
    # @param [Integer] slide
    #   The number of slide bit per table.
    #   Give 8 if you want to the "standard table" algorithm.
    #   Give 4 if you want to the "half-byte table" algorithm.
    #
    # @param [true,false] padding
    #   For forward input CRC of less than 8 bits, insert 0 into
    #   the lower bit of each element to align in 8-bit units.
    #   Processing at the time of calculation can be simplified.
    #
    # @param [true,false] freeze
    #   Freeze the CRC lookup table if this is true.
    #
    # @return [Array]
    #   The CRC lookup table.
    #
    #   If slice is less than 2, it will be an array of `[Integer, ..]`.
    #   If slice is 2 or more, it will be an array of `[[Integer, ...], ...]`.
    #
    def self.build_table(width = self::WIDTH, polynomial = self::POLYNOMIAL,
                         reflect = self::INPUT_REFLECTED,
                         slice: 1, slide: 8, padding: true, freeze: true)
      elems = 1 << slide

      if reflect
        polynomial = bitreflect(polynomial, width: width)
        table = elems.times.map { |g|
          slide.times {
            carry = g[0]
            g >>= 1
            g ^= polynomial unless carry == 0
          }
          g
        }

        if slice > 1
          table0 = table
          table0.freeze if freeze
          table = [table0]
          carrymask = ~(-1 << slide)
          (1...slice).each do
            tprev = table[-1]
            table << elems.times.map { |i|
              g = tprev[i]
              (g >> slide) ^ table0[g & carrymask]
            }
            table[-1].freeze if freeze
          end
        end
      else
        raise NotImplementedError, "need 8 for slide" unless slide == 8

        if width < 8
          topbit = 7
          shift = 0
          padding = padding ? 0 : 8 - width
        else
          topbit = width - 1
          shift = width - 8
          padding = 0
        end

        polynomial = polynomial << padding
        carrymask = ~(-1 << topbit)

        table = elems.times.map { |g|
          g <<= shift
          slide.times {
            carry = g[topbit]
            g = (g & carrymask) << 1
            g ^= polynomial unless carry == 0
          }
          g >> padding
        }

        if slice > 1
          table0 = table
          table0.freeze if freeze
          table = [table0]
          carrymask = ~(-1 << shift)
          (1...slice).each do
            tprev = table[-1]
            table << elems.times.map { |i|
              g = tprev[i] << padding
              g = ((g & carrymask) << 8) ^ table0[(g >> shift) & 0xff]
              g >> padding
            }
            table[-1].freeze if freeze
          end
        end
      end

      table.freeze if freeze
      table
    end

    def self.bitreflect(num, width: self::WIDTH)
      renum = 0
      width.times {
        renum = (renum << 1) | num[0]
        num >>= 1
      }
      renum
    end

    #
    # Calculates the CRC checksum.
    #
    # @param [String] data
    #   The given data.
    #
    # @return [Integer]
    #   The CRC checksum.
    #
    def self.checksum(data)
      crc = self.new
      crc << data

      return crc.checksum
    end

    #
    # Packs the given CRC checksum.
    #
    # @param [Integer] crc
    #   The raw CRC checksum.
    #
    # @return [String]
    #   The packed CRC checksum.
    #
    # @abstract
    #
    def self.pack(crc)
      raise(NotImplementedError,"#{self.class}##{__method__} not implemented")
    end

    #
    # Initializes the CRC checksum.
    #
    def initialize
      @init_crc = self.class.const_get(:INIT_CRC)
      @xor_mask = self.class.const_get(:XOR_MASK)
      @width    = self.class.const_get(:WIDTH)
      @table    = self.class.const_get(:TABLE)

      reset
    end

    #
    # The input block length.
    #
    # @return [1]
    #
    def block_length
      1
    end

    #
    # The length of the digest.
    #
    # @return [Integer]
    #   The length in bytes.
    #
    def digest_length
      (@width / 8.0).ceil
    end

    #
    # Updates the CRC checksum with the given data.
    #
    # @param [String] data
    #   The data to update the CRC checksum with.
    #
    # @abstract
    #
    def update(data)
      raise(NotImplementedError,"#{self.class}##{__method__} not implemented")
    end

    #
    # @see #update
    #
    def <<(data)
      update(data)
      return self
    end

    #
    # Resets the CRC checksum.
    #
    # @return [Integer]
    #   The default value of the CRC checksum.
    #
    def reset
      @crc = @init_crc
    end

    #
    # The resulting CRC checksum.
    #
    # @return [Integer]
    #   The resulting CRC checksum.
    #
    def checksum
      @crc ^ @xor_mask
    end

    #
    # Finishes the CRC checksum calculation.
    #
    # @see pack
    #
    def finish
      self.class.pack(checksum)
    end

  end
end
