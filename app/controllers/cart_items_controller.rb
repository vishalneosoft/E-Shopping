class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart_item, only: [:show, :edit, :destroy]

  # GET /cart_items
  # GET /cart_items.json
  def index
    @cart_items = current_user.cart_items
    @cart_total = 0
    @cart_items.each do |item|
      @cart_total += item.quantity * item.product.price
    end
    if @cart_total < 5000
      @shipping_cost = 50.to_f
    else
      @shipping_cost = 0.to_f
    end
  end

  # GET /cart_items/1
  # GET /cart_items/1.json
  def show
  end

  # GET /cart_items/new
  def new
    @cart_item = CartItem.new
  end

  # GET /cart_items/1/edit
  def edit
  end

  # POST /cart_items
  # POST /cart_items.json
  def create
    quantity = 1
    if params[:product_show].present?
      quantity = params[:cart_item][:quantity].to_i
    end
    @product = Product.find(params[:product_id])
    @cart_item = CartItem.where(product_id: params[:product_id],user_id: current_user.id).first
    if @product.quantity>0
      if @cart_item.present?
        @cart_item.quantity += quantity 
      else
        @cart_item = CartItem.new(quantity: quantity,product_id: params[:product_id],user_id: current_user.id)
      end
      respond_to do |format|
        if @cart_item.save
          @cart_items = current_user.cart_items
          @create_msg = 'Item added to cart successfully'
          format.html { redirect_to :back, notice: 'Item added to cart successfully' }
          format.json { render :show, status: :created, location: @cart_item }
          format.js
        else
          format.html { render :new }
          format.json { render json: @cart_item.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to :back, alert: 'Product you have purchased exceeded limit!' 
    end
  end

  # PATCH/PUT /cart_items/1
  # PATCH/PUT /cart_items/1.json
  def update
    @cart_total = 0
    @product = Product.find(params[:product_id])
    @cart_item = CartItem.find(params[:id])
    if params[:quantity_update] == "plus" && @product.quantity > 0
      @cart_item.quantity +=1
    elsif params[:quantity_update] == "minus" && @cart_item.quantity > 1
      @cart_item.quantity -=1
    elsif params[:quantity].present?
      if params[:quantity].to_i > @cart_item.quantity
        product_quantity = params[:quantity].to_i - @cart_item.quantity
        @cart_item.quantity = params[:quantity].to_i
      elsif params[:quantity].to_i < @cart_item.quantity
        product_quantity = @cart_item.quantity - params[:quantity].to_i
        @cart_item.quantity = params[:quantity].to_i
      end
    end
    respond_to do |format|
      if @cart_item.save
        current_user.cart_items.each do |item|
          @cart_total += item.quantity * item.product.price
        end
        if @cart_total < 5000
          @shipping_cost = 50.to_f
        else
          @shipping_cost = 0.to_f
        end
        @update_msg = 'Item successfully updated.'
        format.html { redirect_to :back, notice: 'Item successfully updated.' }
        format.json { render :show, status: :ok, location: @cart_item }
        format.js 
      else
        format.html { render :edit }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_items/1
  # DELETE /cart_items/1.json
  def destroy
    @cart_item.destroy
    @cart_items = current_user.cart_items
    @cart_total = 0
    @cart_items.each do |item|
      @cart_total += item.quantity * item.product.price
    end
    if @cart_total < 5000
      @shipping_cost = 50.to_f
    else
      @shipping_cost = 0.to_f
    end
    @delete_msg = "Item was successfully removed!"
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Item was successfully removed!' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_item_params
      params.require(:cart_item).permit(:quantity, :user_id, :product_id)
    end
end
