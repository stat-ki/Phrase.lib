class ContactController < ApplicationController
  def create
    @contact = Contact.new(contacts_params)
    if @contact.valid?
      ContactMailer.contact_mail(@contact).deliver
      flash[:notice] = "お問い合わせ内容を送信しました"
      redirect_to(root_path)
    else
      flash.now[:notice] = "入力内容に不備があります"
      render("/home/top", layout: false)
    end
  end

  private

  def contacts_params
    params.require(:contact).permit(:email, :message)
  end
end
