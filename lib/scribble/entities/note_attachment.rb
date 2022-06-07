require './lib/scribble/repositories/note_attachment_repository'

# A NoteAttachment represents a file uploaded to and associated with a Note
class NoteAttachment < Hanami::Entity
  # Allows us to call all of the repository methods directly on the entity for convenience,
  # such as `NoteAttachment.first` or `NoteAttachment.create`
  def self.method_missing(method, *args)
    NoteAttachmentRepository.send(method, *args)
  end

  # Allows us to call repository methods for an instance of the entity on an
  # instance of the entity, such as `NoteAttachment.find(1).update(...)`
  def method_missing(method, *args)
    NoteAttachmentRepository.send(method, id, *args)
  end

  def note
    NoteAttachmentRepository.note_for(attachment: self)
  end
end
