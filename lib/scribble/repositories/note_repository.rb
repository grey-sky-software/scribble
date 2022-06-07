require 'singleton'

# The Repository responsible for allowing a
# Note to interface with the database
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
    elsif notes.respond_to?(method)
      notes.send(method, *args)
    else
      super
    end
  end

  def attachments_for(id:)
    note_attachments.where(note_id: id)
  end

  def tags_for(id:)
    note_tags.where(note_id: id)
  end

  def user_for(note:)
    user_id = note.to_h[:user_id]
    users.where(id: user_id).first
  end
end
