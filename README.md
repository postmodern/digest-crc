# Digest CRC

* [Source](http://github.com/postmodern/digest-crc)
* [Issues](http://github.com/postmodern/digest-crc/issues)
* [Documentation](http://rubydoc.info/gems/digest-crc/frames)
* [Email](mailto:postmodern.mod3 at gmail.com)

## Description

Adds support for calculating Cyclic Redundancy Check (CRC) to the Digest
module.

## Features

* Provides support for the following CRC algorithms:
  * CRC1
  * CRC5
  * CRC8
  * CRC16
  * CRC16 CCITT
  * CRC16 DNP
  * CRC16 Modbus
  * CRC16 USB
  * CRC16 XModem
  * CRC16 ZModem
  * CRC24
  * CRC32
  * CRC32c
  * CRC32 Mpeg
  * CRC64
* Pure Ruby implementation.
* Provides CRC Tables for optimized calculations.

## Install

    $ gem install digest-crc

## Examples

Calculate a CRC32:

    require 'digest/crc32'

    Digest::CRC32.hexdigest('hello')
    # => "3610a686"

Calculate a CRC32 of a file:

    Digest::CRC32.file('README.md')
    # => #<Digest::CRC32: 127ad531>

Incrementally calculate a CRC32:

    crc = Digest::CRC32.new
    crc << 'one'
    crc << 'two'
    crc << 'three'
    crc.hexdigest
    # => "09e1c092"

Directly access the checksum:

    crc.checksum
    # => 165789842

## Thanks

Special thanks go out to the [pycrc](http://www.tty1.net/pycrc/) library
which is able to generate C source-code for all of the CRC algorithms,
including their CRC Tables.

## License

Copyright (c) 2010-2011 Hal Brodigan

See {file:LICENSE.txt} for license information.
