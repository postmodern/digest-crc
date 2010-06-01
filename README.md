# Digest CRC

* [github.com/postmodern/digest-crc](http://github.com/postmodern/digest-crc)
* [github.com/postmodern/digest-crc/issues](http://github.com/postmodern/digest-crc/issues)
* Postmodern (postmodern.mod3 at gmail.com)

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
  * CRC32 Mpeg
  * CRC64
* Pure Ruby implementation.
* Provides CRC Tables for optimized calculations.

## Install

    $ sudo gem install digest-crc

## Thanks

Special thanks go out to the [pycrc](http://www.tty1.net/pycrc/) library
which is able to generate C source-code for all of the CRC algorithms,
including their CRC Tables.

## License

See {file:LICENSE.txt} for license information.

