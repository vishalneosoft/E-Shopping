class UserMailer < ApplicationMailer
  default from: 'vishal.jain.neosoft@gmail.com'

  def welcome_email(user)
    @user = user
    @url  = 'https://vishal-eshopper.herokuapp.com/users/sign_in'
    attachments.inline['logo.png'] = File.read("app/assets/images/home/logo.png")
    email_with_name = %("#{@user.first_name}" <#{@user.email}>)
    mail(to: email_with_name,subject: 'Welcome to Eshopper')
  end

  def user_message_email(contact)
    @contact = contact
    @url  = 'https://vishal-eshopper.herokuapp.com/users/sign_in'
    attachments.inline['logo.png'] = File.read("app/assets/images/home/logo.png")
    email_with_name = %("#{@contact.name}" <#{@contact.email}>)
    mail(to: email_with_name,subject: 'Reply from Eshopper')
  end
end
