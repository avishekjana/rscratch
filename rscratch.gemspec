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

  # s.add_dependency "rails", "~> 3.2.22"
  # s.add_dependency "jquery-rails"
  s.add_dependency "smart_listing", "~>1.1.0"
  s.add_dependency "haml"
  s.add_dependency "coffee-rails"
  s.add_dependency "materialize-sass"
  
  s.add_development_dependency "sqlite3"
end
