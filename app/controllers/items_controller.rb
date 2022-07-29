class ItemsController < ApplicationController

rescue_from ActiveRecord::RecordNotFound, with: :render_no_find

  def index
    
    if params[:user_id]
      user = User.find params[:user_id]
      items = user.items
    else
    items = Item.all
    end

    render json: items, include: :user
  end

  def show
    items = Item.find_by! id: params[:id]
    render json: items

  end

  def create
    user = User.find_by params[:user_id]
    item = Item.create itemsParams
    item.user = user
    render json: item, status: :created
  end

  private
  def itemsParams
    params.permit :name, :description, :price, :user_id
  end

  def render_no_find error
    #  byebug
    #  json: error.message, status: :not_found
     head :not_found
  end

end
