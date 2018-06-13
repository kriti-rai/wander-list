require 'rack-flash'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  
  enable :sessions
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  use Rack::Flash, :sweep => true

  get '/' do
    if Helper.logged_in?(session)
      @user = Helper.current_user(session)
      erb :logged_session
     else
       erb :index
     end
  end

end
