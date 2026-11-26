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

    # Define true or false whether the input direction is bit reversed or not of the CRC checksum
    REFLECT_INPUT = nil

    # Default place holder CRC table
    TABLE = [].freeze

    # The slicing-by-8 table and the constants it was built from (see .slicing_table)
    SLICING_TABLE = nil

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
    def self.pack(crc)
      unless (width = self::WIDTH) > 0
        raise(NotImplementedError, "#{self} is incompleted as CRC")
      end

      bitclass   = width + (-width & 0x07)
      byte_count = bitclass / 8

      # Not ~(-1 << width): shifting a negative Integer that far allocates a
      # temporary Bignum.
      crc &= (1 << width) - 1

      result = [crc].pack("Q>")
      result[0, result.bytesize - byte_count] = ""
      result
    end

    #
    # Determines whether the library is using the optimized C extensions
    # implementation, or the pure-Ruby implementation.
    #
    # @return [:c_ext, :pure]
    #
    # @since 0.7.0
    #
    def self.implementation
      if instance_method(:update).source_location.nil?
        :c_ext
      else
        :pure
      end
    end

    #
    # Builds the lookup table that lets #update process 8 bytes in each
    # loop iteration. Only CRCs of 16, 24 or 32 bits can use it.
    #
    # @return [Array(Array<Integer>, Integer, Boolean, Array<Integer>)]
    #   The TABLE, WIDTH and REFLECT_INPUT that the slicing table is built
    #   from, and the slicing table. Entry `256 * k + b` of the slicing table
    #   is the CRC register after byte `b` followed by `k` zero bytes. For a
    #   non-reflected CRC, the register is padded to 32 bits.
    #
    # @api private
    #
    def self.slicing_table
      width   = self::WIDTH
      reflect = self::REFLECT_INPUT
      table   = self::TABLE

      unless [16, 24, 32].include?(width)
        raise(ArgumentError, "#{self} has a WIDTH of #{width}, not 16, 24 or 32")
      end

      mask   = (1 << width) - 1
      tables = [table]

      7.times do
        tables << tables.last.map { |crc|
          if reflect
            (crc >> 8) ^ table[crc & 0xff]
          else
            ((crc << 8) & mask) ^ table[crc >> (width - 8)]
          end
        }
      end

      # The padding puts the bytes of a non-reflected register at the same
      # bit positions for all widths, so #update_sliced needs no WIDTH.
      padding = reflect ? 0 : 32 - width

      [table, width, reflect, tables.flatten.map { |crc| crc << padding }.freeze].freeze
    end
    private_class_method :slicing_table

    #
    # Initializes the CRC checksum.
    #
    def initialize
      @init_crc      = self.class.const_get(:INIT_CRC)
      @xor_mask      = self.class.const_get(:XOR_MASK)
      @width         = self.class.const_get(:WIDTH)
      @reflect_input = self.class.const_get(:REFLECT_INPUT)
      @table         = self.class.const_get(:TABLE)

      # A subclass that changes TABLE, WIDTH or REFLECT_INPUT cannot use the
      # slicing table of its parent.
      table, width, reflect, @slicing_table = self.class.const_get(:SLICING_TABLE)

      unless table.equal?(@table) && width == @width && reflect == @reflect_input
        @slicing_table = nil
      end

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
    # @raise [NotImplementedError]
    #   If WIDTH, TABLE, or REFLECT_INPUT constants are not set properly.
    #
    def update(data)
      unless @width >= 1
        raise(NotImplementedError, "incompleted #{self.class} as CRC (expected WIDTH to be 1 or more)")
      end

      if @table.empty?
        raise(NotImplementedError, "incompleted #{self.class} as CRC (expected TABLE to be not empty)")
      end

      if @reflect_input.nil?
        raise(NotImplementedError, "incompleted #{self.class} as CRC (expected REFLECT_INPUT to be not nil)")
      end

      table = @table
      crc   = @crc
      i     = 0
      n     = data.bytesize

      # Process the whole 8-byte blocks with the slicing table, if any.
      if @slicing_table
        i   = n - (n % 8)
        crc = if @reflect_input
                update_sliced_reflected(data, crc, i)
              else
                update_sliced(data, crc, i)
              end
      end

      if @reflect_input
        if @width > 8
          while i < n
            crc = table[data.getbyte(i) ^ (0xff & crc)] ^ (crc >> 8)
            i += 1
          end
        else
          while i < n
            # Omit (crc >> 8) since bits upper than the lower 8 bits are always 0
            crc = table[data.getbyte(i) ^ (0xff & crc)]
            i += 1
          end
        end
      else
        if @width > 8
          higher_bit_off = @width - 8
          remain_mask    = (1 << higher_bit_off) - 1

          while i < n
            crc = table[data.getbyte(i) ^ (0xff & (crc >> higher_bit_off))] ^ ((remain_mask & crc) << 8)
            i += 1
          end
        else
          padding = 8 - @width

          while i < n
            # Omit (crc << 8) since bits lower than the upper 8 bits are always 0
            crc = table[data.getbyte(i) ^ (0xff & (crc << padding))]
            i += 1
          end
        end
      end

      @crc = crc

      self
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

    private

    #
    # Updates a reflected CRC register with the first `stop` bytes of the
    # data, 8 bytes at a time.
    #
    # The register has at most 4 bytes, so only the first 4 bytes of each
    # block mix with it.
    #
    def update_sliced_reflected(data, crc, stop)
      t = @slicing_table
      i = 0

      while i < stop
        crc = t[0x700 | ((crc ^ data.getbyte(i)) & 0xff)] ^
              t[0x600 | (((crc >> 8) ^ data.getbyte(i + 1)) & 0xff)] ^
              t[0x500 | (((crc >> 16) ^ data.getbyte(i + 2)) & 0xff)] ^
              t[0x400 | (((crc >> 24) ^ data.getbyte(i + 3)) & 0xff)] ^
              t[0x300 | data.getbyte(i + 4)] ^ t[0x200 | data.getbyte(i + 5)] ^
              t[0x100 | data.getbyte(i + 6)] ^ t[data.getbyte(i + 7)]
        i += 8
      end

      crc
    end

    #
    # Updates a non-reflected CRC register with the first `stop` bytes of
    # the data, 8 bytes at a time.
    #
    # The register is padded to 4 bytes, like the slicing table entries, so
    # that its bytes line up with the first 4 bytes of each block.
    #
    def update_sliced(data, crc, stop)
      t       = @slicing_table
      padding = 32 - @width
      reg     = crc << padding
      i       = 0

      while i < stop
        reg = t[0x700 | (((reg >> 24) ^ data.getbyte(i)) & 0xff)] ^
              t[0x600 | (((reg >> 16) ^ data.getbyte(i + 1)) & 0xff)] ^
              t[0x500 | (((reg >> 8) ^ data.getbyte(i + 2)) & 0xff)] ^
              t[0x400 | ((reg ^ data.getbyte(i + 3)) & 0xff)] ^
              t[0x300 | data.getbyte(i + 4)] ^ t[0x200 | data.getbyte(i + 5)] ^
              t[0x100 | data.getbyte(i + 6)] ^ t[data.getbyte(i + 7)]
        i += 8
      end

      reg >> padding
    end

  end
end
