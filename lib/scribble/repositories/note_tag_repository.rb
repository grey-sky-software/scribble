require 'singleton'

# The {Repository} responsible for allowing a
# {NoteTag} to interface with the database.
class NoteTagRepository < Hanami::Repository
  include Singleton

  associations do
    belongs_to :user
    belongs_to :note
  end

  # Determines if the provided method is available on the `#instance` of this
  # {Repository}, or on the existing {ROM::Relation::Composite} `note_tags`
  # and sends the method to the first object that responds to it.
  # Otherwise, send it up the chain.
  def self.method_missing(method, *args, &block)
    if instance.respond_to?(method)
      instance.send(method, *args, &block)
    elsif note_tags.respond_to?(method)
      note_tags.send(method, *args, &block)
    else
      super
    end
  end

  # Exposes the `#transaction` functionality so that it becomes easier
  # for us to start a transaction on this {Repository}.
  def self.transaction(&block)
    configuration.connection.transaction(&block)
  end

  # @param [UUID] user_id
  #   The ID of the {User} who created this {NoteTag} so we can find the
  #   {User}'s {Note}s with this {NoteTag}.
  #
  # @return [ROM::Relation[Notes]]
  #   The collection of the current user's {Note}s that are associated
  #   with this {NoteTag}.
  def notes_with(user_id:)
    note_ids = note_tags.
      where(user_id: user_id).
      select(:note_id).
      pluck(:note_id)
    notes.where(id: note_ids).as(:entity)
  end
end
