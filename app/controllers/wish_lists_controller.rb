class WishListsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @wish_lists = current_user.wish_lists
  end

  def create
    # @product used for javascript on create
    @wish_list = WishList.find_or_initialize_by(product_id: params[:product_id],user_id: current_user.id)
    @product = Product.find(params[:product_id])
    respond_to do |format|
      if @wish_list.save
        @wish_lists = current_user.wish_lists
        @wishlist_create_msg = 'Added to Wish list.'
        format.html { redirect_to :back, notice: 'Added to Wish list.' }
        format.js
      else
        format.html { render :back }
      end
    end
  end

  def destroy
    # @product used for javascript on destroy
    # @wish_lists used for javascript on destroy to find count
    @wish_list = WishList.find(params[:id])
    @product = Product.find_by(id: @wish_list.product_id)
    @wish_list.destroy
    @wish_lists = current_user.wish_lists
    @wishlist_delete_msg = 'Product removed from wishlist successfully'
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Product removed from wishlist successfully' }
      format.js
    end
  end

end
