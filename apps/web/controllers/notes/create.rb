require './apps/web/mixins/check_authentication'
require './apps/web/validations/validation_predicates'
#require './apps/web/mixins/uses_json'

module Web::Controllers::Notes
  # This action will be hit by authenticated users to save their newly written note
  # to the database.
  #
  # For importing notes to the database from the user's local storage, see [@TODO]
  class Create
    include CheckAuthentication
    include Web::Action
    #include UsesJson

    before :must_be_authenticated
    before { halt 400 unless params.valid? }
    #before { use_json(self) }

    params do
      predicates ValidationPredicates

      required(:body).filled(:str?)
      optional(:tags) { filled? & array? }
    end

    def call(params)
      Note.transaction do
        note = Note.create(body: body, user_id: current_user.id)

        tags.each do |tag|
          NoteTag.create(note_id: note.id, user_id: current_user.id, value: tag)
        end
      end

      redirect_to routes.root_path unless self.format == :json
      status 201, { id: note.id }.to_json
    end

    def body
      JSON.parse(params[:body]) # switch to Oj
    rescue JSON::ParserError
      { body: params[:body] }.to_json
    end

    def tags
      return [] if params[:tags].blank?
      params[:tags]
    end
  end
end
