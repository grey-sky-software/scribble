require './lib/scribble/repositories/note_repository.rb'

class Note < Hanami::Entity
  # Allows us to call all of the repository methods directly on the entity 
  # for convenience such as `Note.first` or `Note.create`
  def self.method_missing(method, *args)
    if NoteRepository.instance.respond_to?(method)
      NoteRepository.instance.send(method, *args)
    else
      super
    end
  end
end
