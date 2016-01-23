$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rscratch/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rscratch"
  s.version     = Rscratch::VERSION
  s.authors     = ["Avishek Jana"]
  s.email       = ["avishekjana.it@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Rscratch."
  s.description = "TODO: Description of Rscratch."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.22"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
