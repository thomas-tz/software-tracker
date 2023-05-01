require 'rails_helper'

RSpec.describe User do
  let(:user) { create(:user) }
  let(:tool) { create(:tool, :with_user) }

  describe '#name' do
    it 'is the user\'s first and last name' do
      expect(subject.name).to eq "#{subject.first_name} #{subject.last_name}"
    end
  end

  describe '.not_subscribed' do
    it 'is all the user records not associated with a particular tool' do
      expect(described_class.not_subscribed(tool)).to contain_exactly(user)
    end
  end
end