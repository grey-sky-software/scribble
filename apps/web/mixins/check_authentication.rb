# A mixin that can be included in an action to check if the user triggering
# this action is authenticated, and finding who it is if so
module CheckAuthentication
  # @return [Boolean]
  #   whether or not the user is currently authenticated
  def authenticated?
    true
  end

  # @return [User]
  #   the currently authenticated user, if the user is authenticated
  def current_user
    return nil unless authenticated?
    # Find the user based on the token provided
    # (or whatever the auth implementation we decide on uses)
    User.first
  end

  # @return [void]
  #   when used as a callback in an action, will return a `401 Unauthorized` if the
  #   request was not made by an authenticated user
  def must_be_authenticated
    halt 401 unless authenticated?
  end
end
