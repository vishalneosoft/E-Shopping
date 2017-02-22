class OrderMailer < ApplicationMailer
  default from: 'notifications@example.com'
 
  def order_email(user,order,address)
    @user = user
    @order = order
    @address = address
    @url  = 'https://vishal-eshopper.herokuapp.com/users/sign_in'
    @orders  = 'https://vishal-eshopper.herokuapp.com/orders'
    attachments.inline['logo.png'] = File.read("app/assets/images/home/logo.png")
    email_with_name = %("#{@user.first_name}" <#{@user.email}>)
    mail(to: @user.email, subject: 'Order has been successfully created')
  end

  def order_cancel_email(user,order,address)
    @user = user
    @order = order
    @address = address
    @url  = 'https://vishal-eshopper.herokuapp.com/users/sign_in'
    attachments.inline['logo.png'] = File.read("app/assets/images/home/logo.png")
    email_with_name = %("#{@user.first_name}" <#{@user.email}>)
    mail(to: @user.email, subject: 'Order has been successfully cancelled')
  end
end
