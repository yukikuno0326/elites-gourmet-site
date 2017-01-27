class RestaurantsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    
  end
  
  def show
    
  end
  
  def new
    @restaurant = Restaurant.new
    5.times do
      @restaurant.restaurant_images.build
    end
  end
  
  def confirm
    if params[:id].present?
      @restaurant = Restaurant.find(params[:id])
      @restaurant.attributes = input_params
      @restaurant.user_id = current_user.id
      if @restaurant.invalid?
        flash.now[:alert] = @restaurant.errors.full_messages
        render :edit
      elsif !@restaurant.restaurant_images.first.image?
        @restaurant.errors[:base] << I18n.t('restaurant.image_error')
        flash.now[:alert] = @restaurant.errors.full_messages
        render :edit
      end
    else
      @restaurant = Restaurant.new(input_params)
      @restaurant.user_id = current_user.id
      if @restaurant.invalid?
        flash.now[:alert] = @restaurant.errors.full_messages
        render :new
      elsif !@restaurant.restaurant_images.first.image?
        @restaurant.errors[:base] << I18n.t('restaurant.image_error')
        flash.now[:alert] = @restaurant.errors.full_messages
        render :new
      end
    end

    @map = Gmaps4rails.build_markers([@restaurant]) do |res, marker|
      marker.lat res.latitude
      marker.lng res.longitude
      marker.json({title: res.name})
    end
  end

  def create
    @restaurant = Restaurant.new(input_params)
    @restaurant.user_id = current_user.id
    if params[:back]
      render :new
    else
      @restaurant.save!
      flash[:notice] = I18n.t('restaurant.created')
      redirect_to action: :index
    end
  end

  def edit
    @restaurant = Restaurant.find_by(id: params[:id], user_id: current_user.id)
  end

  def update
    @restaurant = Restaurant.find_by(id: params[:id], user_id: current_user.id)
    @restaurant.attributes = input_params
    if params[:back]
      render :edit
    else
      @restaurant.save!
      flash[:notice] = I18n.t('restaurant.updated')
      redirect_to action: :show, id: @restaurant.id
    end
  end

  def destroy
    restaurant = Restaurant.find_by(id: params[:id], user_id: current_user.id)
    restaurant.destroy!
    flash[:notice] = I18n.t('restaurant.deleted')
    redirect_to action: :index
  end

  private
  def input_params
    params.require(:restaurant).permit(:name, :telephone_number, :address, :has_private_room, :seat_count, :open_date, genre_ids: [], restaurant_images_attributes: [:id, :image, :image_cache])
  end
  
end
