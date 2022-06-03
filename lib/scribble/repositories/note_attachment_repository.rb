require 'singleton'

class NoteAttachmentRepository < Hanami::Repository
  include Singleton

  assocications do
    belongs_to :note
  end

  def self.method_missing(method, *args)
    if instance.respond_to?(method)
      instance.send(method, *args)
    else
      super
    end
  end
end
