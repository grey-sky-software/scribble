require 'singleton'

class NoteTagRepository < Hanami::Repository
  include Singleton

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
