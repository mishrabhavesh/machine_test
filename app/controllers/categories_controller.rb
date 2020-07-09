class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :require_login 
  before_action :require_admin 

  def index
    @categories = Category.all
  end


  def show
  end

  def new
    @category = Category.new
  end

  def edit
  end


  def create
    @category = Category.new(category_params)
      if @category.save
        redirect_to root_path, notice: 'Category was successfully created.' 
      else
     render :new 
      end
  end


  def update
      if @category.update(category_params)
        format.html { redirect_to root_path, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
      end
  end


  def destroy
    @category.destroy
      format.html { redirect_to root_path, notice: 'Category was successfully destroyed.' }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name)
    end
end
