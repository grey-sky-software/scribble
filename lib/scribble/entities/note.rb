require './lib/scribble/repositories/note_repository'

# A Note represents a user-provided body of data
class Note < Hanami::Entity
  # Allows us to call all of the repository methods directly on the entity
  # for convenience such as `Note.first` or `Note.create`
  def self.method_missing(method, *args, &block)
    NoteRepository.send(method, *args, &block)
  end

  # Allows us to call repository methods for an instance of the entity on an
  # instance of the entity, such as `Note.find(1).update(...)`
  def method_missing(method, *args, &block)
    NoteRepository.send(method, id, *args, &block)
  end

  def attachments
    NoteRepository.attachments_for(id: id)
  end

  def tags
    NoteRepository.tags_for(id: id)
  end

  def user
    NoteRepository.user_for(note: self)
  end
end
