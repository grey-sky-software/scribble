RSpec.describe Web::Controllers::Notes::Show, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  # , pending: 'auth needs to be implemented'
  it 'is successful' do
    response = action.call(params)
    puts User.count
    puts response[2]
    expect(response[0]).to eq 200
  end
end
