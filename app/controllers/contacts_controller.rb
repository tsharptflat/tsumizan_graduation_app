class ContactsController < ApplicationController
    def new
        @contact = Contact.new
    end

    def confirm
        @contact = Contact.new(contact_params)
        if @contact.valid?
            render :confirm
        else
            render :new
        end
    end

    def create
        @contact = Contact.new(contact_params)
        if @contact.save
            ContactMailer.contact_mail(@contact).deliver
            render :complete
        else
            render :new
        end
    end

    private

    def contact_params
        params.require(:contact).permit(:name, :email, :content)
    end
end
