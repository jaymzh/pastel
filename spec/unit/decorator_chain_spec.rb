# frozen_string_literal: true

RSpec.describe Pastel::DecoratorChain do
  it "is enumerable" do
    expect(described_class.new).to be_a(Enumerable)
  end

  describe ".empty" do
    it "memoizes an empty chain" do
      expect(described_class.empty.object_id).to eq(described_class.empty.object_id)
    end
  end

  describe "#each" do
    it "yields each decorator" do
      first   = double("first")
      second  = double("second")
      chain   = described_class.new.add(first).add(second)
      yielded = []

      expect {
        chain.each { |decorator| yielded << decorator }
      }.to change { yielded }.from([]).to([first, second])
    end
  end

  describe "#==" do
    it "is equivalent with the same decorator" do
      expect(described_class.new.add(:foo).add(:bar)).
        to eq(described_class.new.add(:foo).add(:bar))
    end

    it "is not equivalent with different decorator" do
      expect(described_class.new.add(:foo).add(:bar)).
        not_to eq(described_class.new.add(:foo).add(:baz))
    end

    it "is not equivalent to another type" do
      expect(described_class.new.add(:foo).add(:bar)).
        not_to eq(:other)
    end
  end

  describe "#eql?" do
    it "is equal with the same decorator" do
      expect(described_class.new.add(:foo).add(:bar)).
        to eql(described_class.new.add(:foo).add(:bar))
    end

    it "is not equal with different decorator" do
      expect(described_class.new.add(:foo).add(:bar)).
        not_to eql(described_class.new.add(:foo).add(:baz))
    end

    it "is not equal to another type" do
      expect(described_class.new.add(:foo).add(:bar)).
        not_to eql(:other)
    end
  end

  describe "#inspect" do
    it "displays object information" do
      expect(described_class.new.inspect).to eq("#<Pastel::DecoratorChain decorators=[]>")
    end
  end

  describe "#hash" do
    it "calculates object hash" do
      expect(described_class.new.hash).to be_a_kind_of(Numeric)
    end
  end
end
