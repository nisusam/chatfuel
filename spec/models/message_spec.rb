RSpec.describe Message do
  describe 'associations' do
    it { should have_many(:steps) }
    it { should belong_to(:content) }
  end

  describe 'delegates' do
    it { should delegate_method(:type).to(:content) }
    it { should delegate_method(:session_id).to(:content) }
  end

  describe '.create_or_return' do
    let(:content) { build(:voice_message) }

    context 'existence' do
      it 'create a new message if not exist' do
        expect {
          described_class.create_or_return(content)
        }.to change { Message.count }
      end

      it 'returns if already created' do
        create(:message, content: content)

        expect {
          described_class.create_or_return(content)
        }.not_to change {
          Message.count
        }
      end
    end

    context 'completion' do
      before do
        @message = create(:message, content: content)
      end

      it 'returns if incompleted' do
        expect {
          described_class.create_or_return(content)
        }.not_to change { Message.count }
      end

      it 'creates if completed' do
        create(:step, act: 'done', value: 'true', message: @message)
        
        expect {
          described_class.create_or_return(content)
        }.to change { Message.count }
      end
    end
  end
end
