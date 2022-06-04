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
    User.first # Find the user based on the token provided (or whatever the auth implementation we decide on uses)
  end

  # @return [void]
  #   when used as a callback in an action, will return a `401 Unauthorized` if the
  #   request was not made by an authenticated user
  def must_be_authenticated
    halt 401 unless authenticated?
  end
end
