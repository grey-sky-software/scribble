require './apps/web/mixins/check_authentication'
require './apps/web/validators/action_predicates'

module Web::Controllers::Notes
  # PUT /notes/:id
  # Endpoint that will be hit by the front-end to update the details of a Note object.
  # @note: This endpoint is not additive - it will replace the attributes of the Note
  #        with the provided attributes.
  class Update
    include CheckAuthentication
    include Web::Action

    params Class.new(Hanami::Action::Params) {
      ActionPredicates.init(self)

      validations do
        required(:body) { filled? & json? }
        required(:id).filled(:str?)
        optional(:tags) { filled? & array? }
      end
    }

    before :must_be_authenticated
    before { halt 400 unless params.valid? }

    def call(_)
      update_note
      redirect_to routes.root_path unless self.format == :json
      status 200, { id: note_id }.to_json
    end

    # Checks if the provided `id` param belongs to an existing Note and
    # returns the Note if so.
    # Otherwise, stops the flow of the action and returns a `404`.
    #
    # @return [Array<String>]
    def note
      id = params[:id]
      halt 404 unless Note.exist?(id: id)
      Note.find(id)
    end

    # Returns the ID of the queried Note.
    #
    # @return [Integer]
    def note_id
      note.id
    end

    # Checks if the provided `tags` param is `#blank?` and returns an empty
    # array as a fallback if so.
    # Otherwise, return the value of the `tags` param.
    #
    # @return [Array<String>]
    def tags
      tags_val = params[:tags]
      return [] if tags_val.blank?
      tags_val
    end

    # Starts a transaction to update the found Note with any provided
    # parameters.
    # It's important to keep in mind that the provided params will overwrite
    # the existing associated attribute on the Note, not expand on it.
    #
    # @return [void]
    def update_note
      Note.transaction do
        note.update(body: params[:body])
        note.tags.delete

        tags.each do |tag|
          NoteTag.create(note_id: note_id, user_id: current_user.id, value: tag)
        end
      end
    end
  end
end
