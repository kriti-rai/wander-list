class Helper
  def self.logged_in?(session)
    !!session[:id]
  end

  def self.current_user(session)
    @user ||= User.find(session[:id])
  end
end
