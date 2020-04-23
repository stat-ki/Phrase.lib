class HomeController < ApplicationController
  def top
    @contact = Contact.new
    render(layout: false)
  end
end
