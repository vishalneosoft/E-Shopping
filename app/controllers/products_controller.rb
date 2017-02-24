class ProductsController < ApplicationController
  
  def show
    @categories = Category.all.where(parent_id: nil)
    @brands = Brand.all
    @cartitems = CartItem.all
    @cartitem = CartItem.new
    @product = Product.find(params[:id])
    @recommended = @product.products
  end

  private

    def product_params
      params.require(:product).permit(:name, :sku, :short_description, :long_description, :price, :status, :quantity)
    end
end
