require_relative '../services/tiss_http_fetcher.rb'

class PersonController < MotherclassController


  def test
    render html: @search
  end

  def search

    redirect_to action: :index, search: params[:search]


  end

  def getDetails(id)
    @id = id
  end

  def parseXML(xml)
    @xml = xml
  end

  def addFavorite(id)
    @id = id
    @time = Time.now
  end


end
