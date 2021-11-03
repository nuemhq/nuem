require "./db.cr"

class AuthController < Grip::Controllers::Http

  def register(context : Context) : Context
    params = context.fetch_json_params
    
    username = params["username"]?
    password = params["password"]?
    email = params["email"]?
    color = params["color"]?
    
    if username && email && password && color
      db_username = User.find_by(username: username)
      db_email = User.find_by(email: email)
      
      if db_username || db_email
        context
          .put_status(400)
          .json({message: "Username or e-mail has been taken."})
          .halt
      else
        hasher = Argon2::Password.new
        
        user = User.new
        user.username = username.to_s
        user.email = email.to_s
        user.password = hasher.create(password.to_s)
        user.color_preference = color.to_s.to_i
        user.created_at = Time.utc
        user.save
        
        token = JWT.encode({"id" => "#{user.id}", "exp" => (Time.utc + 4.week).to_unix, "iat"  => Time.utc.to_unix}, ENV["NUEM_SECRET"], JWT::Algorithm::HS512)
        
        context
          .put_status(200)
          .json({token: token})
          .halt
      end
    else
      context
        .put_status(400)
        .json({message: "Required parameter(s) missing"})
        .halt
    end
  end

  def login(context : Context) : Context
    params = context.fetch_json_params
    
    username = params["username"]?
    password = params["password"]?
    
    if username && password
    
      db_user = User.find_by(username: username.to_s)
      
      if db_user
        hashed_password = db_user.password
        Argon2::Password.verify_password(password.to_s, hashed_password)
        
        token = JWT.encode({"id" => "#{db_user.id}", "exp" => (Time.utc + 4.week).to_unix, "iat"  => Time.utc.to_unix}, ENV["NUEM_SECRET"], JWT::Algorithm::HS512)
        
        context
          .put_status(200)
          .json({token: token})
          .halt
      else
        context
          .put_status(400)
          .json({message: "User not found"})
      end
    else
      context
        .put_status(400)
        .json({message: "Required parameter(s) missing"})
        .halt
    end
  end

end
