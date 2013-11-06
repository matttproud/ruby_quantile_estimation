require 'ruby-prof'
require 'time'
require_relative '../lib/quantile'

runs = 2 ** 12
time = Time.now.strftime('%Y-%m-%d-%H-%M-%S')
estimator = Quantile::Estimator.new

{
  :observe => lambda { |_| estimator.observe(rand) },
  :query   => lambda { |_| estimator.query(0.5) },
}.each do |report, test|
  profile = RubyProf.profile do
    runs.times(&test)
  end
  profile.eliminate_methods!([/Integer#times/, /Kernel#rand/])

  filename = File.expand_path("#{report}-#{time}.html", File.dirname(__FILE__))
  File.open(filename, 'w') do |file|
    RubyProf::GraphHtmlPrinter.new(profile).print(file)
  end
end
