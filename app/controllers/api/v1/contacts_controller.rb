class Api::V1::ContactsController < ApplicationController
  before_action :set_contact, only: [:update, :destroy]

  def index
    render json: all_contacts
  end

  def create
    contact = Contact.new(contact_params)
    if contact.save
      render json: all_contacts
    else
      if contact.errors.details[:email].present?
        render status: :unprocessable_entity
      else
        render status: :bad_request
      end
    end
  end

  def update
    if @contact.update(contact_params)
      render json: all_contacts
    else
      if @contact.errors.details[:email].present?
        render status: :unprocessable_entity
      else
        render status: :bad_request
      end
    end
  end

  def destroy
    if @contact.destroy
      render json: all_contacts
    else
      render status: :bad_request
    end
  end

  private
    def all_contacts
      Contact.all.order(:first_name).to_json
    end

    def contact_params
      params.permit(:id, :first_name, :last_name, :phone, :email)
    end

    def set_contact
      @contact = Contact.find(params[:id])
    end
end
