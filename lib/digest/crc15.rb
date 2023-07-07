require 'digest/crc'

module Digest
  #
  # Implements the CRC15 algorithm.
  #
  # @since 0.5.0
  #
  class CRC15 < CRC

    WIDTH = 15

    # Generated by `./pycrc.py --algorithm=table-driven --model=crc-16 --generate=c`
    TABLE = [
      0x0000, 0x4599, 0x4eab, 0x0b32, 0x58cf, 0x1d56, 0x1664, 0x53fd, 0x7407, 0x319e, 0x3aac, 0x7f35, 0x2cc8, 0x6951, 0x6263, 0x27fa,
      0x2d97, 0x680e, 0x633c, 0x26a5, 0x7558, 0x30c1, 0x3bf3, 0x7e6a, 0x5990, 0x1c09, 0x173b, 0x52a2, 0x015f, 0x44c6, 0x4ff4, 0x0a6d,
      0x5b2e, 0x1eb7, 0x1585, 0x501c, 0x03e1, 0x4678, 0x4d4a, 0x08d3, 0x2f29, 0x6ab0, 0x6182, 0x241b, 0x77e6, 0x327f, 0x394d, 0x7cd4,
      0x76b9, 0x3320, 0x3812, 0x7d8b, 0x2e76, 0x6bef, 0x60dd, 0x2544, 0x02be, 0x4727, 0x4c15, 0x098c, 0x5a71, 0x1fe8, 0x14da, 0x5143,
      0x73c5, 0x365c, 0x3d6e, 0x78f7, 0x2b0a, 0x6e93, 0x65a1, 0x2038, 0x07c2, 0x425b, 0x4969, 0x0cf0, 0x5f0d, 0x1a94, 0x11a6, 0x543f,
      0x5e52, 0x1bcb, 0x10f9, 0x5560, 0x069d, 0x4304, 0x4836, 0x0daf, 0x2a55, 0x6fcc, 0x64fe, 0x2167, 0x729a, 0x3703, 0x3c31, 0x79a8,
      0x28eb, 0x6d72, 0x6640, 0x23d9, 0x7024, 0x35bd, 0x3e8f, 0x7b16, 0x5cec, 0x1975, 0x1247, 0x57de, 0x0423, 0x41ba, 0x4a88, 0x0f11,
      0x057c, 0x40e5, 0x4bd7, 0x0e4e, 0x5db3, 0x182a, 0x1318, 0x5681, 0x717b, 0x34e2, 0x3fd0, 0x7a49, 0x29b4, 0x6c2d, 0x671f, 0x2286,
      0x2213, 0x678a, 0x6cb8, 0x2921, 0x7adc, 0x3f45, 0x3477, 0x71ee, 0x5614, 0x138d, 0x18bf, 0x5d26, 0x0edb, 0x4b42, 0x4070, 0x05e9,
      0x0f84, 0x4a1d, 0x412f, 0x04b6, 0x574b, 0x12d2, 0x19e0, 0x5c79, 0x7b83, 0x3e1a, 0x3528, 0x70b1, 0x234c, 0x66d5, 0x6de7, 0x287e,
      0x793d, 0x3ca4, 0x3796, 0x720f, 0x21f2, 0x646b, 0x6f59, 0x2ac0, 0x0d3a, 0x48a3, 0x4391, 0x0608, 0x55f5, 0x106c, 0x1b5e, 0x5ec7,
      0x54aa, 0x1133, 0x1a01, 0x5f98, 0x0c65, 0x49fc, 0x42ce, 0x0757, 0x20ad, 0x6534, 0x6e06, 0x2b9f, 0x7862, 0x3dfb, 0x36c9, 0x7350,
      0x51d6, 0x144f, 0x1f7d, 0x5ae4, 0x0919, 0x4c80, 0x47b2, 0x022b, 0x25d1, 0x6048, 0x6b7a, 0x2ee3, 0x7d1e, 0x3887, 0x33b5, 0x762c,
      0x7c41, 0x39d8, 0x32ea, 0x7773, 0x248e, 0x6117, 0x6a25, 0x2fbc, 0x0846, 0x4ddf, 0x46ed, 0x0374, 0x5089, 0x1510, 0x1e22, 0x5bbb,
      0x0af8, 0x4f61, 0x4453, 0x01ca, 0x5237, 0x17ae, 0x1c9c, 0x5905, 0x7eff, 0x3b66, 0x3054, 0x75cd, 0x2630, 0x63a9, 0x689b, 0x2d02,
      0x276f, 0x62f6, 0x69c4, 0x2c5d, 0x7fa0, 0x3a39, 0x310b, 0x7492, 0x5368, 0x16f1, 0x1dc3, 0x585a, 0x0ba7, 0x4e3e, 0x450c, 0x0095
    ].freeze

    #
    # Updates the CRC15 checksum.
    #
    # @param [String] data
    #   The data to update the checksum with.
    #
    def update(data)
      data.each_byte do |b|
        @crc = (@table[((@crc >> 7) ^ b) & 0xff] ^ (@crc << 8)) & 0x7fff
      end

      return self
    end

  end
end

if RUBY_ENGINE == 'ruby'
  begin; require 'digest/crc15/crc15_ext'; rescue LoadError; end
end
