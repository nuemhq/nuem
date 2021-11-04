require "granite"
require "granite/adapter/sqlite"

module Nuem::DB
    def self.sqlite(name, url)
        Granite::Connections << Granite::Adapter::Sqlite.new(name, url)
    end
end

Nuem::DB.sqlite("sqlite", "sqlite3://./nuem.db")

class User < Granite::Base
    connection sqlite

    column id : Int64, primary: true
    column username : String
    column email : String
    column avatar : String
    column password : String
    column games_won : Int32
    column games_lost : Int64
    column games_played : Int64
    column color_preference : Int32
    column created_at : Time
end

#User.migrator.drop_and_create