require 'spec_helper'
require 'digest/crc'
require 'digest/crc32_mpeg'

describe Digest::CRC do
  describe "#block_length" do
    it { expect(subject.block_length).to be 1 }
  end

  describe ".pack" do
    subject { described_class }

    it do
      expect { subject.pack(0) }.to raise_error(NotImplementedError)
    end
  end

  describe "#update" do
    it do
      expect { subject.update('') }.to raise_error(NotImplementedError)
    end
  end

  context "when inherited" do
    subject do
      Class.new(described_class).tap do |klass|
        klass::WIDTH = 16

        klass::REFLECT_INPUT = true

        klass::INIT_CRC = 0x01

        klass::XOR_MASK = 0x02

        klass::TABLE = [0x01, 0x02, 0x03, 0x04].freeze
      end
    end

    it "should override WIDTH" do
      expect(subject::WIDTH).not_to be described_class::WIDTH
    end

    it "should override REFLECT_INPUT" do
      expect(subject::REFLECT_INPUT).not_to be described_class::REFLECT_INPUT
    end

    it "should override INIT_CRC" do
      expect(subject::INIT_CRC).not_to be described_class::INIT_CRC
    end

    it "should override XOR_MASK" do
      expect(subject::XOR_MASK).not_to be described_class::XOR_MASK
    end

    it "should override TABLE" do
      expect(subject::TABLE).not_to be described_class::TABLE
    end

    describe "#initialize" do
      let(:instance) { subject.new }

      it "should initialize @init_crc" do
        expect(instance.instance_variable_get("@init_crc")).to be subject::INIT_CRC
      end

      it "should initialize @xor_mask" do
        expect(instance.instance_variable_get("@xor_mask")).to be subject::XOR_MASK
      end

      it "should initialize @width" do
        expect(instance.instance_variable_get("@width")).to be subject::WIDTH
      end

      it "should initialize @reflect_input" do
        expect(instance.instance_variable_get("@reflect_input")).to be subject::REFLECT_INPUT
      end

      it "should initialize @table" do
        expect(instance.instance_variable_get("@table")).to be subject::TABLE
      end
    end
  end

  context "when incomplete class with WIDTH to zero" do
    subject do
      Class.new(described_class).tap do |klass|
        klass::WIDTH         = 0
        klass::REFLECT_INPUT = true
        klass::TABLE         = [1, 2, 3, 4].freeze
      end
    end

    describe "#update" do
      let(:instance) { subject.new }

      it "should WIDTH not to be zero" do
        expect { instance.update "" }.to raise_error(NotImplementedError)
      end
    end
  end

  context "when incomplete class with REFLECT_INPUT to nil" do
    subject do
      Class.new(described_class).tap do |klass|
        klass::WIDTH         = 8
        klass::REFLECT_INPUT = nil
        klass::TABLE         = [1, 2, 3, 4].freeze
      end
    end

    describe "#update" do
      let(:instance) { subject.new }

      it "should REFLECT_INPUT not to be nil" do
        expect { instance.update "" }.to raise_error(NotImplementedError)
      end
    end
  end

  context "when incomplete class with TABLE to empty" do
    subject do
      Class.new(described_class).tap do |klass|
        klass::WIDTH         = 8
        klass::REFLECT_INPUT = true
        klass::TABLE         = [].freeze
      end
    end

    describe "#update" do
      let(:instance) { subject.new }

      it "should TABLE not to be empty" do
        expect { instance.update "" }.to raise_error(NotImplementedError)
      end
    end
  end

  context "when a subclass defines its own REFLECT_INPUT and TABLE" do
    subject do
      Class.new(Digest::CRC32) do
        const_set(:REFLECT_INPUT, false)
        const_set(:XOR_MASK, 0x00000000)
        const_set(:TABLE, Digest::CRC32MPEG::TABLE)
      end
    end

    let(:data) { Array.new(1000) { |i| (i * 151 + 7) & 0xff }.pack("C*") }

    it "should calculate the checksum with its own TABLE" do
      # The C extension's #update always uses its own table.
      skip "Digest::CRC32 uses its C extension" unless Digest::CRC32.implementation == :pure

      expect(subject.hexdigest(data)).to eq(Digest::CRC32MPEG.hexdigest(data))
    end
  end

  context "when a subclass defines only its own REFLECT_INPUT" do
    subject do
      Class.new(Digest::CRC32) do
        const_set(:REFLECT_INPUT, false)
      end
    end

    let(:data) { Array.new(1000) { |i| (i * 151 + 7) & 0xff }.pack("C*") }

    it "should calculate the same checksum for long data as one byte at a time" do
      # The C extension's #update ignores REFLECT_INPUT.
      skip "Digest::CRC32 uses its C extension" unless Digest::CRC32.implementation == :pure

      crc = subject.new
      data.each_byte { |b| crc << b.chr }

      expect(subject.hexdigest(data)).to eq(crc.hexdigest)
    end
  end
end
