require_relative '../lib/quantile'

describe Quantile::Quantile do
  describe '.new' do
    it 'returns a new Quantile with the given rank and inaccuracy' do
      quantile = Quantile::Quantile.new(0.2, 0.01)

      expect(quantile.quantile).to eq(0.2)
      expect(quantile.inaccuracy).to eq(0.01)
    end
  end

  describe '#delta' do
    it 'returns the delta to the given rank' do
      quantile = Quantile::Quantile.new(0.5, 0.05)

      expect(quantile.delta(0.9, 2)).to be < 0.23
    end
  end

  describe '#==' do
    it 'returns true if two objects describe the same quantile and accuracy' do
      a, b = Quantile::Quantile.new(0.4, 0.007), Quantile::Quantile.new(0.4, 0.007)

      expect(a).to eq(b)
    end

    it 'returns false if two objects do not have the same properties' do
      a, b = Quantile::Quantile.new(0.4, 0.007), Quantile::Quantile.new(0.4, 0.0071)

      expect(a).to_not eq(b)
    end
  end
end
