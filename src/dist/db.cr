require "granite"
require "granite/adapter/sqlite"

module Nuem::DB
    def self.sqlite(name, url)
        Granite::Connections << Granite::Adapter::Sqlite.new(name, url)
    end
end

Nuem::DB.sqlite("sqlite", "sqlite3://./mira.db")

class User < Granite::Base
    connection sqlite

    column id : Int64, primary: true
    column username : String
    column email : String
    column password : String
    column color_preference : Int32
    column created_at : Time
end

User.migrator.drop_and_create