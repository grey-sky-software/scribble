require 'singleton'

class NoteRepository < Hanami::Repository
  include Singleton

  associations do
    belongs_to :user
    has_many :note_tags
    has_many :note_attachments
  end

  def self.method_missing(method, *args)
    if instance.respond_to?(method)
      instance.send(method, *args)
    else
      super
    end
  end
end
