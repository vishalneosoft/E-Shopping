module ApplicationHelper

  def collapse_css(selected, category)
    if selected.id == category.id
      "panel-collapse collapse in"
    else
      "panel-collapse collapse"
    end
  end

  def quantity_css(user, product)
    if user.cart_items.find_by(product_id: product).present?
      user.cart_items.find_by(product_id: product).quantity
    else
      1
    end
  end
end
