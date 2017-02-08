class OrderMailer < ApplicationMailer
  default from: 'notifications@example.com'
 
  def order_email(user,order,address)
    @user = user
    @order = order
    @address = address
    attachments.inline['logo.png'] = File.read('/home/webwerks1/Desktop/Training/Rails/EShopping/app/assets/images/home/logo.png')
    email_with_name = %("#{@user.first_name}" <#{@user.email}>)
    mail(to: @user.email, subject: 'Order has been successfully created')
  end
end
