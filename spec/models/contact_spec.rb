require 'rails_helper'

RSpec.describe Contact, type: :model do
  context "contact has correct values" do
    it "save the contact" do
      @contact = FactoryBot.build :contact
      @contact.save!
      expect(@contact.id).not_to eq(nil)
    end
  end

  context "contact has invalid values" do

    before do
      @contact = FactoryBot.build :contact
    end

    it "do not save the contact without a blank field" do
      @contact.first_name = nil
      @contact.save
      expect(@contact.id).to eq(nil)
    end

    it "do not save the contact if the email is taken" do
      @previous_contact = FactoryBot.build :contact, email: "test@test.com"
      @previous_contact.save

      @contact.email = "test@test.com"
      @contact.save
      expect(@contact.id).to eq(nil)
    end
  end
end
