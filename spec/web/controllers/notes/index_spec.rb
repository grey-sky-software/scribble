RSpec.describe Web::Controllers::Notes::Index, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'is successful', skip: true do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
