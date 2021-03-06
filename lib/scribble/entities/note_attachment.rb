require './lib/scribble/repositories/note_attachment_repository'

# A {NoteAttachment} represents a file uploaded to and associated with a {Note}.
class NoteAttachment < Hanami::Entity
  # Allows us to call all of the repository methods directly on the entity for convenience,
  # such as `NoteAttachment.first` or `NoteAttachment.create`.
  def self.method_missing(method, *args, &block)
    NoteAttachmentRepository.send(method, *args, &block)
  end

  # Allows us to call repository methods for an instance of the entity on an
  # instance of the entity, such as `NoteAttachment.find(1).update(...)`.
  def method_missing(method, *args, &block)
    method_sym = method.to_sym
    return hashed[method_sym] if hashed.key?(method_sym)
    NoteAttachmentRepository.send(method, id, *args, &block)
  end

  # @return [ROM::Struct::Note]
  #   The {Note} associated with this {NoteAttachment}.
  def note
    NoteAttachmentRepository.note_for(note_id: note_id)
  end

  private

  # @return [Hash]
  #   The current {NoteAttachment} converted to a {Hash} for accessing its attributes.
  def hashed
    to_h
  end
end
