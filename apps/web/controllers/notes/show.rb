require './apps/web/mixins/check_authentication'

module Web::Controllers::Notes
  # GET /notes/:id
  # Endpoint used to render the page that displays the details of a specific {Note}.
  class Show
    include CheckAuthentication
    include Web::Action

    before :must_be_authenticated
    before { halt 400 unless params.valid? }

    params do
      required(:id).filled(:str?)
    end

    expose :note

    def call(_)
      # For some reason, `halt` does not work in methods not called inside of this
      # `#call` method.
      # So putting the following in a `#note` method and letting the expose read
      # that method directly, bypassing `#call` entirely, would not treat `halt` correctly.
      halt 404, "No Note exists with ID \"#{note_id}\"" unless Note.exist?(id: note_id)
      @note = Note.find(note_id)
    end

    # @return [Integer]
    #   The provided ID of the {Note} that we want to find.
    def note_id
      params[:id]
    end
  end
end
