module Web
  module Controllers
    module Notes
      class Index
        include Web::Action

        # @return [Array<Note>]
        #   the collection of the user's notes to render on the note list page
        expose :notes

        def call(params)
          # the value of notes will depend on whether the user is authenticated or not
          # if authenticated, we'll get the notes from the DB
          # otherwise, we'll get them from local storage
          @notes = []
        end
      end
    end
  end
end
