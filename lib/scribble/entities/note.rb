require './lib/scribble/repositories/note_repository'

# A Note represents a user-provided body of data
class Note < Hanami::Entity
  # Allows us to call all of the repository methods directly on the entity
  # for convenience such as `Note.first` or `Note.create`
  def self.method_missing(method, *args)
    NoteRepository.send(method, *args)
  end
end
