class CustomFailure < Devise::FailureApp
  def redirect_url
    restaurants_path
  end

  # Redirect to root_url
  def respond
    if http_auth?
      http_auth
    else
      redir
    end
   
end