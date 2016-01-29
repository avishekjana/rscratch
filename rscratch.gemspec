$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rscratch/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rscratch"
  s.version     = Rscratch::VERSION
  s.authors     = ["Avishek Jana"]
  s.email       = ["avishekjana.it@gmail.com"]
  s.homepage    = "https://github.com/avishekjana/rscratch"
  s.description = s.summary = "RScratch - Exception and log processing solution for Ruby on Rails application"
  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  # s.add_dependency "jquery-rails"

  s.add_dependency "smart_listing"
  s.add_dependency "haml"
  s.add_dependency 'ejs'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "haml-rails" #To use haml generator

end
