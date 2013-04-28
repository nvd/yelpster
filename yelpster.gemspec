# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'yelpster'

Gem::Specification.new do |s|
  s.name        = 'yelpster'
  s.version     = Yelp::VERSION.dup
  s.platform    = Gem::Platform::RUBY
  s.summary     = 'Wrapper for Yelp Developer API'
  s.email       = 'naveed@10eighteen.com'
  s.homepage    = 'https://github.com/nvd/yelpster'
  s.description = 'Wrapper for Yelp Developer API'
  s.authors     = ['Naveed Siddiqui']
  s.license     = 'LGPL'

  s.files         = Dir['CHANGELOG.rdoc', 'LICENSE.txt', 'README.rdoc', 'lib/**/*']
  s.test_files    = Dir['spec/**/*.rb']
  s.require_paths = ['lib']

  s.add_dependency('json', '>= 1.1.1')
  s.add_dependency('oauth', '>= 0.4.5')
end
