require 'spec_helper'
require 'crc_examples'
require 'digest/crc32_mpeg'

describe Digest::CRC32MPEG do
  let(:string)   { '1234567890123456789' }
  let(:expected) { 'cd005928' }

  it_should_behave_like "CRC"
end

describe "Digest::CRC32Mpeg" do
  subject { Digest::CRC32Mpeg }

  it { expect(subject).to eq(Digest::CRC32MPEG) }
end
