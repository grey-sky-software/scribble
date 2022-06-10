require './lib/scribble/repositories/user_repository'

# A {User} represents a user of the app who signed up to save their notes.
class User < Hanami::Entity
  # Allows us to call all of the repository methods directly on the entity for convenience,
  # such as `User.first` or `User.create`.
  def self.method_missing(method, *args, &block)
    UserRepository.send(method, *args, &block)
  end

  # Allows us to call repository methods for an instance of the entity on an
  # instance of the entity, such as `User.find(1).update(...)`.
  def method_missing(method, *args, &block)
    return hashed[method.to_sym] if hashed.key?(method.to_sym)
    UserRepository.send(method, id, *args, &block)
  end

  # @return [ROM::Relation[Note]]
  #   The collection of {Note}s created by this {User}.
  def notes
    UserRepository.notes_for(id: id)
  end

  private

  # @return [Hash]
  #   The current {User} converted to a {Hash} for accessing its attributes.
  def hashed
    self.to_h
  end
end
