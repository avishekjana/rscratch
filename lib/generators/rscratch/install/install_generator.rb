module Rscratch
  class InstallGenerator < ::Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)
    include Rails::Generators::Migration
    
    def self.next_migration_number(path)
      unless @prev_migration_nr
        @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
      else
        @prev_migration_nr += 1
      end
      @prev_migration_nr.to_s
    end
    
    def copy_migrations
      migration_template "migration.rb", "db/migrate/rscratch_schema_migration.rb"
    end

    def create_initializer
      template 'initializer.rb.erb', 'config/initializers/rscratch.rb'
    end

    def add_route
      route("mount Rscratch::Engine => '/rscratch'")
    end
  end
end
