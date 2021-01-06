
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_campaign/version'

Gem::Specification.new do |spec|
  spec.name          = 'active_campaign_rb'
  spec.version       = ActiveCampaign::VERSION
  spec.authors       = ['Brent Odell']
  spec.email         = ['brentdodell@gmail.com']

  spec.summary       = %q{ActiveCampaign client}
  spec.homepage      = 'https://github.com/brentdodell/active_campaign'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0.1'
  spec.add_development_dependency "dotenv"
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec_junit_formatter', '~> 0.4.1'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'webmock', '~> 3.4', '>= 3.4.2'

  spec.add_dependency 'httparty', '~> 0.16.2'
  spec.add_dependency 'dry-configurable', '~> 0.12.0'
  spec.add_dependency 'hashie', '~> 3.5', '>= 3.5.7'
end
