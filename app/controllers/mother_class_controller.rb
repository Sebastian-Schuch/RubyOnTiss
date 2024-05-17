
require_relative '../services/tiss_http_fetcher.rb'
class MotherClassController < ApplicationController


  #This is the mother class that will be inherited by all other classes

  def index
    tiss_http_fetcher = TissHttpFetcher.new
    @site_name = "Application"

    case self.class.name
    when 'PersonController'
      @site_name = "Person"

      @search_data_response = []
      if params[:search].present?
        @search_data_response = tiss_http_fetcher.search_people params[:search]
      end
      if params[:id].present?
        @detail = tiss_http_fetcher.get_person params[:id]
      end
    when 'CoursesController'
      @site_name = "Courses"
    when 'ThesesController'
      @site_name = "Theses"

      @search_data_response = []
      if params[:search].present?
        @search_data_response = tiss_http_fetcher.search_theses params[:search]
      end
      if params[:id].present?
        @detail = tiss_http_fetcher.get_theses params[:id]
      end
    when 'ProjectsController'
      @site_name = "Projects"
    else
      "This is a generic message for unknown controllers"
    end
  end

  #This method will be used to search for a specific item
  # renders a list of the items in the json data
  def search
    render :index
  end

  #This method will be used to get the details of a specific item
  # renders the details in the xml data
  def get_details
    parse_xml @detail
    render :detail
  end

  #This method will be used to parse the xml data
  def parse_xml(xml)

  end

  #This method will add an item to the favorites list
  def add_favorite(id)
  end

end
