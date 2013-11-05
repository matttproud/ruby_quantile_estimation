require_relative '../lib/quantile'

describe Quantile::Quantile do
  describe '.new' do
    it 'returns a new Quantile with the given rank and inaccuracy' do
      quantile = Quantile::Quantile.new(0.2, 0.01)

      quantile.quantile.should == 0.2
      quantile.inaccuracy.should == 0.01
    end
  end

  describe '#delta' do
    it 'returns the delta to the given rank' do
      quantile = Quantile::Quantile.new(0.5, 0.05)

      quantile.delta(0.9, 2).should < 0.23
    end
  end
end
