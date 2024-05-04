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

  def addFavorite(id)
    @id = id
    @time = Time.now
  end


end
