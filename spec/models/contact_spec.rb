require 'rails_helper'

describe Contact, type: :model do
  describe 'validations' do
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
    it {should validate_presence_of :phone_number}
  end

  describe 'relationships' do
    it {should belong_to :user}
  end
end
