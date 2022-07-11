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
      # @NOTE
      #   From what I've learned in my experimenting and research, `halt` only works when
      #   control can be given back to the framework, and `expose` does not do that.
      #   So if we plan on `halt`ing, we have to do it directly in the `#call` method, or
      #   in a method whose triggering originates from the `#call` method.
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
