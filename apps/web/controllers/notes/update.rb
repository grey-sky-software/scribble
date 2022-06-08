require './apps/web/mixins/check_authentication'
require './apps/web/mixins/validation_predicates'
#require './apps/web/mixins/uses_json'

module Web::Controllers::Notes
  class Update
    include CheckAuthentication
    include Web::Action
    #include UsesJson

    before :must_be_authenticated
    before { halt 400 unless params.valid? }
    #before { use_json(self) }

    predicates ValidationPredicates
    params do
      required(:body).filled(:str?)
      required(:id).filled(:str?)
      optional(:tags) { filled? & array? }
    end

    def call(params)
      Note.transaction do
        note.update(body: body)
        note.tags.delete

        tags.each do |tag|
          NoteTag.create(note_id: note.id, user_id: current_user.id, value: tag)
        end
      end

      redirect_to routes.root_path unless self.format == :json
      status 200, { id: note.id }.to_json
    end

    def note
      halt 404 unless Note.exist?(id: params[:id])
      Note.find(params[:id])
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
