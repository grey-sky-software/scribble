require './lib/scribble/repositories/user_repository'

class User < Hanami::Entity
  # Allows us to call all of the repository methods directly on the entity for convenience,
  # such as `User.first` or `User.create`
  def self.method_missing(method, *args)
    UserRepository.send(method, *args)
  end

  def notes
    UserRepository.notes_for(id: id)
  end
end
