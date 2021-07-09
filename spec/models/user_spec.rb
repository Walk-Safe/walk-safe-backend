require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
    it {should validate_presence_of :username}
  end

  describe 'relationships' do
    it {should have_many :contacts}
    it {should have_many :trips}
  end
end
