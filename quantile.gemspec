require './lib/quantile'

Gem::Specification.new do |gem|
  gem.name    = 'quantile'
  gem.version = Quantile::VERSION
  gem.date    = '2013-07-22'

  gem.summary = "Streaming Quantile Estimation"
  gem.description = "Graham Cormode and S. Muthukrishnan's Effective Computation of Biased Quantiles over Data Streams in ICDE’05"

  gem.authors  = ['Matt T. Proud']
  gem.email    = 'matt.proud@gmail.com'
  gem.homepage = 'http://github.com/matttproud/ruby_quantile_estimation'

  gem.add_dependency('rake')
  gem.add_development_dependency('rspec', [">= 2.0.0"])

  gem.files = Dir['{lib/**/*', 'README*', 'LICENSE*'] & `git ls-files -z`.split("\0")
end

