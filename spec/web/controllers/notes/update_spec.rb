RSpec.describe Web::Controllers::Notes::Update, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'is successful', pending: 'auth needs to be implemented' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
