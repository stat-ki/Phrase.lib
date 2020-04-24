class ContactController < ApplicationController
  def create
    @contact = Contact.new(contacts_params)
    if @contact.valid?
      ContactMailer.contact_mail(@contact).deliver
      # Parse URI to be enable to get host and port.
      uri = URI.parse("https://notify-api.line.me/api/notify")
      # Create request.
      request = Net::HTTP::Post.new(uri)
      # Set request header.
      request["Authorization"] = "Bearer #{ENV["LINE_NOTIFY_KEY"]}"
      request.set_form_data(message: @contact.message)
    begin
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |https|
        https.request(request)
      end
    rescue => e
      flash[:notice] = "お問い合わせを送信しましたが、エラーが発生しました"
      redirect_to(root_path)
    end
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
