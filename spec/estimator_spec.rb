require_relative '../lib/quantile'

describe Quantile::Estimator do
  let(:estimator) { Quantile::Estimator.new }

  describe '.new' do
    it 'returns a new Estimator with default quantiles' do
      estimator = Quantile::Estimator.new

      estimator.should have(3).invariants
      estimator.invariants[0].quantile.should == 0.5
      estimator.invariants[1].quantile.should == 0.9
      estimator.invariants[2].quantile.should == 0.99
    end

    it 'accepts custom quantiles' do
      quantiles = [0.7, 0.8].map { |q| Quantile::Quantile.new(q, rand) }
      estimator = Quantile::Estimator.new(*quantiles)

      estimator.should have(quantiles.size).invariants
      quantiles.each_with_index do |quantile, i|
        estimator.invariants[i].should == quantile
      end
    end
  end

  describe '#observe' do
    it 'records a given float value' do
      estimator.observe(rand)

      estimator.observations.should == 1
    end
  end

  describe '#query' do
    it 'returns the current quantile value for a given rank' do
      estimator.observe(0.8)
      estimator.observe(0.4)
      estimator.observe(0.6)

      estimator.query(0.5).should == 0.6
      estimator.query(0.9).should == 0.8
    end

    it 'handles calls without prior observations' do
      expect do
        estimator.observe(0.8)
      end.to change { estimator.query(0.5) }.from(0).to(0.8)
    end
  end
end
