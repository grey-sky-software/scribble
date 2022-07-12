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

  # @return [Note]
  #   The {Note} associated with this {NoteAttachment}.
  def note
    NoteAttachmentRepository.note_for(note_id: note_id)
  end

  # @param [Symbol, String]
  #   The name of the attribute we want to retrieve the value of from the object.
  # @return [any]
  #   The value associated with the provided attribute key on this object, if the object
  #   has an attribute matching the provided key.
  # @raise [ROM::Struct::MissingAttribute]
  #   If the object does not have a matching attribute.
  def [](key)
    return hashed[key.to_sym] if hashed.key?(key.to_sym)
    raise ROM::Struct::MissingAttribute, "No attribute '#{key}' for object '#{self.class.name}'"
  end

  private

  # @return [Hash]
  #   The current {NoteAttachment} converted to a {Hash} for accessing its attributes.
  def hashed
    to_h
  end
end
