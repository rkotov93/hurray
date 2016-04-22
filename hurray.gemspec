Gem::Specification.new do |s|
  s.name        = 'hurray'
  s.version     = '0.1.1'
  s.date        = '2016-04-22'
  s.summary     = "Hurray!"
  s.description = "Simple ActiveRecord extension for working with database arrays fields"
  s.authors     = ["Ruslan Kotov"]
  s.email       = 'rkotov93@gmail.com'
  s.files       = ["lib/hurray.rb"]
  s.homepage    = 'https://github.com/rkotov93/hurray'
  s.license     = 'MIT'
  s.add_dependency "activerecord", ">= 4.0"
end
