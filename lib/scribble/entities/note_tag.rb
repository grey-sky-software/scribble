require './lib/notary/repositories/note_tag_repository'

class NoteTag < Hanami::Entity
  # Allows us to call all of the repository methods directly on the entity for convenience,
  # such as `NoteTag.first` or `NoteTag.create`
  def self.method_missing(method, *args)
    if NoteTagRepository.instance.respond_to?(method)
      NoteTagRepository.instance.send(method, *args)
    else
      super
    end
  end
end