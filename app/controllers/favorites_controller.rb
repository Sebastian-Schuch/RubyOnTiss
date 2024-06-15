# app/controllers/favorites_controller.rb
class FavoritesController < ApplicationController
  before_action :set_user
  include CoursesHelper

  def index
    @type = params[:type] || 'all'
    @sort = params[:sort] || ''

    @favorites = @user.favorites.includes(:favoritable)
    @favorites = @favorites.where(favoritable_type: @type) if @type.present? && @type != 'all'

    if @sort == 'title'
      @favorites = @favorites.sort_by { |f| f.favoritable.title_with_short.strip.downcase }
    else
      @favorites = @favorites.order(created_at: :asc)
    end
  end

  def create
    favoritable = find_or_create_favoritable(params[:type], create_favorite_params(params[:type]))
    favorite = @user.favorites.new(favoritable: favoritable)

    if favorite.save
      redirect_back fallback_location: root_path, notice: 'Added to favorites'
    else
      Rails.logger.debug { "Favorite save failed: #{favorite.errors.full_messages.join(', ')}" }
      redirect_back fallback_location: root_path, alert: 'Unable to add to favorites'
    end
  end

  def destroy
    favorite = @user.favorites.find(params[:id])
    favorite.destroy
    redirect_to favorites_path(type: params[:type], sort: params[:sort]), notice: 'Removed from favorites'
  end

  def edit
    @favorite = @user.favorites.find(params[:id])
  end

  def update
    @favorite = @user.favorites.find(params[:id])
    type = @favorite.favoritable_type
    params[:favorite].delete(:type) # Remove the type parameter
    Rails.logger.debug { "Update Params: #{update_favorite_params(type)}" }
    if @favorite.update(update_favorite_params(type))
      redirect_to favorites_path(type: params[:type], sort: params[:sort]), notice: 'Updated favorite'
    else
      render :edit
    end
  end

  def set_user
    authenticate_user
    @user = current_user
  end

  def create_favorite_params(type)
    case type
    when 'Person'
      params.permit(:type, :id, :firstname, :lastname, :gender, :prefix_title, :postfix_title, :adressbuch_benutzerbild, :adressbuch_visitenkarte)
    when 'Course'
      params.permit(:type, :id, :title, :short, :detail_url)
    when 'Project'
      params.permit(:type, :id, :title, :short, :detail_url, :detail_url_rest)
    when 'Thesis'
      params.permit(:type, :id, :title, :short, :detail_url)
    else
      Rails.logger.debug { "Unknown favoritable type: #{type}" }
      raise "Unknown favoritable type"
    end
  end

  def update_favorite_params(type)
    params.require(:favorite).permit(:keywords, :personal_notes)
  end

  def find_or_create_favoritable(type, attributes)
    case type
    when 'Person'
      Person.find_or_create_by(id: attributes[:id]) do |person|
        person.firstname = attributes[:firstname]
        person.lastname = attributes[:lastname]
        person.gender = attributes[:gender]
        person.prefix_title = attributes[:prefix_title]
        person.postfix_title = attributes[:postfix_title]
        person.adressbuch_benutzerbild = attributes[:adressbuch_benutzerbild]
        person.adressbuch_visitenkarte = attributes[:adressbuch_visitenkarte]
        person.save!
      end
    when 'Course'
      course_id = extract_parameters(attributes[:detail_url])
      Course.find_or_create_by(custom_id: course_id) do |course|
        course.title = attributes[:title]
        course.short = attributes[:short]
        course.detail_url = attributes[:detail_url]
        course.custom_id = course_id
        course.save!
      end
    when 'Project'
      Project.find_or_create_by(id: attributes[:id]) do |project|
        project.title = attributes[:title]
        project.short = attributes[:short]
        project.detail_url = attributes[:detail_url]
        project.detail_url_rest = attributes[:detail_url_rest]
        project.save!
      end
    when 'Thesis'
      Thesis.find_or_create_by(id: attributes[:id]) do |thesis|
        thesis.title = attributes[:title]
        thesis.short = attributes[:short]
        thesis.detail_url = attributes[:detail_url]
        thesis.save!
      end
    else
      raise "Unknown favoritable type"
    end
  end
end
