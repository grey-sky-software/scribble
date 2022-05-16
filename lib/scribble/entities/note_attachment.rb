require './lib/notary/repositories/note_attachment_repository'

class NoteAttachment < Hanami::Entity
  # Allows us to call all of the repository methods directly on the entity for convenience,
  # such as `NoteAttachment.first` or `NoteAttachment.create`
  def self.method_missing(method, *args)
    if NoteAttachmentRepository.instance.respond_to?(method)
      NoteAttachmentRepository.instance.send(method, *args)
    else
      super
    end
  end
end
