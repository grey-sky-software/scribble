require './lib/scribble/repositories/note_tag_repository'

# A NoteTag represents a tag given to a Note so they can be categorized
class NoteTag < Hanami::Entity
  # Allows us to call all of the repository methods directly on the entity for convenience,
  # such as `NoteTag.first` or `NoteTag.create`
  def self.method_missing(method, *args)
    NoteTagRepository.send(method, *args)
  end

  # Allows us to call repository methods for an instance of the entity on an
  # instance of the entity, such as `NoteTag.find(1).update(...)`
  def method_missing(method, *args)
    NoteTagRepository.send(method, id, *args)
  end

  def notes
    NoteTagRepository.notes_for(tag: self)
  end
end
