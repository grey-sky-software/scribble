RSpec.describe Web::Controllers::Notes::Create, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'is successful', :skip do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
