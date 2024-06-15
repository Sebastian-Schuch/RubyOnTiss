
class PersonReportsController < ApplicationController
  before_action :set_user

  def show
    @person = Person.find(params[:id])
    @highlighted_text = params[:highlight]
  end

  private

  def set_user
    @user = User.first # Use the sample user for now
  end
end
