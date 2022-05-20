require './lib/scribble/repositories/user_repository'

class User < Hanami::Entity
  # Allows us to call all of the repository methods directly on the entity for convenience,
  # such as `User.first` or `User.create`
  def self.method_missing(method, *args)
    if UserRepository.instance.respond_to?(method)
      UserRepository.instance.send(method, *args)
    else
      super
    end
  end
end
