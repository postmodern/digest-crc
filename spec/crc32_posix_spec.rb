require 'spec_helper'
require 'crc_examples'
require 'digest/crc32_posix'

describe Digest::CRC32POSIX do
  let(:string) { '1234567890123456789' }
  let(:expected) { '3b934973' }

  it_should_behave_like "CRC"
end
