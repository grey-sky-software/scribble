require 'singleton'

# The {Repository} responsible for allowing a
# {Note} to interface with the database.
class NoteRepository < Hanami::Repository
  include Singleton

  associations do
    belongs_to :user
    has_many :note_tags
    has_many :note_attachments
  end

  # Determines if the provided method is available on the `#instance` of this
  # {Repository}, or on the existing {ROM::Relation::Composite} `notes`
  # and sends the method to the first object that responds to it.
  # Otherwise, send it up the chain.
  def self.method_missing(method, *args, &block)
    if instance.respond_to?(method)
      instance.send(method, *args, &block)
    elsif notes.respond_to?(method)
      notes.send(method, *args, &block)
    else
      super
    end
  end

  # Exposes the `#transaction` functionality so that it becomes easier
  # for us to start a transaction on this {Repository}.
  def self.transaction(&block)
    configuration.connection.transaction(&block)
  end

  # @param [UUID] id
  #   The ID of the {Note} that we want to get the {NoteAttachment}s for.
  #
  # @return [ROM::Relation[NoteAttachments]]
  #   The collection of {NoteAttachment}s associated with this {NoteRepository}.
  def attachments_for(id:)
    note_attachments.where(note_id: id).as(:entity)
  end

  # @param [UUID] id
  #   The ID of the {Note} that we want to get the {NoteTag}s for.
  #
  # @return [ROM::Relation[NoteTags]]
  #   The collection of {NoteTags}s associated with this {NoteRepository}.
  def tags_for(id:)
    note_tags.where(note_id: id).as(:entity)
  end

  # @param [UUID] user_id
  #   The ID of the {User} who created this {Note}.
  #
  # @return [User]
  #   The {User} who created this {Note}.
  def user_for(user_id:)
    users.where(id: user_id).as(:entity).first
  end
end
