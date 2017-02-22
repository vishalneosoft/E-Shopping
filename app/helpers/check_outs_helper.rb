module CheckOutsHelper
  def review_items(address)
    if !current_user.addresses.pluck(:id).include?(address.id)
      redirect_to root_path, alert: 'There is no such address'
    elsif address.status == 'inactive'
      redirect_to root_path, alert: 'There is no such address'
    end
  end
end