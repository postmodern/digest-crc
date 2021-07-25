# Digest CRC

[![CI](https://github.com/postmodern/digest-crc/actions/workflows/ruby.yml/badge.svg)](https://github.com/postmodern/digest-crc/actions/workflows/ruby.yml)

* [Source](https://github.com/postmodern/digest-crc)
* [Issues](https://github.com/postmodern/digest-crc/issues)
* [Documentation](http://rubydoc.info/gems/digest-crc/frames)
* [Email](mailto:postmodern.mod3 at gmail.com)

## Description

Adds support for calculating Cyclic Redundancy Check (CRC) to the Digest
module.

## Features

* Provides support for the following CRC algorithms:
  * [CRC1](https://rubydoc.info/gems/digest-crc/Digest/CRC1)
  * [CRC5](https://rubydoc.info/gems/digest-crc/Digest/CRC5)
  * [CRC8](https://rubydoc.info/gems/digest-crc/Digest/CRC8)
  * [CRC8 1-Wire](https://rubydoc.info/gems/digest-crc/Digest/CRC8_1Wire)
  * [CRC15](https://rubydoc.info/gems/digest-crc/Digest/CRC15)
  * [CRC16](https://rubydoc.info/gems/digest-crc/Digest/CRC16)
  * [CRC16 CCITT](https://rubydoc.info/gems/digest-crc/Digest/CRC16CCITT)
  * [CRC16 DNP](https://rubydoc.info/gems/digest-crc/Digest/CRC16DNP)
  * [CRC16 Genibus](https://rubydoc.info/gems/digest-crc/Digest/CRC16Genibus)
  * [CRC16 Kermit](https://rubydoc.info/gems/digest-crc/Digest/CRC16Kermit)
  * [CRC16 Modbus](https://rubydoc.info/gems/digest-crc/Digest/CRC16Modbus)
  * [CRC16 USB](https://rubydoc.info/gems/digest-crc/Digest/CRC16USB)
  * [CRC16 X25](https://rubydoc.info/gems/digest-crc/Digest/CRC16X25)
  * [CRC16 XModem](https://rubydoc.info/gems/digest-crc/Digest/CRC16XModem)
  * [CRC16 ZModem](https://rubydoc.info/gems/digest-crc/Digest/CRC16ZModem)
  * [CRC16 QT](https://rubydoc.info/gems/digest-crc/Digest/CRC16QT)
  * [CRC24](https://rubydoc.info/gems/digest-crc/Digest/CRC24)
  * [CRC32](https://rubydoc.info/gems/digest-crc/Digest/CRC32)
  * [CRC32 BZip2](https://rubydoc.info/gems/digest-crc/Digest/CRC32BZip2)
  * [CRC32c](https://rubydoc.info/gems/digest-crc/Digest/CRC32c)
  * [CRC32 Jam](https://rubydoc.info/gems/digest-crc/Digest/CRC32Jam)
  * [CRC32 MPEG](https://rubydoc.info/gems/digest-crc/Digest/CRC32MPEG)
  * [CRC32 POSIX](https://rubydoc.info/gems/digest-crc/Digest/CRC32POSIX)
  * [CRC32 XFER](https://rubydoc.info/gems/digest-crc/Digest/CRC32XFER)
  * [CRC64](https://rubydoc.info/gems/digest-crc/Digest/CRC64)
  * [CRC64 Jones](https://rubydoc.info/gems/digest-crc/Digest/CRC64Jones)
  * [CRC64 XZ](https://rubydoc.info/gems/digest-crc/Digest/CRC64XZ)
* Pure Ruby implementation.
* Provides CRC Tables for optimized calculations.
* Supports _optional_ C extensions which increases performance by ~40x.
  * If the C extensions cannot be compiled for whatever reason, digest-crc
    will automatically fallback to the pure-Ruby implementation.

## Install

```
gem install digest-crc
```

**Note:** to enable the C extensions ensure that you are using CRuby and have
a C compiler (`gcc` or `clang`) and `make` installed, _before_ installing
digest-crc.

* Debian / Ubuntu:

      $ sudo apt install gcc make

* RedHat / Fedora:

      $ sudo dnf install gcc make

* Alpine Linux:

      $ apk add build-base

* macOS: install XCode

## Examples

Calculate a CRC32:

```ruby
require 'digest/crc32'

Digest::CRC32.hexdigest('hello')
# => "3610a686"
```

Calculate a CRC32 of a file:

```ruby
Digest::CRC32.file('README.md')
# => #<Digest::CRC32: 127ad531>
```

Incrementally calculate a CRC32:

```ruby
crc = Digest::CRC32.new
crc << 'one'
crc << 'two'
crc << 'three'
crc.hexdigest
# => "09e1c092"
```

Directly access the checksum:

```ruby
crc.checksum
# => 165789842
```

Defining your own CRC class:

```ruby
require 'digest/crc32'

module Digest
  class CRC3000 < CRC32

    WIDTH = 4

    INIT_CRC = 0xffffffff

    XOR_MASK = 0xffffffff

    TABLE = [
      # ....
    ].freeze

    def update(data)
      data.each_byte do |b|
        @crc = (((@crc >> 8) & 0x00ffffff) ^ @table[(@crc ^ b) & 0xff])
      end

      return self
    end
  end
end
```

## Benchmarks

### Pure Ruby (ruby 2.7.4)

    $ bundle exec rake clean
    $ bundle exec ./benchmarks.rb
    Loading Digest::CRC classes ...
    Generating 1000 8Kb lengthed strings ...
    Benchmarking Digest::CRC classes ...
                                      user     system      total        real
    Digest::CRC1#update           0.423741   0.000000   0.423741 (  0.425887)
    Digest::CRC5#update           1.486578   0.000011   1.486589 (  1.493215)
    Digest::CRC8#update           1.261386   0.000000   1.261386 (  1.266399)
    Digest::CRC8_1Wire#update     1.250344   0.000000   1.250344 (  1.255009)
    Digest::CRC15#update          1.482515   0.000000   1.482515 (  1.488131)
    Digest::CRC16#update          1.216744   0.000811   1.217555 (  1.222228)
    Digest::CRC16CCITT#update     1.480490   0.000000   1.480490 (  1.486745)
    Digest::CRC16DNP#update       1.200067   0.000000   1.200067 (  1.204835)
    Digest::CRC16Genibus#update   1.492910   0.000000   1.492910 (  1.498923)
    Digest::CRC16Modbus#update    1.217449   0.000003   1.217452 (  1.222348)
    Digest::CRC16QT#update        1.223311   0.000000   1.223311 (  1.229211)
    Digest::CRC16USB#update       1.233744   0.000000   1.233744 (  1.238615)
    Digest::CRC16X25#update       1.223077   0.000000   1.223077 (  1.227607)
    Digest::CRC16XModem#update    1.487674   0.000000   1.487674 (  1.493316)
    Digest::CRC16ZModem#update    1.484288   0.000000   1.484288 (  1.490096)
    Digest::CRC24#update          1.490272   0.000000   1.490272 (  1.496027)
    Digest::CRC32#update          1.225311   0.000000   1.225311 (  1.230572)
    Digest::CRC32BZip2#update     1.503096   0.000000   1.503096 (  1.509202)
    Digest::CRC32c#update         1.220390   0.000000   1.220390 (  1.225487)
    Digest::CRC32Jam#update       1.216066   0.000000   1.216066 (  1.220591)
    Digest::CRC32MPEG#update      1.486808   0.000000   1.486808 (  1.492611)
    Digest::CRC32POSIX#update     1.494508   0.000957   1.495465 (  1.503262)
    Digest::CRC32XFER#update      1.504802   0.005830   1.510632 (  1.522066)
    Digest::CRC64#update          3.260784   0.015674   3.276458 (  3.310506)
    Digest::CRC64Jones#update     3.195204   0.000000   3.195204 (  3.213054)
    Digest::CRC64XZ#update        3.173597   0.000000   3.173597 (  3.190438)

### C extensions (ruby 2.7.4)

    $ bundle exec rake build:c_exts
    ...
    $ bundle exec ./benchmarks.rb
    Loading Digest::CRC classes ...
    Generating 1000 8Kb lengthed strings ...
    Benchmarking Digest::CRC classes ...
                                      user     system      total        real
    Digest::CRC1#update           0.443619   0.000007   0.443626 (  0.446545)
    Digest::CRC5#update           0.025134   0.000806   0.025940 (  0.026129)
    Digest::CRC8#update           0.022564   0.000000   0.022564 (  0.022775)
    Digest::CRC8_1Wire#update     0.021427   0.000008   0.021435 (  0.021551)
    Digest::CRC15#update          0.030377   0.000833   0.031210 (  0.031406)
    Digest::CRC16#update          0.024004   0.000002   0.024006 (  0.024418)
    Digest::CRC16CCITT#update     0.026930   0.000001   0.026931 (  0.027238)
    Digest::CRC16DNP#update       0.024279   0.000000   0.024279 (  0.024446)
    Digest::CRC16Genibus#update   0.026477   0.000004   0.026481 (  0.026656)
    Digest::CRC16Modbus#update    0.023568   0.000000   0.023568 (  0.023704)
    Digest::CRC16QT#update        0.024161   0.000000   0.024161 (  0.024316)
    Digest::CRC16USB#update       0.023891   0.000000   0.023891 (  0.024038)
    Digest::CRC16X25#update       0.023849   0.000000   0.023849 (  0.023991)
    Digest::CRC16XModem#update    0.026254   0.000000   0.026254 (  0.026523)
    Digest::CRC16ZModem#update    0.026391   0.000000   0.026391 (  0.026529)
    Digest::CRC24#update          0.028805   0.000854   0.029659 (  0.029830)
    Digest::CRC32#update          0.024030   0.000000   0.024030 (  0.024200)
    Digest::CRC32BZip2#update     0.026942   0.000000   0.026942 (  0.027244)
    Digest::CRC32c#update         0.023989   0.000000   0.023989 (  0.024159)
    Digest::CRC32Jam#update       0.023940   0.000000   0.023940 (  0.024066)
    Digest::CRC32MPEG#update      0.027063   0.000000   0.027063 (  0.027213)
    Digest::CRC32POSIX#update     0.027137   0.000000   0.027137 (  0.028160)
    Digest::CRC32XFER#update      0.026956   0.000002   0.026958 (  0.027103)
    Digest::CRC64#update          0.024222   0.000005   0.024227 (  0.024796)
    Digest::CRC64Jones#update     0.025331   0.000000   0.025331 (  0.025789)
    Digest::CRC64XZ#update        0.024131   0.000001   0.024132 (  0.024348)

### Pure Ruby (jruby 9.2.18.0)

    $ bundle exec ./benchmarks.rb
    Loading Digest::CRC classes ...
    Generating 1000 8Kb lengthed strings ...
    Benchmarking Digest::CRC classes ...
                                      user     system      total        real
    Digest::CRC1#update           1.080000   0.050000   1.130000 (  0.676022)
    Digest::CRC5#update           2.030000   0.040000   2.070000 (  1.089240)
    Digest::CRC8#update           1.590000   0.000000   1.590000 (  0.999138)
    Digest::CRC8_1Wire#update     0.920000   0.010000   0.930000 (  0.873813)
    Digest::CRC15#update          1.470000   0.030000   1.500000 (  1.118886)
    Digest::CRC16#update          1.780000   0.010000   1.790000 (  1.067874)
    Digest::CRC16CCITT#update     1.500000   0.070000   1.570000 (  1.185564)
    Digest::CRC16DNP#update       1.250000   0.000000   1.250000 (  0.972322)
    Digest::CRC16Genibus#update   1.700000   0.010000   1.710000 (  1.092047)
    Digest::CRC16Modbus#update    1.000000   0.010000   1.010000 (  0.915328)
    Digest::CRC16QT#update        1.250000   0.000000   1.250000 (  0.968528)
    Digest::CRC16USB#update       1.150000   0.010000   1.160000 (  0.990387)
    Digest::CRC16X25#update       0.940000   0.000000   0.940000 (  0.926926)
    Digest::CRC16XModem#update    1.390000   0.010000   1.400000 (  1.100584)
    Digest::CRC16ZModem#update    1.760000   0.020000   1.780000 (  1.094003)
    Digest::CRC24#update          1.690000   0.010000   1.700000 (  1.106875)
    Digest::CRC32#update          1.410000   0.020000   1.430000 (  1.082506)
    Digest::CRC32BZip2#update     1.510000   0.010000   1.520000 (  1.104225)
    Digest::CRC32c#update         1.270000   0.010000   1.280000 (  1.023881)
    Digest::CRC32Jam#update       1.190000   0.010000   1.200000 (  0.998146)
    Digest::CRC32MPEG#update      1.580000   0.010000   1.590000 (  1.099086)
    Digest::CRC32POSIX#update     1.550000   0.010000   1.560000 (  1.142051)
    Digest::CRC32XFER#update      1.360000   0.000000   1.360000 (  1.071381)
    Digest::CRC64#update          3.730000   0.020000   3.750000 (  2.780390)
    Digest::CRC64Jones#update     2.710000   0.020000   2.730000 (  2.608007)
    Digest::CRC64XZ#update        2.910000   0.020000   2.930000 (  2.629401)

## Crystal

[digest-crc.cr] is a [Crystal][crystal-lang] port of this library.

[digest-crc.cr]: https://github.com/postmodern/digest-crc.cr
[crystal-lang]: https://www.crystal-lang.org/

## Thanks

Special thanks go out to the [pycrc](http://www.tty1.net/pycrc/) library
which is able to generate C source-code for all of the CRC algorithms,
including their CRC Tables.

## License

Copyright (c) 2010-2021 Hal Brodigan

See {file:LICENSE.txt} for license information.
