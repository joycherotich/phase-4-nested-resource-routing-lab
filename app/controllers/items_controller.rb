class ItemsController < ApplicationController
  before_action :set_user

  def index
    items = Item.all
    render json: items, include: :user
  end

  def show
    @item = @user.items.find_by(id: params[:id])
    render json: @item
  end

  def create
    @item = @user.items.new(item_params)
    if @item.save
      render json: @item, status: :created
    else
      render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "404" }, status: :not_found
  end

  def item_params
    params.permit(:name, :description, :price)
  end

  def render_not_found_response
    render json: { error: "404" }, status: :not_found
  end
end
