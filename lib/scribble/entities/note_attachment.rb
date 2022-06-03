require './lib/scribble/repositories/note_attachment_repository'

class NoteAttachment < Hanami::Entity
  # Allows us to call all of the repository methods directly on the entity for convenience,
  # such as `NoteAttachment.first` or `NoteAttachment.create`
  def self.method_missing(method, *args)
    NoteAttachmentRepository.send(method, *args)
  end
end
