require "./db.cr"

class AuthController < Grip::Controllers::Http

  def register(context : Context) : Context
    params = context.fetch_json_params
    
    username = params["username"]?
    password = params["password"]?
    email = params["email"]?
    color = params["color"]?
    
    if username && email && password && color
      if username.to_s.size < 2
        context
          .put_status(400)
          .json({message: "Username is too short"})
          .halt
      elsif username.to_s.size > 32
        context
          .put_status(400)
          .json({message: "Username is too long"})
          .halt
      elsif password.to_s.size < 12
        context
          .put_status(400)
          .json({message: "Password should be at least 12 characters long"})
          .halt
      elsif password.to_s.size > 256
        context
          .put_status(400)
          .json({message: "Woah slow down there buddy, that's a long password!"})
          .halt
      elsif email.to_s.size < 6
        context
          .put_status(400)
          .json({message: "E-mail is too short"})
          .halt
      elsif email.to_s.size > 64
        context
          .put_status(400)
          .json({message: "E-mail is too long"})
          .halt
      elsif color.to_s.to_i < 1 || color.to_s.to_i >=19
        context
          .put_status(400)
          .json({message: "Invalid color choice"})
          .halt
      else
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
          user.avatar = ""
          user.password = hasher.create(password.to_s)
          user.games_won = 0
          user.games_lost = 0
          user.games_played = 0
          user.color_preference = color.to_s.to_i
          user.created_at = Time.utc
          user.save
          
          token = JWT.encode({"id" => "#{user.id}", "exp" => (Time.utc + 4.week).to_unix, "iat"  => Time.utc.to_unix}, ENV["NUEM_SECRET"], JWT::Algorithm::HS512)
          
          context
            .put_status(200)
            .json({token: token})
            .halt
        end
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
      if username.to_s.size < 2
        context
          .put_status(400)
          .json({message: "Username is too short"})
          .halt
      elsif username.to_s.size > 32
        context
          .put_status(400)
          .json({message: "Username is too long"})
          .halt
      elsif password.to_s.size < 12
        context
          .put_status(400)
          .json({message: "Password should be at least 12 characters long"})
          .halt
      elsif password.to_s.size > 256
        context
          .put_status(400)
          .json({message: "Woah slow down there buddy, that's a long password!"})
          .halt
      else
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
      end
    else
      context
        .put_status(400)
        .json({message: "Required parameter(s) missing"})
        .halt
    end
  end

  def userinfo(context : Context) : Context    
    begin
      token = context
        .get_req_header("Authorization")
        .split("Bearer ")
        .last
        
      payload, header = JWT.decode(token, ENV["NUEM_SECRET"], JWT::Algorithm::HS512)
      
      db_user = User.find_by(id: payload["id"].to_s.to_i)

      if db_user
        context 
          .put_status(200)
          .json({id: db_user.id, username: db_user.username, email: db_user.email, avatar: db_user.avatar, games_won: db_user.games_won, games_lost: db_user.games_won, games_played: db_user.games_won, color: db_user.color_preference, created_at: db_user.created_at})
          .halt
      else
        context
          .put_status(403)
          .json({message: "Authentication error"})
          .halt
      end
    rescue
      context
        .put_status(403)
        .json({message: "Authentication error"})
        .halt
    end
  end

end
