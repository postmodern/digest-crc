require 'spec_helper'
require 'crc_examples'
require 'digest/crc32_bzip2'

describe Digest::CRC32BZip2 do
  let(:string) { '1234567890123456789' }
  let(:expected) { '32ffa6d7' }

  it_should_behave_like "CRC"
end
