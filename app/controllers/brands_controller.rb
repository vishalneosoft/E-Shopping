class BrandsController < ApplicationController

  # GET /brands
  # GET /brands.json
  def index
    @categories = Category.all.where(parent_id: nil)
    @category = Category.first
    @brands = Brand.all
    @brand = Brand.find(params[:id])
  end

  # GET /brands/1
  # GET /brands/1.json
  def show
    @categories = Category.all.where(parent_id: nil)
    @brands = Brand.all
    @category = Category.find(params[:category_id])
    @brand = Brand.find(params[:id])
    @sub_categories = @brand.categories.where('parent_id is not null')
    @sub_category = if(params[:sub_category])
            @brand.categories.find(params[:sub_category])
          else @sub_categories.present?
            @sub_categories.first
          end
  end

end
