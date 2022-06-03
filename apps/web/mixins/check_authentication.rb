module CheckAuthentication
  # @return [Boolean]
  #   whether or not the user is currently authenticated
  def authenticated?
    false
  end

  # @return [User]
  #   the currently authenticated user, if the user is authenticated
  def current_user
    return nil unless authenticated?
    User.find(1) # Find the user based on the token provided (or whatever the auth implementation we decide on uses)
  end
end
