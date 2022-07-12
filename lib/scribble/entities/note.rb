require './lib/scribble/repositories/note_repository'

# A {Note} represents a user-provided body of data.
class Note < Hanami::Entity
  # Allows us to call all of the repository methods directly on the entity
  # for convenience such as `Note.first` or `Note.create`.
  def self.method_missing(method, *args, &block)
    NoteRepository.send(method, *args, &block)
  end

  # Allows us to call repository methods for an instance of the entity on an
  # instance of the entity, such as `Note.find(1).update(...)`.
  def method_missing(method, *args, &block)
    method_sym = method.to_sym
    return hashed[method_sym] if hashed.key?(method_sym)
    NoteRepository.send(method, id, *args, &block)
  end

  # @return [ROM::Relation[NoteAttachments]]
  #   The collection of {NoteAttachment}s associated with this {Note}.
  def attachments
    NoteRepository.attachments_for(id: id)
  end

  # @return [ROM::Relation[NoteTags]]
  #   The collection of {NoteTags}s associated with this {Note}.
  def tags
    NoteRepository.tags_for(id: id)
  end

  # @return [ROM::Struct::User]
  #   The {User} who created this {Note}.
  def user
    NoteRepository.user_for(user_id: user_id)
  end

  # @param [Symbol, String]
  #   The name of the attribute we want to retrieve the value of from the object.
  # @return [any]
  #   The value associated with the provided attribute key on this object, if the object
  #   has an attribute matching the provided key.
  # @raise [Scribble::MissingAttributesError]
  #   If the object does not have a matching attribute.
  def [](key)
    return hashed[key.to_sym] if hashed.key?(key.to_sym)
    raise Scribble::MissingAttributesError, "No attribute '#{key}' for object '#{self.class.name}'"
  end

  private

  # @return [Hash]
  #   The current {Note} converted to a {Hash} for accessing its attributes.
  def hashed
    to_h
  end
end
