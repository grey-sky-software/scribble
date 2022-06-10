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
    return hashed[method.to_sym] if hashed.key?(method.to_sym)
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

  private

  # @return [Hash]
  #   The current {Note} converted to a {Hash} for accessing its attributes.
  def hashed
    self.to_h
  end
end
