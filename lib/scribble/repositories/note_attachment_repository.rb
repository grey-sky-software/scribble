require 'singleton'

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
end
