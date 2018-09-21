class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :set_line_item, only: %i[show edit update]
  before_action :set_cart_line_item, only: %i[destroy decrement]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show; end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit; end

  # POST /line_items
  # POST /line_items.json
  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)

    respond_to do |format|
      if @line_item.save
        session[:counter] = 0
        format.html { redirect_to store_index_url }
        format.js { @current_item = @line_item }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    destroy_line_item_response
  end

  def decrement
    @line_item.decrement_or_destroy!
    if @line_item.destroyed?
      destroy_line_item_response
    else
      decrement_line_item_response
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def line_item_params
    params.require(:line_item).permit(:product_id)
  end

  def set_cart_line_item
    @line_item = LineItem.find(params[:id])
    @cart = @line_item.cart
    # @line_item = @cart.line_items.find_by_id(params[:id])
  end

  def decrement_line_item_response
    respond_to do |format|
      format.html { redirect_to cart_url(@cart), notice: 'Line item was successfully decreased.' }
      format.js { @current_item = @line_item }
      format.json { head :ok }
    end
end

  def destroy_line_item_response
    respond_to do |format|
      format.html { redirect_to cart_url(@cart), notice: 'Line item was successfully destroyed.' }
      format.js do
        @current_item = @line_item
        render file: 'line_items/destroy'
      end
      format.json { head :ok }
    end
  end
end
