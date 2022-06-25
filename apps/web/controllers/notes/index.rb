require './apps/web/mixins/check_authentication'

module Web::Controllers::Notes
  # GET /notes
  # Responsible for querying any data needed to render the
  # list of the current user's {Note}s.
  class Index
    include CheckAuthentication
    include Web::Action

    expose :notes

    def call(_)
      # I dunno, figure out something to do in here
    end

    # @return [ROM::Relation[Notes]]
    #   The value of `#notes` will depend on whether the user is authenticated or not.
    #   If authenticated, we'll get the notes from the DB.
    #   Otherwise, we'll get them from local storage.
    def notes
      return unless authenticated?
      current_user.notes.order { created_at.desc }
    end
  end
end
