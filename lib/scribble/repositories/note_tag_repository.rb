require 'singleton'

class NoteTagRepository < Hanami::Repository
  include Singleton
  
  associations do
    belongs_to :user
    beolongs_to :note
  end

  def self.method_missing(method, *args)
    if instance.respond_to?(method)
      instance.send(method, *args)
    else
      super
    end
  end
end
