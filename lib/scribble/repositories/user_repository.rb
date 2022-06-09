require 'singleton'

# The Repository responsible for allowing a
# User to interface with the database
class UserRepository < Hanami::Repository
  include Singleton

  associations do
    has_many :notes
    has_many :note_tags
    has_many :note_attachments, through: :notes
  end

  def self.method_missing(method, *args, &block)
    if instance.respond_to?(method)
      instance.send(method, *args, &block)
    elsif users.respond_to?(method)
      users.send(method, *args, &block)
    else
      super
    end
  end

  def self.transaction(&block)
    configuration.connection.transaction(&block)
  end

  def notes_for(id:)
    notes.where(user_id: id)
  end
end
