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
      required(:id).filled
    end

    expose :note

    def call(_)
    end

    # Checks if the provided `#note_id` belongs to an existing {Note} and
    # returns the {Note} if so.
    # Otherwise, stops the flow of the action and returns a `404`.
    #
    # @return [Note]
    #   The {Note} with the provided `#id`.
    def note
      status 404, "No Note with ID #{note_id}" unless Note.exist?(id: note_id)
      Note.find(note_id)
    end

    # @return [Integer]
    #   The provided ID of the {Note} that we want to find.
    def note_id
      params[:id]
    end
  end
end
