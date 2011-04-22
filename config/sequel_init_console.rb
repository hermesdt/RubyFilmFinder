DB = Sequel.connect("sqlite://db/db.sqlite3")
Sequel::Model.db = DB
