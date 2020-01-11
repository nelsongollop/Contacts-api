require 'rails_helper'

RSpec.describe "Contacts", type: :request do
  describe '#index' do
    it "returns the contact list" do
      @contact = FactoryBot.build :contact, email: "test@test.com"
      @contact.save
      get "/api/v1/contacts"

      parsed_body = JSON.parse(response.body)
      expect(response).to be_successful
      expect(parsed_body.first["email"]).to eq("test@test.com")
    end
  end

  describe '#create' do
    it "creates a contact" do
      post "/api/v1/contacts", :params => { first_name: "Bran", last_name: "Stark", email: "test@test.com", phone: "123" }
      expect(response).to be_successful
    end

    it "creates a contact with an existing email" do
      @contact = FactoryBot.build :contact, email: "test@test.com"
      @contact.save
      post "/api/v1/contacts", :params => { first_name: "Bran", last_name: "Stark", email: "test@test.com", phone: "123" }
      expect(response).to have_http_status(422)
    end
  end

  describe '#update' do
    before do
      @contact = FactoryBot.build :contact, email: "test@test.com", id: 0
      @contact.save
    end

    it "updates a contact" do
      put "/api/v1/contacts/0", :params => { first_name: "Bran", last_name: "Stark", email: "test@test.com", phone: "12345" }
      contact = Contact.find(0)
      expect(contact.phone).to eq("12345")
      expect(response).to be_successful
    end

    it "updates a contact with an existing email" do
      @contact = FactoryBot.build :contact, email: "already@used.com"
      @contact.save
      put "/api/v1/contacts/0", :params => { first_name: "Bran", last_name: "Stark", email: "already@used.com", phone: "123" }
      expect(response).to have_http_status(422)
    end
  end
  describe '#destroy' do
    it "destroys a contact" do
      @contact = FactoryBot.build :contact, email: "test@test.com", id: 0
      @contact.save

      delete "/api/v1/contacts/0"
      expect(Contact.exists?(0)).to eq(false)
      expect(response).to be_successful
    end
  end
end