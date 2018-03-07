class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show

  end

  def new
    @cat = Cat.new
    p params
    render :new
  end

  def create
    # render json: params
    # @errors = ''
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    end
      # redirect_to new_cat_url
      # render json: @cat.errors.full_messages, status: 422
      # @errors = "#{@cat.errors.full_messages}"
  end

  def edit
    @cat = Cat.find(params[:id])

    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      render json: @cat.errors.full_messages, status: 422
    end
  end
  
private
  def cat_params
    params.require(:cat).permit(:name, :birth_date, :color, :sex, :description)
  end
end
