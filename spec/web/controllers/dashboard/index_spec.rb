RSpec.describe Web::Controllers::Dashboard::Index, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  before(:example) do
    Note.create(user_id: User.first.id, body: { test: 'value' }.to_json)
  end

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
