require 'rails_helper'

describe Trip, type: :model do
  describe 'validations' do
    it {should validate_presence_of :start_point}
    it {should validate_presence_of :end_point}
    it {should validate_presence_of :travel_mode}
  end

  describe 'relationships' do
    it {should belong_to :user}
  end
end
