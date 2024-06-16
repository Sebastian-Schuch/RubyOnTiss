class ReportsController < ApplicationController
  before_action :set_user

  def index
    @types = ['Person', 'Course', 'Project', 'Thesis']
  end

  def show
    @type = params[:type]
    @with_annotations = params[:with_annotations] == 'true'
    @favorites = @user.favorites.where(favoritable_type: @type).includes(:favoritable)
  end

  private

  def set_user
    @user = current_user
  end
end
