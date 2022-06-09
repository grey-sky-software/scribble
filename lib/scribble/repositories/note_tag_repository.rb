require 'singleton'

# The Repository responsible for allowing a
# NoteTag to interface with the database
class NoteTagRepository < Hanami::Repository
  include Singleton

  associations do
    belongs_to :user
    belongs_to :note
  end

  def self.method_missing(method, *args, &block)
    if instance.respond_to?(method)
      instance.send(method, *args, &block)
    elsif note_tags.respond_to?(method)
      note_tags.send(method, *args, &block)
    else
      super
    end
  end

  def self.transaction(&block)
    configuration.connection.transaction(&block)
  end

  def notes_with(tag:)
    parsed_tag = tag.to_h
    note_ids = note_tags
      .where(user_id: parsed_tag[:user_id])
      .select(:note_id)
      .map { |t| t[:note_id] }
    notes.where(id: note_ids)
  end
end
