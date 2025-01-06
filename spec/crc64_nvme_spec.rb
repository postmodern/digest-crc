require 'spec_helper'
require 'crc_examples'
require 'digest/crc64_nvme'

describe Digest::CRC64NVMe do
  let(:string)   { '1234567890' }
  let(:expected) { '6025a582347b79f3' }

  it_should_behave_like "CRC"
end
