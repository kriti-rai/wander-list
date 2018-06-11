class Helper
  def logged_in?(session)
    !!session[:id]
  end

  def current_user(session)
    User.find(session[:id])
  end
end
