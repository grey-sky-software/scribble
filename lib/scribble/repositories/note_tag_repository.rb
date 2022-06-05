require 'singleton'

# The Repository responsible for allowing a
# NoteTag to interface with the database
class NoteTagRepository < Hanami::Repository
  include Singleton

  associations do
    belongs_to :user
    belongs_to :note
  end

  def self.method_missing(method, *args)
    if instance.respond_to?(method)
      instance.send(method, *args)
    elsif note_tags.respond_to?(method)
      note_tags.send(method, *args)
    else
      super
    end
  end
end
