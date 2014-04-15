# Digest CRC

* [Source](https://github.com/postmodern/digest-crc)
* [Issues](https://github.com/postmodern/digest-crc/issues)
* [Documentation](http://rubydoc.info/gems/digest-crc/frames)
* [Email](mailto:postmodern.mod3 at gmail.com)

## Description

Adds support for calculating Cyclic Redundancy Check (CRC) to the Digest
module.

## Features

* Provides support for the following CRC algorithms:
  * {Digest::CRC1 CRC1}
  * {Digest::CRC5 CRC5}
  * {Digest::CRC8 CRC8}
  * {Digest::CRC81Wire CRC8 1-Wire}
  * {Digest::CRC16 CRC16}
  * {Digest::CRC16CCITT CRC16 CCITT}
  * {Digest::CRC16DNP CRC16 DNP}
  * {Digest::CRC16Modbus CRC16 Modbus}
  * {Digest::CRC16USB CRC16 USB}
  * {Digest::CRC16XModem CRC16 XModem}
  * {Digest::CRC16ZModem CRC16 ZModem}
  * {Digest::CRC16QT CRC16 QT}
  * {Digest::CRC24 CRC24}
  * {Digest::CRC32 CRC32}
  * {Digest::CRC32c CRC32c}
  * {Digest::CRC32Mpeg CRC32 Mpeg}
  * {Digest::CRC64 CRC64}
* Pure Ruby implementation.
* Provides CRC Tables for optimized calculations.

## Install

```
gem install digest-crc
```

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

Need another crc-table?
Just specify your class inherited from the standard one, and redefine `TABLE`:

```ruby
class MyAwesomeCRC16CCITT < Digest::CRC16CCITT
  # Values, generated specifically for you tasks,
  # or given from some other library.
  TABLE = [
      0x0000, 0x8005, 0x800f, 0x000a, 0x801b, 0x001e, 0x0014, 0x8011,
      0x8033, 0x0036, 0x003c, 0x8039, 0x0028, 0x802d, 0x8027, 0x0022,
      # etc...
  ].freeze
end

Digest::CRC16CCITT.hexdigest('hello')
# => "d26e"

MyAwesomeCRC16CCITT.hexdigest('hello')
# => "1cc5"
```

## Thanks

Special thanks go out to the [pycrc](http://www.tty1.net/pycrc/) library
which is able to generate C source-code for all of the CRC algorithms,
including their CRC Tables.

## License

Copyright (c) 2010-2013 Hal Brodigan

See [LICENSE.txt](LICENSE.txt) for license information.
