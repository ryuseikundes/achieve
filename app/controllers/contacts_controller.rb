class ContactsController < ApplicationController
  # def new
  #   if params[:back]
  #     @contact = Contact.new(contacts_params)
  #   else
  #     @contact = Contact.new
  #   end
  # end

  def new
    params[:back] ? contact_new_with_params : @contact = Contact.new

    
  end

  def create
    @contact = Contact.new(contacts_params)

    if@contact.save
    redirect_to root_path, notice:"お問い合わせが完了しました！"
    NoticeMailer.sendmail_contact(@contact).deliver

    else

      render 'new'
    end
  end

  def confirm
    @contact = Contact.new(contacts_params)
    render :new if @contact.invalid?
  end

  private
    def contacts_params
      params.require(:contact).permit(:name, :email, :contact)
    end

    def contact_new_with_params
   @contact = Contact.new(contact_params)
 end
end
