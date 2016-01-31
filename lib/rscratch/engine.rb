require 'smart_listing'
require 'haml'
require 'ejs'
require 'jbuilder'

module Rscratch
  class Engine < ::Rails::Engine
    isolate_namespace Rscratch
  end
end
