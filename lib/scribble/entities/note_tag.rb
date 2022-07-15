require './lib/scribble/repositories/note_tag_repository'

# A {NoteTag} represents a tag given to a {Note} so they can be categorized.
class NoteTag < Hanami::Entity
  # Allows us to call all of the repository methods directly on the entity for convenience,
  # such as `NoteTag.first` or `NoteTag.create`.
  def self.method_missing(method, *args, &block)
    NoteTagRepository.send(method, *args, &block)
  end

  # Allows us to call repository methods for an instance of the entity on an
  # instance of the entity, such as `NoteTag.find(1).update(...)`.
  def method_missing(method, *args, &block)
    method_sym = method.to_sym
    return hashed[method_sym] if hashed.key?(method_sym)
    NoteTagRepository.send(method, id, *args, &block)
  end

  # @return [ROM::Relation[Notes]]
  #   The collection of the current user's {Note}s that are associated
  #   with this {NoteTag}.
  def notes
    NoteTagRepository.notes_with(user_id: user_id)
  end

  private

  # @return [Hash]
  #   The current {NoteTag} converted to a {Hash} for accessing its attributes.
  def hashed
    to_h
  end
end
