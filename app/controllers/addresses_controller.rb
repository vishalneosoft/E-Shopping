class AddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_address, only: [ :edit, :update, :destroy]

  # GET /addresses
  # GET /addresses.json
  def index
    @addresses = current_user.addresses
    @address = Address.new
  end

  def new
    @address = Address.new
  end
  
  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses
  # POST /addresses.json
  def create
    @address = Address.new(address_params)
    respond_to do |format|
      if @address.save
        format.html { redirect_to :back, notice: 'Address was successfully created.' }
        format.json { render :back, status: :created, location: @address }
      else
        format.html { render :new }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1
  # PATCH/PUT /addresses/1.json
  def update
    respond_to do |format|
      if params[:status].present?
        @address.update(status: 'inactive')
        format.html { redirect_to :back, notice: 'Address was successfully destroyed.' }
        format.json { render :back, status: :ok, location: @address }
      elsif @address.update(address_params)
        format.html { redirect_to :back, notice: 'Address was successfully updated.' }
        format.json { render :back, status: :ok, location: @address }
      else
        format.html { render :edit }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(:name, :address1, :address2, :city, :state, :country, :pincode, :phone, :user_id)
    end

end
