require './lib/scribble/repositories/note_tag_repository'

# A NoteTag represents a tag given to a Note so they can be categorized
class NoteTag < Hanami::Entity
  # Allows us to call all of the repository methods directly on the entity for convenience,
  # such as `NoteTag.first` or `NoteTag.create`
  def self.method_missing(method, *args)
    NoteTagRepository.send(method, *args)
  end
end
