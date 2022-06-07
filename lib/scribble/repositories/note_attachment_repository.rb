require 'singleton'

# The Repository responsible for allowing a
# NoteAttachment to interface with the database
class NoteAttachmentRepository < Hanami::Repository
  include Singleton

  associations do
    belongs_to :note
  end

  def self.method_missing(method, *args)
    if instance.respond_to?(method)
      instance.send(method, *args)
    elsif note_attachments.respond_to?(method)
      note_attachments.send(method, *args)
    else
      super
    end
  end

  def note_for(attachment:)
    note_id = attachment.to_h[:note_id]
    notes.where(id: note_id).first
  end
end
