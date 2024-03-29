class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]
  before_action :set_person, only: %i[ show edit update create ]
  before_action :set_product, only: %i[ show edit update create ]


  # GET /orders or /orders.json
  def index
    if !(params[:search]).blank?
    @people = Person.all.select(:id).where(["name like ?", "%#{params[:search]}%"]).pluck(:id).first
    @products = Product.all.select(:id).where(["name like ?", "%#{params[:search]}%"]).pluck(:id).first
    @orders = Order.all.where(["person_id = ? or product_id = ?",@people,@products])
    end
    if  (params[:search]).blank?
      @orders = Order.all

    end
    @people = Person.all
    @products = Product.all 
  end



  # GET /orders/1 or /orders/1.json
  def show
    
    @people = Person.all
    @products = Product.all 
  end

  # GET /orders/new
  def new
    @order = Order.new
    @people = Person.all
    @products = Product.all 

  end

  # GET /orders/1/edit
  def edit
    @people = Person.all
    @products = Product.all 
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)
    @people = Person.all
    @products = Product.all 

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    @people = Person.all
    @products = Product.all 


    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit( :person_id , :product_id)
    end
    def set_person
      @person = Person.all
    end
    def set_product
      @product = Product.all
    end
end
