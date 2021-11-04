class TokenAuthorization
  include HTTP::Handler
  
  def call(context : HTTP::Server::Context) : HTTP::Server::Context
    begin
      token = context
        .get_req_header("Authorization")
        .split("Bearer ")
        .last
        
      payload, header = JWT.decode(token, ENV["NUEM_SECRET"], JWT::Algorithm::HS512)
      
      context
    rescue
      context
        .put_status(403)
        .json({message: "Authentication error"})
        .halt
    end
  end
end
