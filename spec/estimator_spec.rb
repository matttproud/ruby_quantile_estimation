require_relative '../lib/quantile'

describe Quantile::Estimator do
  let(:estimator) { Quantile::Estimator.new }

  describe '.new' do
    it 'returns a new Estimator with default quantiles' do
      expect(estimator.invariants.size).to eq(3)
      expect(estimator.invariants[0].quantile).to eq(0.5)
      expect(estimator.invariants[1].quantile).to eq(0.9)
      expect(estimator.invariants[2].quantile).to eq(0.99)
    end

    it 'accepts custom quantiles' do
      quantiles = [0.7, 0.8].map { |q| Quantile::Quantile.new(q, rand) }
      estimator = Quantile::Estimator.new(*quantiles)

      expect(estimator.invariants.size).to eq(quantiles.size)
      quantiles.each_with_index do |quantile, i|
        expect(estimator.invariants[i]).to eq(quantile)
      end
    end
  end

  describe '#observe' do
    it 'records a given float value' do
      estimator.observe(rand)

      expect(estimator.observations).to eq(1)
    end
  end

  describe '#observations' do
    it 'returns the numer of recorded observations' do
      expect do
        42.times { estimator.observe(rand) }
      end.to change { estimator.observations }.from(0).to(42)
    end
  end

  describe '#sum' do
    it 'returns the sum of all observed values' do
      expect do
        42.times { |i| estimator.observe(i + 1) }
      end.to change { estimator.sum }.from(0).to(903)
    end
  end

  describe '#query' do
    it 'returns the current quantile value for a given rank' do
      estimator.observe(0.8)
      estimator.observe(0.4)
      estimator.observe(0.9)
      estimator.observe(0.6)

      expect(estimator.query(0.5)).to eq(0.6)
      expect(estimator.query(0.9)).to eq(0.8)
      expect(estimator.query(0.99)).to eq(0.8)
    end

    it 'returns nil if no observations are available' do
      expect(estimator.query(0.9)).to eq(nil)
    end
  end
end
