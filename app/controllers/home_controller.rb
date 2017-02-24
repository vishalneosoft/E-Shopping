class HomeController < ApplicationController
  def index
    @banners = Banner.all
    @categories = Category.all.where(parent_id: nil)
    @category = Category.first
    if @category.present?
      @sub_categories = @category.sub_categories
      @sub_category = @sub_categories.first
      @products = @sub_category.products
    end
    @brands = Brand.all
  end
end
