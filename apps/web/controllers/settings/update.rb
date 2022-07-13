require './apps/web/mixins/check_authentication'
require './apps/web/validations/action_predicates'

module Web::Controllers::Settings
  class Update
    include CheckAuthentication
    include Web::Action

    before :must_be_authenticated
    before { halt 400 unless params.valid? }

    params Class.new(Hanami::Action::Params) {
      ActionPredicates.init(self)

      validations do
        required(:values) { filled? & json? }
      end
    }

    def call(params)
      if user_settings.present?
        user_settings.update_settings(payload: parsed_params)
      else
        values = UserSettings::DEFAULTS.merge(parsed_params)
        UserSettings.create(user_id: current_user.id, values: values)
      end

      status 200
    end

    def parsed_params
      Json.parse(params[:values])
    end

    def users_settings
      current_user.settings
    end
  end
end
