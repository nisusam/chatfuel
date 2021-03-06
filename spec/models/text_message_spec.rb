RSpec.describe TextMessage do
  describe 'associations' do
    it { should have_one(:message).dependent(:destroy) }
    it { should have_many(:steps).through(:message) }
  end

  it '#type' do
    msg = build(:text_message)

    expect(msg.type).to eq 'Chatbot'
  end

  it 'alias_attribute' do
    msg = build(:text_message, messenger_user_id: 123)

    expect(msg.session_id).to eq msg.messenger_user_id
  end
end
