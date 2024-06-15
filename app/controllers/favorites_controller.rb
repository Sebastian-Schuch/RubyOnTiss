# app/controllers/favorites_controller.rb
class FavoritesController < ApplicationController
  before_action :set_user

  def index
    @favorites = @user.favorites.order(:created_at)
    @favorites = @favorites.order(title: :asc) if params[:sort] == 'title'
  end

  def create
    favoritable = find_or_create_favoritable(params[:type], favorite_params(params[:type]))
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
    redirect_to favorites_path, notice: 'Removed from favorites'
  end

  def edit
    @favorite = @user.favorites.find(params[:id])
  end

  def update
    @favorite = @user.favorites.find(params[:id])
    if @favorite.update(favorite_params(params[:type]))
      redirect_to favorites_path, notice: 'Updated favorite'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.first # Use the sample user for now
  end

  def favorite_params(type)
    case type
    when 'Person'
      params.permit(:type, :id, :firstname, :lastname, :gender, :prefix_title, :postfix_title, :adressbuch_benutzerbild, :adressbuch_visitenkarte)
    when 'Course'
      params.permit(:type, :title, :short, :detail_url)
    when 'Project'
      params.permit(:type, :title, :short, :detail_url, :detail_url_rest)
    when 'Thesis'
      params.permit(:type, :title, :short, :detail_url)
    else
      raise "Unknown favoritable type"
    end
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
      Course.find_or_create_by(title: attributes[:title]) do |course|
        course.title = attributes[:title]
        course.short = attributes[:short]
        course.detail_url = attributes[:detail_url]
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
