# A mixin that can be included in an {Action} to check if the user triggering
# this {Action} is authenticated, and finding who it is if so.
module CheckAuthentication
  # @return [Boolean]
  #   Whether or not the user is currently authenticated.
  # This method smells of :reek:UtilityFunction
  def authenticated?
    User.first.present?
  end

  # @return [User]
  #   The currently authenticated user, if there is an authenticated user.
  def current_user
    return nil unless authenticated?
    # @todo
    #   Find the user based on the token provided
    #   (or whatever the auth implementation we decide on uses)
    User.first
  end

  # @return [void]
  #   When used as a callback in an {Action}, will return a `401 Unauthorized` if the
  #   request was not made by an authenticated user.
  def must_be_authenticated
    halt 401 unless authenticated?
  end
end
