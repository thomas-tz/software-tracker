require 'rails_helper'

RSpec.describe User do
  describe '#name' do
    user = described_class.new(first_name: 'Foo', last_name: 'Bar')
    it 'is the user\'s first and last name' do
      expect(user.name).to eq "#{user.first_name} #{user.last_name}"
    end
  end
end