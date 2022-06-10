require 'singleton'

# The {Repository} responsible for allowing a
# {NoteAttachment} to interface with the database.
class NoteAttachmentRepository < Hanami::Repository
  include Singleton

  associations do
    belongs_to :note
  end

  # Determines if the provided method is available on the `#instance` of this
  # {Repository}, or on the existing {ROM::Relation::Composite} `note_attachments`
  # and sends the method to the first object that responds to it.
  # Otherwise, send it up the chain.
  def self.method_missing(method, *args, &block)
    if instance.respond_to?(method)
      instance.send(method, *args, &block)
    elsif note_attachments.respond_to?(method)
      note_attachments.send(method, *args, &block)
    else
      super
    end
  end

  # Exposes the `#transaction` functionality so that it becomes easier
  # for us to start a transaction on this {Repository}.
  def self.transaction(&block)
    configuration.connection.transaction(&block)
  end

  # @param [NoteAttachment] attachment
  #   The {NoteAttachment} that we want to get the {Note} for.
  #
  # @return [ROM::Struct::Note]
  #   The {Note} associated with this {NoteAttachment}.
  def note_for(attachment:)
    note_id = attachment.to_h[:note_id]
    notes.where(id: note_id).first
  end
end
