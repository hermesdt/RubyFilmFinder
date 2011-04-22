require 'rubygems'
require 'rake'

namespace :db do
  require 'sequel'
  DB = Sequel.sqlite("db/db.sqlite3")

  task :migrate do
    Sequel.extension(:migration)
    Sequel::Migrator.run(DB, "db/migrate")
  end
end

task :default => [:test]

desc "muestra el texto 'testeando'"
task :test, :param1, :param2 do |t, args|

  #para mostrar uno del os parametros:
  #args[:param1] or args.param1
  puts "testando"
end
