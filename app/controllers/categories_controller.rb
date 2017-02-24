class CategoriesController < ApplicationController

  # GET /categories/1
  # GET /categories/1.json
  def show
    @categories = Category.all.where(parent_id: nil)
    @brands = Brand.all
    @category = Category.find(params[:id])
    @sub_categories = @category.sub_categories
    @sub_category = if(params[:sub_category])
                    @sub_categories.find(params[:sub_category])
                  else @sub_categories.present?
                    @sub_categories.first
                  end
    @products = @sub_category.products                  
  end
  
end
