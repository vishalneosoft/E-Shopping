class HomeController < ApplicationController
  def index
    @banners = Banner.all
    @categories = Category.all.where(parent_id: nil)
    @category = Category.first
    if @category.present?
      @subcategories = @category.sub_categories
      @subcategory = @category.sub_categories.first
    end
    if @subcategory.present?
      @products = @subcategory.products
    end
    @brands = Brand.all
  end
end
