require_relative '../services/tiss_http_fetcher.rb'
require 'nokogiri'

class PersonController < MotherclassController
  before_action :index

  def setup
    @tiss_http_fetcher = TissHttpFetcher.new
  end

  def test
    render html: @search
  end

  def search
    render :index
  end

  def get_details

    parse_xml @person_detail

    render :detail
  end

  def parse_xml(xml)
    @firstname = xml.xpath("//firstname").text
    @lastname = xml.xpath("//lastname").text
    @pre_title = xml.xpath("//preceding_titles").text
    @picture = xml.xpath("//picture_uri").text
    @gender = xml.xpath("//gender").text
    if @gender == "M"
      @gender = "Herr"
    else if @gender == "F"
        @gender = "Frau"
      else
        @gender = ""
     end
    end
  end

  def addFavorite(id)
    @id = id
    @time = Time.now
  end


end
