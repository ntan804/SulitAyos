class ProductsController < ApplicationController
  def index
    @products = Product.all
    @products = Product.paginate(page: params[:page], :per_page => 10)
  end
  
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    @product.user_id = current_user.id
    @product.save
    redirect_to root_path
  end

  def show
    @product = Product.find(params[:id]) 
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update_attributes(params[:product])
    redirect_to root_path
  end

  def destroy
    Product.find(params[:id]).destroy
    redirect_to root_path
  end
  
end
