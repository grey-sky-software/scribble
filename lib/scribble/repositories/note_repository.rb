require 'singleton'

class NoteRepository < Hanami::Repository
  include Singleton

  def self.method_missing(method, *args)
    if instance.respond_to?(method)
      instance.send(method, *args)
    elsif notes.respond_to?(method)
      notes.send(method, *args)
    else
      super
    end
  end
end
