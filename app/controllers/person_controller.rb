require_relative '../services/tiss_http_fetcher.rb'
require 'nokogiri'

class PersonController < MotherClassController
  before_action :index

  def parse_xml(xml)
    @firstname = xml.xpath("//firstname").text
    @lastname = xml.xpath("//lastname").text
    @pre_title = xml.xpath("//preceding_titles").text
    @picture = xml.xpath("//picture_uri").text
    @gender = xml.xpath("//gender").text
    if @gender == "M"
      @gender = "Herr"
    else if @gender == "W"
        @gender = "Frau"
      else
        @gender = ""
     end
    end
  end

  def full_report
    tiss_http_fetcher = TissHttpFetcher.new
    @detail = tiss_http_fetcher.get_person(params[:id])
    parse_xml(@detail)
    @regex = params[:q] || ""
    @projects = tiss_http_fetcher.search_project(@firstname+"+"+@lastname)
    @courses = tiss_http_fetcher.search_course(@firstname+"+"+@lastname)
    @theses = tiss_http_fetcher.search_thesis(@firstname+"+"+@lastname)
    render :report
  end

  def courses
    tiss_http_fetcher = TissHttpFetcher.new
    @detail = tiss_http_fetcher.get_person(params[:id])
    parse_xml(@detail)
    @courses = tiss_http_fetcher.search_course(@firstname+"+"+@lastname)
    render :courses
  end

  def theses
    tiss_http_fetcher = TissHttpFetcher.new
    @detail = tiss_http_fetcher.get_person(params[:id])
    parse_xml(@detail)
    @theses = tiss_http_fetcher.search_thesis(@firstname+"+"+@lastname)
    render :theses
  end

  def projects
    tiss_http_fetcher = TissHttpFetcher.new
    @detail = tiss_http_fetcher.get_person(params[:id])
    parse_xml(@detail)
    @projects = tiss_http_fetcher.search_project(@firstname+"+"+@lastname)
    render :projects
  end

  def highlight_search_term(content, term)
    regex = Regexp.new("(#{Regexp.escape(term)})", Regexp::IGNORECASE)
    content.gsub(regex, '<strong>\1</strong>')
  end

  def addFavorite(id)
    @id = id
    @time = Time.now
  end


end
