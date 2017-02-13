class WishListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_wish_list, only: [:show, :edit, :update]

  # GET /wish_lists
  # GET /wish_lists.json
  def index
    @wish_lists = WishList.all
  end

  # GET /wish_lists/1
  # GET /wish_lists/1.json
  def show
  end

  # GET /wish_lists/new
  def new
    @wish_list = WishList.new
  end

  # GET /wish_lists/1/edit
  def edit
  end

  # POST /wish_lists
  # POST /wish_lists.json
  def create
    @wish_list = WishList.new(product_id: params[:product_id],user_id: current_user.id)
    @product = Product.find(params[:product_id])
    respond_to do |format|
      if @wish_list.save
        @wish_lists = current_user.wish_lists
        @wishlistcreatemsg = 'Added to Wish list.'
        format.html { redirect_to :back, notice: 'Added to Wish list.' }
        format.json { render :show, status: :created, location: @wish_list }
        format.js
      else
        format.html { render :new }
        format.json { render json: @wish_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wish_lists/1
  # PATCH/PUT /wish_lists/1.json
  def update
    respond_to do |format|
      if @wish_list.update(wish_list_params)
        format.html { redirect_to @wish_list, notice: 'Wish list was successfully updated.' }
        format.json { render :show, status: :ok, location: @wish_list }
      else
        format.html { render :edit }
        format.json { render json: @wish_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wish_lists/1
  # DELETE /wish_lists/1.json
  def destroy
    @wish_list = WishList.find_by(product_id: params[:id])
    @product = Product.find(params[:id])
    @wish_list.destroy
    @wish_lists = current_user.wish_lists
    @wishlistdeletemsg = 'Product removed from wishlist successfully'
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Product removed from wishlist successfully' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wish_list
      @wish_list = WishList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wish_list_params
      params.require(:wish_list).permit(:user_id, :product_id, :quantity)
    end
end
