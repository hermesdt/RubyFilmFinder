require 'rubygems'
require 'rake'

desc "Start a sequel console"
task :console do
  system "sequel -r config/sequel_init_console.rb -L models"
end

namespace :db do
  require 'sequel'
  require 'logger'

  DB = Sequel.sqlite("db/db.sqlite3")
  DB.logger = Logger.new($stdout)

  desc "Run all pending migrations"
  task :migrate do
    Sequel.extension(:migration)
    DB.log_info "Run sequel migrator"
    Sequel::Migrator.run(DB, "db/migrate")
    DB.log_info "Ended sequel migrator"
  end

  desc "Undo last migration"
  task :rollback do
    last_version = DB[:schema_info].all.last[:version]
    
    Sequel.extension(:migration)
    Sequel::Migrator.run(DB, "db/migrate", :current => last_version, :target => (last_version - 1))
    DB.log_info "Reverted migration: #{last_version}"
  end
end

task :default => [:test]

desc "muestra el texto 'testeando'"
task :test, :param1 do |t, args|

  #para mostrar uno del os parametros:
  #args[:param1] or args.param1
  puts args[:param1]
  puts "testando"
end
