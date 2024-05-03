
require_relative '../services/tiss_http_fetcher.rb'
class MotherclassController < ApplicationController


  #This is the mother class that will be inherited by all other classes

  def index
    tiss_http_fetcher = TissHttpFetcher.new
    @siteName = "Application"
    case self.class.name
    when 'PersonController'
      @siteName = "Person"

      @searchDataResponse = []
      if params[:search].present?
        param = params[:search]
        @searchDataResponse = tiss_http_fetcher.search_people param
      end


    when 'CoursesController'
      @siteName = "Courses"
    when 'ThesesController'
      @siteName = "Thesis"
    when 'ProjectsController'
      @siteName = "Projects"
    else
      "This is a generic message for unknown controllers"
    end
  end

  #This method will be used to search for a specific item
  # #returns the search results in xml
  def search
    #@search = param
  end

  #This method will be used to get the details of a specific item
  # #returs the details of the item in xml
  def getDetails(id)
    @id = id

  end

  #This method will be used to parse the XML file
  # #returns the parsed XML file in plain text
  def parseXML(xml)
    @xml = xml

  end

  #This method will add an item to the favorites list
  def addFavorite(id)
    @id = id
    @time = Time.now
  end

end
