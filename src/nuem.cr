require "grip"
require "kemal"
require "crystal-argon2"
require "rethinkdb"

require "./models/*"
require "./middleware/*"
require "./controllers/*"

module Nuem::Core
  VERSION = "1"

  ENV["NUEM_SECRET"] ||= Random::Secure.urlsafe_base64(128)

  class Application < Grip::Application

    def routes
      
      pipeline :jwt_auth, [
        TokenAuthorization.new
      ]
  
      scope "/api" do
        post "/register", AuthController, as: register
        post "/login", AuthController, as: login
        pipe_through :jwt_auth
      end
      
    end
  
    def port
      2022
    end
  
  end
  
  app = Application.new
  app.run
end

module Nuem::Ui
  get "/" do
    render
  end

  Kemal.run
end